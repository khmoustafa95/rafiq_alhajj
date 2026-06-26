import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:rafiq_alhajj/core/utils/media_upload_io.dart'
    if (dart.library.js_interop) 'package:rafiq_alhajj/core/utils/media_upload_web.dart'
    as platform;
import 'package:rafiq_alhajj/core/utils/upload_validation.dart';

/// A picked (and possibly compressed) upload together with its in-memory bytes,
/// after validation.
class PickedUpload {
  const PickedUpload({required this.bytes, required this.fileName});

  final Uint8List bytes;
  final String fileName;
}

/// Picks a single file, compresses it on-device when possible (mobile video via
/// v_video_compressor, images via flutter_image_compress), then validates the
/// final bytes against [constraints].
///
/// On web compression is a no-op, so the file is validated by its reported size
/// *before* its bytes are used — keeping oversized files out without an OOM.
///
/// [onCompressProgress] reports compression progress (0..1) on mobile; it never
/// fires on web or for non-compressible [kind]s.
///
/// Returns `null` when the user cancels. Throws [UploadValidationException]
/// when the result is empty, an unsupported type, or too large.
Future<PickedUpload?> pickValidatedUpload(
  UploadConstraints constraints, {
  UploadMediaKind kind = UploadMediaKind.other,
  void Function(double progress)? onCompressProgress,
}) async {
  // Mobile picks by path (no in-memory load); web loads bytes eagerly.
  final result = await FilePicker.platform.pickFiles(withData: kIsWeb);
  if (result == null || result.files.isEmpty) {
    return null;
  }

  final file = result.files.first;
  final path = file.path;

  if (!kIsWeb &&
      path != null &&
      (kind == UploadMediaKind.image || kind == UploadMediaKind.video)) {
    final compressed = await platform.compressUpload(
      path: path,
      fileName: file.name,
      kind: kind,
      onProgress: onCompressProgress,
    );
    if (compressed != null) {
      validateUpload(
        fileName: compressed.fileName,
        byteLength: compressed.bytes.length,
        constraints: constraints,
      );
      return PickedUpload(
        bytes: compressed.bytes,
        fileName: compressed.fileName,
      );
    }
  }

  // No compression: validate by reported size first, then read the bytes.
  validateUpload(
    fileName: file.name,
    byteLength: file.size,
    constraints: constraints,
  );

  final bytes = await platform.readUploadBytes(file);
  if (bytes == null || bytes.isEmpty) {
    throw const UploadValidationException(UploadRejectionReason.emptyData);
  }
  return PickedUpload(bytes: bytes, fileName: file.name);
}
