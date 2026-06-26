import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:xml/xml.dart';

/// Lightweight tabular reader/writer for XLSX and CSV.
///
/// We deliberately avoid the `excel` package: it pins `archive ^3`, which
/// conflicts with `flutter_gen_runner`'s `archive ^4`. This codec is built on
/// the already-present `archive ^4` + `xml`, reads the first worksheet of an
/// XLSX (shared/inline strings, numbers, and date-formatted serials) and CSV,
/// and writes both. Every value is surfaced/stored as a `String`; the pilgrim
/// field catalog performs the type coercion downstream.
abstract final class TabularCodec {
  static const Set<String> _xlsxExtensions = {'xlsx'};

  static const String xlsxMimeType =
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
  static const String csvMimeType = 'text/csv';

  /// Decodes [bytes] of a file with [extension] into rows of string cells.
  /// The first row is normally the header row.
  static List<List<String>> decode(
    Uint8List bytes, {
    required String extension,
  }) {
    final ext = extension.toLowerCase().replaceAll('.', '');
    if (_xlsxExtensions.contains(ext)) {
      return _decodeXlsx(bytes);
    }
    return _decodeCsv(utf8.decode(bytes, allowMalformed: true));
  }

  /// Builds a minimal, Excel-compatible `.xlsx` (inline string cells) from
  /// [rows].
  static Uint8List encodeXlsx(
    List<List<String>> rows, {
    String sheetName = 'Sheet1',
  }) {
    final archive = Archive()
      ..addFile(ArchiveFile.string('[Content_Types].xml', _contentTypes))
      ..addFile(ArchiveFile.string('_rels/.rels', _rootRels))
      ..addFile(ArchiveFile.string('xl/workbook.xml', _workbook(sheetName)))
      ..addFile(
        ArchiveFile.string('xl/_rels/workbook.xml.rels', _workbookRels),
      )
      ..addFile(ArchiveFile.string('xl/styles.xml', _styles))
      ..addFile(ArchiveFile.string('xl/worksheets/sheet1.xml', _sheet(rows)));
    return Uint8List.fromList(ZipEncoder().encodeBytes(archive));
  }

  /// Builds a UTF-8 (BOM-prefixed, so Excel reads Arabic) CSV from [rows].
  static Uint8List encodeCsv(List<List<String>> rows) {
    final buffer = StringBuffer();
    for (final row in rows) {
      buffer.writeln(row.map(_csvField).join(','));
    }
    return Uint8List.fromList(utf8.encode('\uFEFF$buffer'));
  }

  // --- XLSX decoding -------------------------------------------------------

  static List<List<String>> _decodeXlsx(Uint8List bytes) {
    final archive = ZipDecoder().decodeBytes(bytes);

    String? readEntry(String name) {
      final file = archive.findFile(name);
      final data = file?.readBytes();
      return data == null ? null : utf8.decode(data, allowMalformed: true);
    }

    final sharedStrings = _sharedStrings(readEntry('xl/sharedStrings.xml'));
    final dateStyleIndices = _dateStyleIndices(readEntry('xl/styles.xml'));

    final sheetXml = readEntry(_firstSheetPath(readEntry));
    if (sheetXml == null) {
      return const [];
    }

    final doc = XmlDocument.parse(sheetXml);
    final rows = <List<String>>[];

    for (final row in doc.findAllElements('row')) {
      final cells = <int, String>{};
      var nextCol = 0;
      var maxCol = -1;

      for (final c in row.findAllElements('c')) {
        var colIndex = _columnIndex(c.getAttribute('r') ?? '');
        if (colIndex < 0) {
          colIndex = nextCol;
        }
        nextCol = colIndex + 1;

        cells[colIndex] = _cellValue(c, sharedStrings, dateStyleIndices);
        if (colIndex > maxCol) {
          maxCol = colIndex;
        }
      }

      rows.add(List<String>.generate(maxCol + 1, (i) => cells[i] ?? ''));
    }

    return rows;
  }

  static String _cellValue(
    XmlElement c,
    List<String> sharedStrings,
    Set<int> dateStyleIndices,
  ) {
    final type = c.getAttribute('t');
    final rawValue =
        c.findElements('v').isEmpty ? '' : c.findElements('v').first.innerText;

    switch (type) {
      case 's':
        final idx = int.tryParse(rawValue) ?? -1;
        return (idx >= 0 && idx < sharedStrings.length)
            ? sharedStrings[idx]
            : '';
      case 'inlineStr':
        final buffer = StringBuffer();
        for (final t in c.findAllElements('t')) {
          buffer.write(t.innerText);
        }
        return buffer.toString();
      case 'str':
        return rawValue;
      case 'b':
        return rawValue == '1' ? 'true' : 'false';
      default:
        if (rawValue.isEmpty) {
          return '';
        }
        final asNum = double.tryParse(rawValue);
        final styleIndex = int.tryParse(c.getAttribute('s') ?? '');
        if (asNum != null &&
            styleIndex != null &&
            dateStyleIndices.contains(styleIndex)) {
          return _excelSerialToIsoDate(asNum);
        }
        if (asNum != null && asNum == asNum.roundToDouble()) {
          return asNum.toInt().toString();
        }
        return rawValue;
    }
  }

  static List<String> _sharedStrings(String? xml) {
    if (xml == null) {
      return const [];
    }
    final doc = XmlDocument.parse(xml);
    final result = <String>[];
    for (final si in doc.findAllElements('si')) {
      final buffer = StringBuffer();
      for (final t in si.findAllElements('t')) {
        buffer.write(t.innerText);
      }
      result.add(buffer.toString());
    }
    return result;
  }

  static Set<int> _dateStyleIndices(String? xml) {
    final result = <int>{};
    if (xml == null) {
      return result;
    }
    final doc = XmlDocument.parse(xml);

    // Built-in date/time number formats plus any custom format whose code
    // looks like a date.
    final dateFmtIds = <int>{14, 15, 16, 17, 18, 19, 20, 21, 22, 45, 46, 47};
    for (final numFmt in doc.findAllElements('numFmt')) {
      final id = int.tryParse(numFmt.getAttribute('numFmtId') ?? '');
      final code = numFmt.getAttribute('formatCode')?.toLowerCase() ?? '';
      if (id != null && _looksLikeDate(code)) {
        dateFmtIds.add(id);
      }
    }

    final cellXfs = doc.findAllElements('cellXfs');
    if (cellXfs.isEmpty) {
      return result;
    }
    var index = 0;
    for (final xf in cellXfs.first.findElements('xf')) {
      final numFmtId = int.tryParse(xf.getAttribute('numFmtId') ?? '');
      if (numFmtId != null && dateFmtIds.contains(numFmtId)) {
        result.add(index);
      }
      index++;
    }
    return result;
  }

  static bool _looksLikeDate(String code) {
    final stripped = code
        .replaceAll(RegExp(r'\[[^\]]*\]'), '')
        .replaceAll(RegExp('"[^"]*"'), '');
    return RegExp(r'[ymd]').hasMatch(stripped) && !stripped.contains('general');
  }

  static String _firstSheetPath(String? Function(String) readEntry) {
    final relTargets = <String, String>{};
    final relsXml = readEntry('xl/_rels/workbook.xml.rels');
    if (relsXml != null) {
      final doc = XmlDocument.parse(relsXml);
      for (final rel in doc.findAllElements('Relationship')) {
        final id = rel.getAttribute('Id');
        final target = rel.getAttribute('Target');
        if (id != null && target != null) {
          relTargets[id] = target;
        }
      }
    }

    final workbookXml = readEntry('xl/workbook.xml');
    if (workbookXml != null) {
      final doc = XmlDocument.parse(workbookXml);
      final sheets = doc.findAllElements('sheet');
      if (sheets.isNotEmpty) {
        final rid = sheets.first.getAttribute('r:id') ??
            sheets.first.getAttribute('id');
        final target = rid == null ? null : relTargets[rid];
        if (target != null) {
          if (target.startsWith('/')) {
            return target.substring(1);
          }
          return 'xl/$target'.replaceAll('xl/xl/', 'xl/');
        }
      }
    }

    return 'xl/worksheets/sheet1.xml';
  }

  static int _columnIndex(String ref) {
    var col = 0;
    var found = false;
    for (final code in ref.codeUnits) {
      if (code >= 65 && code <= 90) {
        col = col * 26 + (code - 64);
        found = true;
      } else if (code >= 97 && code <= 122) {
        col = col * 26 + (code - 96);
        found = true;
      } else {
        break;
      }
    }
    return found ? col - 1 : -1;
  }

  static String _excelSerialToIsoDate(double serial) {
    // Excel's day 0 is 1899-12-30 (it incorrectly treats 1900 as a leap year).
    final date = DateTime(1899, 12, 30).add(Duration(days: serial.floor()));
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  // --- CSV -----------------------------------------------------------------

  static List<List<String>> _decodeCsv(String content) {
    var text = content;
    if (text.startsWith('\uFEFF')) {
      text = text.substring(1);
    }

    final rows = <List<String>>[];
    var row = <String>[];
    final field = StringBuffer();
    var inQuotes = false;

    for (var i = 0; i < text.length; i++) {
      final ch = text[i];
      if (inQuotes) {
        if (ch == '"') {
          if (i + 1 < text.length && text[i + 1] == '"') {
            field.write('"');
            i++;
          } else {
            inQuotes = false;
          }
        } else {
          field.write(ch);
        }
        continue;
      }

      switch (ch) {
        case '"':
          inQuotes = true;
        case ',':
          row.add(field.toString());
          field.clear();
        case '\n':
          row.add(field.toString());
          field.clear();
          rows.add(row);
          row = <String>[];
        case '\r':
          break;
        default:
          field.write(ch);
      }
    }

    if (field.isNotEmpty || row.isNotEmpty) {
      row.add(field.toString());
      rows.add(row);
    }
    return rows;
  }

  static String _csvField(String value) {
    if (value.contains(',') ||
        value.contains('"') ||
        value.contains('\n') ||
        value.contains('\r')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }

  // --- XLSX encoding -------------------------------------------------------

  static String _sheet(List<List<String>> rows) {
    final buffer = StringBuffer()
      ..write('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
      ..write(
        '<worksheet xmlns="http://schemas.openxmlformats.org/'
        'spreadsheetml/2006/main"><sheetData>',
      );

    for (var r = 0; r < rows.length; r++) {
      buffer.write('<row r="${r + 1}">');
      final cells = rows[r];
      for (var c = 0; c < cells.length; c++) {
        final value = cells[c];
        if (value.isEmpty) {
          continue;
        }
        final ref = '${_columnLetters(c)}${r + 1}';
        buffer.write(
          '<c r="$ref" t="inlineStr"><is><t xml:space="preserve">'
          '${_xmlEscape(value)}</t></is></c>',
        );
      }
      buffer.write('</row>');
    }

    buffer.write('</sheetData></worksheet>');
    return buffer.toString();
  }

  static String _columnLetters(int index) {
    var n = index;
    var letters = '';
    while (n >= 0) {
      letters = String.fromCharCode(65 + n % 26) + letters;
      n = n ~/ 26 - 1;
    }
    return letters;
  }

  static String _xmlEscape(String value) => value
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&apos;');

  static const String _contentTypes =
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '<Types xmlns="http://schemas.openxmlformats.org/package/2006/'
      'content-types">'
      '<Default Extension="rels" ContentType="application/'
      'vnd.openxmlformats-package.relationships+xml"/>'
      '<Default Extension="xml" ContentType="application/xml"/>'
      '<Override PartName="/xl/workbook.xml" ContentType="application/'
      'vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>'
      '<Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/'
      'vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>'
      '<Override PartName="/xl/styles.xml" ContentType="application/'
      'vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>'
      '</Types>';

  static const String _rootRels =
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/'
      'relationships">'
      '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/'
      'officeDocument/2006/relationships/officeDocument" '
      'Target="xl/workbook.xml"/>'
      '</Relationships>';

  static const String _workbookRels =
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/'
      'relationships">'
      '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/'
      'officeDocument/2006/relationships/worksheet" '
      'Target="worksheets/sheet1.xml"/>'
      '<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/'
      'officeDocument/2006/relationships/styles" Target="styles.xml"/>'
      '</Relationships>';

  static const String _styles =
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
      '<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/'
      '2006/main">'
      '<fonts count="1"><font><sz val="11"/><name val="Calibri"/></font>'
      '</fonts>'
      '<fills count="1"><fill><patternFill patternType="none"/></fill></fills>'
      '<borders count="1"><border/></borders>'
      '<cellStyleXfs count="1">'
      '<xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>'
      '<cellXfs count="1">'
      '<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>'
      '</cellXfs>'
      '</styleSheet>';

  static String _workbook(String sheetName) {
    final name = _xmlEscape(
      sheetName.length > 31 ? sheetName.substring(0, 31) : sheetName,
    );
    return '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
        '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/'
        '2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/'
        '2006/relationships">'
        '<sheets><sheet name="$name" sheetId="1" r:id="rId1"/></sheets>'
        '</workbook>';
  }
}
