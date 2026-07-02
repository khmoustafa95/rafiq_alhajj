import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase Storage access for pilgrim/admin content media buckets.
class ContentMediaRemoteDataSource {
  const ContentMediaRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const bucket = 'content-media';
  static const bucketPrivate = 'content-media-private';

  Future<void> uploadBinary({
    required String targetBucket,
    required String path,
    required Uint8List bytes,
    required String? contentType,
  }) {
    return _client.storage.from(targetBucket).uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(upsert: true, contentType: contentType),
        );
  }

  Future<void> uploadWithProgress({
    required Dio dio,
    required String targetBucket,
    required String path,
    required Uint8List bytes,
    required String? contentType,
    required void Function(double progress) onProgress,
  }) async {
    final token =
        _client.auth.currentSession?.accessToken ?? AppConfig.supabaseAnonKey;
    final uri =
        '${AppConfig.supabaseUrl}/storage/v1/object/$targetBucket/$path';

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
  }

  Future<Uint8List> download({
    required String fromBucket,
    required String path,
  }) {
    return _client.storage.from(fromBucket).download(path);
  }

  Future<String> createSignedUrl({
    required String path,
    required int ttlSeconds,
  }) {
    return _client.storage
        .from(bucketPrivate)
        .createSignedUrl(path, ttlSeconds);
  }

  Future<void> remove({
    required String fromBucket,
    required List<String> paths,
  }) {
    return _client.storage.from(fromBucket).remove(paths);
  }

  String getPublicUrl(String path) {
    return _client.storage.from(bucket).getPublicUrl(path);
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
