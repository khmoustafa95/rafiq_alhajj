import 'package:flutter/foundation.dart';

/// Why an upload was rejected client-side. The presentation layer maps these to
/// localized messages (services/utils stay l10n-free).
enum UploadRejectionReason { emptyData, unsupportedType, tooLarge }

/// Media family of a pending upload. Drives on-device compression: only
/// [image] and [video] are compressible; [audio]/[other] are uploaded as-is.
enum UploadMediaKind { image, video, audio, other }

/// Thrown by [validateUpload] before any bytes leave the device so the UI can
/// show a precise, localized reason instead of a generic "upload failed".
class UploadValidationException implements Exception {
  const UploadValidationException(
    this.reason, {
    this.fileName,
    this.maxBytes,
  });

  final UploadRejectionReason reason;
  final String? fileName;
  final int? maxBytes;

  @override
  String toString() =>
      'UploadValidationException($reason, file: $fileName, max: $maxBytes)';
}

/// Size + type rules for a single upload, with presets per media category.
///
/// Limits are deliberately kept under the Supabase storage `file_size_limit`
/// (50 MiB by default) so the client rejects oversized files with a clear
/// message before the server returns an opaque 413.
@immutable
class UploadConstraints {
  const UploadConstraints({
    required this.allowedExtensions,
    required this.maxBytes,
  });

  final Set<String> allowedExtensions;
  final int maxBytes;

  static const int _mb = 1024 * 1024;

  int get maxMegabytes => maxBytes ~/ _mb;

  /// Images: covers, gallery photos.
  static const image = UploadConstraints(
    allowedExtensions: {'jpg', 'jpeg', 'png', 'webp', 'gif'},
    maxBytes: 10 * _mb,
  );

  /// Audio clips (recitations, talks).
  static const audio = UploadConstraints(
    allowedExtensions: {'mp3', 'm4a', 'aac', 'wav', 'ogg'},
    maxBytes: 30 * _mb,
  );

  /// Short hosted video. Large/long videos should use external links
  /// (YouTube/Vimeo) instead of self-hosting raw blobs.
  static const video = UploadConstraints(
    allowedExtensions: {'mp4', 'webm', 'mov'},
    maxBytes: 45 * _mb,
  );

  /// Pilgrim identity documents (private bucket).
  static const pilgrimDocuments = UploadConstraints(
    allowedExtensions: {'pdf', 'jpg', 'jpeg', 'png'},
    maxBytes: 10 * _mb,
  );
}

/// Lower-cased file extension without the dot, or `null` when absent.
String? fileExtension(String fileName) {
  final dot = fileName.lastIndexOf('.');
  if (dot < 0 || dot == fileName.length - 1) {
    return null;
  }
  return fileName.substring(dot + 1).toLowerCase();
}

/// Replaces unsafe characters so storage object keys stay predictable.
String sanitizeUploadFileName(String fileName) =>
    fileName.replaceAll(RegExp(r'[^\w.\-]'), '_');

/// Best-effort MIME type from a file extension. Setting the correct
/// `Content-Type` on upload is what lets browsers stream video/audio inline.
String? mimeFromExtension(String? extension) {
  return switch (extension?.toLowerCase()) {
    'pdf' => 'application/pdf',
    'jpg' || 'jpeg' => 'image/jpeg',
    'png' => 'image/png',
    'webp' => 'image/webp',
    'gif' => 'image/gif',
    'mp4' => 'video/mp4',
    'webm' => 'video/webm',
    'mov' => 'video/quicktime',
    'mp3' => 'audio/mpeg',
    'm4a' => 'audio/mp4',
    'aac' => 'audio/aac',
    'wav' => 'audio/wav',
    'ogg' => 'audio/ogg',
    _ => null,
  };
}

/// Validates a pending upload against [constraints]. Throws
/// [UploadValidationException] (never returns false) so callers can surface the
/// exact reason. Runs purely client-side; storage RLS is the server-side guard.
void validateUpload({
  required String fileName,
  required int byteLength,
  required UploadConstraints constraints,
}) {
  if (byteLength <= 0) {
    throw UploadValidationException(
      UploadRejectionReason.emptyData,
      fileName: fileName,
    );
  }

  final extension = fileExtension(fileName);
  if (extension == null || !constraints.allowedExtensions.contains(extension)) {
    throw UploadValidationException(
      UploadRejectionReason.unsupportedType,
      fileName: fileName,
    );
  }

  if (byteLength > constraints.maxBytes) {
    throw UploadValidationException(
      UploadRejectionReason.tooLarge,
      fileName: fileName,
      maxBytes: constraints.maxBytes,
    );
  }
}
