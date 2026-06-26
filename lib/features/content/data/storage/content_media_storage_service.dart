import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/utils/upload_validation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContentMediaStorageException implements Exception {
  const ContentMediaStorageException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Content media upload failed';
}

class ContentMediaStorageService {
  ContentMediaStorageService([SupabaseClient? client]) : _client = client;

  /// Public bucket: media for `public` topics (anon-readable).
  static const bucket = 'content-media';

  /// Private bucket: media for `pilgrim_only` topics. Served via short-lived
  /// signed URLs; objects are referenced in the DB as `private://<path>`.
  static const bucketPrivate = 'content-media-private';

  /// Sentinel prefix stored in `content_topic_media.url` for private objects.
  static const privateScheme = 'private://';

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  /// True when [ref] points at the private bucket (`private://...`).
  static bool isPrivateRef(String ref) =>
      ref.trim().startsWith(privateScheme);

  /// The in-bucket object path for a `private://` ref, or `null`.
  static String? privatePathFromRef(String ref) {
    final trimmed = ref.trim();
    if (!trimmed.startsWith(privateScheme)) {
      return null;
    }
    final path = trimmed.substring(privateScheme.length).split('?').first;
    return path.isEmpty ? null : path;
  }

  /// Uploads [bytes] to the public or private bucket (per [isPrivate]) and
  /// returns a public URL (public bucket) or a `private://<path>` ref (private
  /// bucket) to store in the DB.
  ///
  /// Validation ([validateUpload]) runs first and throws
  /// [UploadValidationException] so the UI can show a precise reason before any
  /// bytes leave the device. When [onProgress] is provided the upload streams
  /// via Dio for real send-progress; otherwise it uses the Supabase client.
  Future<String> uploadBytes({
    required Uint8List bytes,
    required String fileName,
    UploadConstraints constraints = UploadConstraints.image,
    String? topicId,
    String folder = 'media',
    bool isPrivate = false,
    void Function(double progress)? onProgress,
  }) async {
    if (!isAvailable) {
      throw const ContentMediaStorageException('Supabase unavailable');
    }

    validateUpload(
      fileName: fileName,
      byteLength: bytes.length,
      constraints: constraints,
    );

    final targetBucket = isPrivate ? bucketPrivate : bucket;
    final path = _buildPath(
      topicId: topicId,
      folder: folder,
      fileName: fileName,
    );
    final contentType = mimeFromExtension(fileExtension(fileName));

    try {
      if (onProgress != null) {
        await _uploadWithProgress(
          targetBucket: targetBucket,
          path: path,
          bytes: bytes,
          contentType: contentType,
          onProgress: onProgress,
        );
      } else {
        await _client!.storage.from(targetBucket).uploadBinary(
              path,
              bytes,
              fileOptions: FileOptions(upsert: true, contentType: contentType),
            );
      }
      return isPrivate
          ? '$privateScheme$path'
          : _client!.storage.from(bucket).getPublicUrl(path);
    } on StorageException catch (e) {
      throw ContentMediaStorageException(e.message);
    }
  }

  /// Creates a short-lived signed URL for a `private://` [ref] so a pilgrim can
  /// stream/download it. Requires the caller to have storage SELECT permission
  /// on the private bucket (enforced by RLS).
  Future<String?> createSignedUrl(
    String ref, {
    int ttlSeconds = 7200,
  }) async {
    if (!isAvailable) {
      return null;
    }
    final path = privatePathFromRef(ref);
    if (path == null) {
      return null;
    }
    try {
      return await _client!.storage
          .from(bucketPrivate)
          .createSignedUrl(path, ttlSeconds);
    } on StorageException {
      return null;
    }
  }

  /// Ensures [ref] lives in the bucket matching the topic's visibility. When it
  /// already does (or is an external link we don't own), returns [ref]
  /// unchanged. Otherwise copies the object across buckets, deletes the old one,
  /// and returns the new ref. Best-effort: on any failure the original ref is
  /// returned so a save is never blocked.
  Future<String> ensureBucketForRef(
    String ref, {
    required bool wantPrivate,
    String? topicId,
    String folder = 'media',
  }) async {
    if (!isAvailable || ref.trim().isEmpty) {
      return ref;
    }
    final isPriv = isPrivateRef(ref);
    if (isPriv == wantPrivate) {
      return ref;
    }

    final sourceBucket = isPriv ? bucketPrivate : bucket;
    final sourcePath =
        isPriv ? privatePathFromRef(ref) : _storagePathFromPublicUrl(ref);
    if (sourcePath == null) {
      // External link (e.g. YouTube/Vimeo) — nothing to re-home.
      return ref;
    }

    try {
      final bytes = await _client!.storage.from(sourceBucket).download(sourcePath);
      final fileName = sourcePath.split('/').last;
      final contentType = mimeFromExtension(fileExtension(fileName));
      final targetBucket = wantPrivate ? bucketPrivate : bucket;
      final newPath = _buildPath(
        topicId: topicId,
        folder: folder,
        fileName: fileName,
      );
      await _client.storage.from(targetBucket).uploadBinary(
            newPath,
            bytes,
            fileOptions: FileOptions(upsert: true, contentType: contentType),
          );
      await _client.storage.from(sourceBucket).remove([sourcePath]);
      return wantPrivate
          ? '$privateScheme$newPath'
          : _client.storage.from(bucket).getPublicUrl(newPath);
    } on StorageException {
      return ref;
    }
  }

  /// Deletes previously uploaded objects by their stored refs (public URLs or
  /// `private://` paths). Best-effort: external links and failures are ignored
  /// so a save is never blocked by orphan cleanup.
  Future<void> removeStorageRefs(Iterable<String> refs) async {
    if (!isAvailable) {
      return;
    }
    final publicPaths = <String>[];
    final privatePaths = <String>[];
    for (final ref in refs) {
      if (isPrivateRef(ref)) {
        final path = privatePathFromRef(ref);
        if (path != null) {
          privatePaths.add(path);
        }
      } else {
        final path = _storagePathFromPublicUrl(ref);
        if (path != null) {
          publicPaths.add(path);
        }
      }
    }
    await _removeFrom(bucket, publicPaths);
    await _removeFrom(bucketPrivate, privatePaths);
  }

  Future<void> _removeFrom(String fromBucket, List<String> paths) async {
    if (paths.isEmpty) {
      return;
    }
    try {
      await _client!.storage.from(fromBucket).remove(paths);
    } on StorageException {
      // Orphan cleanup is best-effort; never surface to the caller.
    }
  }

  String _buildPath({
    required String? topicId,
    required String folder,
    required String fileName,
  }) {
    final safeName = sanitizeUploadFileName(fileName);
    final prefix = topicId?.trim().isNotEmpty == true ? topicId!.trim() : 'draft';
    return '$prefix/$folder/${DateTime.now().millisecondsSinceEpoch}_$safeName';
  }

  /// Extracts the in-bucket object path from a public URL, or `null` if the URL
  /// does not point at the public bucket.
  String? _storagePathFromPublicUrl(String url) {
    const marker = '/object/public/$bucket/';
    final index = url.indexOf(marker);
    if (index < 0) {
      return null;
    }
    final raw = url.substring(index + marker.length).split('?').first;
    return raw.isEmpty ? null : Uri.decodeComponent(raw);
  }

  Future<void> _uploadWithProgress({
    required String targetBucket,
    required String path,
    required Uint8List bytes,
    required String? contentType,
    required void Function(double progress) onProgress,
  }) async {
    final token =
        _client!.auth.currentSession?.accessToken ?? AppConfig.supabaseAnonKey;
    final uri = '${AppConfig.supabaseUrl}/storage/v1/object/$targetBucket/$path';
    final dio = Dio();

    try {
      await dio.post<dynamic>(
        uri,
        data: kIsWeb ? bytes : _chunked(bytes),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'apikey': AppConfig.supabaseAnonKey,
            'x-upsert': 'true',
            'cache-control': '3600',
            'content-length': bytes.length,
            'content-type': ?contentType,
          },
        ),
        onSendProgress: (sent, total) {
          if (total > 0) {
            onProgress((sent / total).clamp(0.0, 1.0));
          }
        },
      );
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = data is Map
          ? (data['message'] ?? data['error'])?.toString()
          : e.message;
      throw ContentMediaStorageException(message);
    } finally {
      dio.close(force: true);
    }
  }

  Stream<List<int>> _chunked(Uint8List bytes, [int chunkSize = 64 * 1024]) async* {
    for (var i = 0; i < bytes.length; i += chunkSize) {
      yield bytes.sublist(
        i,
        i + chunkSize > bytes.length ? bytes.length : i + chunkSize,
      );
    }
  }
}
