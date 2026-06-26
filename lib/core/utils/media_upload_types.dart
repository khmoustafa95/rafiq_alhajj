import 'dart:typed_data';

/// Result of a successful client-side compression: the smaller bytes plus the
/// adjusted file name (extension may change, e.g. `.mov` -> `.mp4`).
class CompressedUpload {
  const CompressedUpload({required this.bytes, required this.fileName});

  final Uint8List bytes;
  final String fileName;
}

/// Returns [fileName] with its extension replaced by [extension] (no dot).
String swapExtension(String fileName, String extension) {
  final dot = fileName.lastIndexOf('.');
  final base = dot <= 0 ? fileName : fileName.substring(0, dot);
  return '$base.$extension';
}
