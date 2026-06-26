import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:rafiq_alhajj/core/utils/media_upload_types.dart';
import 'package:rafiq_alhajj/core/utils/upload_validation.dart';

/// Web: the native compressors (v_video_compressor, flutter_image_compress)
/// have no web implementation, so compression is a no-op here. Large media on
/// web should use external links (YouTube/Vimeo); the upload size cap rejects
/// anything oversized before it reaches storage.
Future<CompressedUpload?> compressUpload({
  required String path,
  required String fileName,
  required UploadMediaKind kind,
  void Function(double progress)? onProgress,
}) async =>
    null;

/// On web the picker always loads bytes into memory (`withData: true`).
Future<Uint8List?> readUploadBytes(PlatformFile file) async => file.bytes;
