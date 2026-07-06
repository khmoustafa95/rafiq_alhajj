import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/core/utils/tabular_codec.dart';

void main() {
  group('TabularCodec CSV', () {
    test('decode parses UTF-8 BOM CSV', () {
      const raw = '\uFEFFpassport_number,full_name_ar\nP123,أحمد';
      final rows = TabularCodec.decode(
        Uint8List.fromList(utf8.encode(raw)),
        extension: 'csv',
      );
      expect(rows.length, 2);
      expect(rows[0], ['passport_number', 'full_name_ar']);
      expect(rows[1][0], 'P123');
    });

    test('encodeCsv prefixes BOM for Excel', () {
      final bytes = TabularCodec.encodeCsv([
        ['a', 'b'],
        ['1', '2'],
      ]);
      expect(bytes.length, greaterThan(3));
      expect(bytes[0], 0xEF);
      expect(bytes[1], 0xBB);
      expect(bytes[2], 0xBF);
    });
  });

  group('TabularCodec XLSX round-trip', () {
    test('encode then decode preserves inline strings', () {
      final source = [
        ['passport_number', 'full_name_ar'],
        ['P999', 'محمد'],
      ];
      final xlsx = TabularCodec.encodeXlsx(source);
      final decoded = TabularCodec.decode(xlsx, extension: 'xlsx');
      expect(decoded.length, 2);
      expect(decoded[0][0], 'passport_number');
      expect(decoded[1][0], 'P999');
      expect(decoded[1][1], 'محمد');
    });
  });
}
