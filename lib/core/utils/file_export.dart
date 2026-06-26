import 'dart:typed_data';

import 'package:rafiq_alhajj/core/utils/file_export_io.dart'
    if (dart.library.js_interop) 'package:rafiq_alhajj/core/utils/file_export_web.dart'
    as impl;

/// Cross-platform "save bytes to a file the user can keep".
///
/// On web this triggers a browser download (returns `null`). On mobile/desktop
/// it writes the file to a downloads/documents directory and returns the saved
/// path so the caller can surface it.
abstract final class FileExport {
  static Future<String?> saveBytes({
    required String fileName,
    required Uint8List bytes,
    String mimeType = 'application/octet-stream',
  }) {
    return impl.saveBytes(
      fileName: fileName,
      bytes: bytes,
      mimeType: mimeType,
    );
  }
}
