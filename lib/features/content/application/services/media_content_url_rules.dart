import 'package:rafiq_alhajj/features/content/data/storage/content_media_storage_service.dart';

/// Decides which refs can be stored offline.
abstract final class ContentMediaUrlRules {
  static bool isCacheable(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) {
      return false;
    }
    // Private bucket refs are always downloadable (resolved via signed URL).
    if (ContentMediaStorageService.isPrivateRef(trimmed)) {
      return true;
    }
    if (trimmed.startsWith('file://')) {
      return false;
    }
    final lower = trimmed.toLowerCase();
    // External players (YouTube/Vimeo) can't be saved as plain media files.
    if (lower.contains('youtube.com') ||
        lower.contains('youtu.be') ||
        lower.contains('vimeo.com')) {
      return false;
    }
    return trimmed.startsWith('http://') || trimmed.startsWith('https://');
  }
}

class MediaCacheException implements Exception {
  const MediaCacheException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Shared filename extension inference for encrypted/decrypted media files.
abstract final class MediaFileNaming {
  static String extensionFor({
    required String? mimeType,
    required String ref,
    required String mediaType,
  }) {
    final mime = mimeType?.toLowerCase() ?? '';
    if (mime.contains('mp4')) return '.mp4';
    if (mime.contains('webm')) return '.webm';
    if (mime.contains('quicktime')) return '.mov';
    if (mime.contains('mpeg') && mediaType == 'audio') return '.mp3';
    if (mime.contains('aac')) return '.aac';
    if (mime.contains('wav')) return '.wav';
    if (mime.contains('ogg')) return '.ogg';
    if (mime.contains('png')) return '.png';
    if (mime.contains('webp')) return '.webp';
    if (mime.contains('gif')) return '.gif';
    if (mime.contains('jpeg') || mime.contains('jpg')) return '.jpg';
    if (mime.contains('pdf')) return '.pdf';

    final path = Uri.tryParse(ref)?.path ?? ref;
    final dot = path.lastIndexOf('.');
    if (dot != -1 && dot < path.length - 1) {
      final ext = path.substring(dot);
      if (ext.length <= 6 && !ext.contains('/')) {
        return ext;
      }
    }
    return switch (mediaType) {
      'audio' => '.mp3',
      'image' => '.jpg',
      'pdf' => '.pdf',
      _ => '.mp4',
    };
  }
}
