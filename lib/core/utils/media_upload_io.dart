import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:rafiq_alhajj/core/utils/media_upload_types.dart';
import 'package:rafiq_alhajj/core/utils/upload_validation.dart';
import 'package:v_video_compressor/v_video_compressor.dart';

final VVideoCompressor _videoCompressor = VVideoCompressor();

/// Mobile/desktop: compress video (v_video_compressor) and images
/// (flutter_image_compress) on-device before upload. Reads from the picked file
/// path so a large source is never loaded fully into memory.
///
/// Returns `null` when compression does not apply (audio/other), is not
/// supported, or does not actually shrink the file — the caller then uploads
/// the original bytes.
Future<CompressedUpload?> compressUpload({
  required String path,
  required String fileName,
  required UploadMediaKind kind,
  void Function(double progress)? onProgress,
}) async {
  switch (kind) {
    case UploadMediaKind.video:
      return _compressVideo(
        path: path,
        fileName: fileName,
        onProgress: onProgress,
      );
    case UploadMediaKind.image:
      return _compressImage(path: path, fileName: fileName);
    case UploadMediaKind.audio:
    case UploadMediaKind.other:
      return null;
  }
}

Future<CompressedUpload?> _compressVideo({
  required String path,
  required String fileName,
  void Function(double progress)? onProgress,
}) async {
  final original = await _safeLength(path);
  final result = await _videoCompressor.compressVideo(
    path,
    const VVideoCompressionConfig.medium(),
    onProgress: onProgress,
  );
  final outputPath = result?.compressedFilePath;
  if (outputPath == null) {
    return null;
  }
  final bytes = await File(outputPath).readAsBytes();
  if (bytes.isEmpty || (original != null && bytes.length >= original)) {
    return null;
  }
  return CompressedUpload(
    bytes: bytes,
    fileName: swapExtension(fileName, 'mp4'),
  );
}

Future<CompressedUpload?> _compressImage({
  required String path,
  required String fileName,
}) async {
  final original = await _safeLength(path);
  final bytes = await FlutterImageCompress.compressWithFile(
    path,
    quality: 80,
    minHeight: 1920,
  );
  if (bytes == null || bytes.isEmpty) {
    return null;
  }
  if (original != null && bytes.length >= original) {
    return null;
  }
  return CompressedUpload(
    bytes: bytes,
    fileName: swapExtension(fileName, 'jpg'),
  );
}

/// Reads the picked file bytes from memory when available, otherwise from disk.
Future<Uint8List?> readUploadBytes(PlatformFile file) async {
  if (file.bytes != null) {
    return file.bytes;
  }
  final path = file.path;
  if (path == null) {
    return null;
  }
  return File(path).readAsBytes();
}

Future<int?> _safeLength(String path) async {
  try {
    return await File(path).length();
  } catch (_) {
    return null;
  }
}
