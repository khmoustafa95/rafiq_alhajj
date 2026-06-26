import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

/// Mobile/desktop implementation: write [bytes] to a downloads/documents
/// directory and return the absolute path.
Future<String?> saveBytes({
  required String fileName,
  required Uint8List bytes,
  String mimeType = 'application/octet-stream',
}) async {
  final directory = await _targetDirectory();
  final path = '${directory.path}${Platform.pathSeparator}$fileName';
  final file = File(path);
  await file.create(recursive: true);
  await file.writeAsBytes(bytes, flush: true);
  return path;
}

Future<Directory> _targetDirectory() async {
  try {
    final downloads = await getDownloadsDirectory();
    if (downloads != null) {
      return downloads;
    }
  } on Object {
    // getDownloadsDirectory is unsupported on some platforms (e.g. Android).
  }
  try {
    final external = await getExternalStorageDirectory();
    if (external != null) {
      return external;
    }
  } on Object {
    // Not available on iOS.
  }
  return getApplicationDocumentsDirectory();
}
