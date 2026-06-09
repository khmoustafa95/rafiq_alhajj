import 'dart:typed_data';

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContentMediaStorageException implements Exception {
  const ContentMediaStorageException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Content media upload failed';
}

class ContentMediaStorageService {
  ContentMediaStorageService([SupabaseClient? client]) : _client = client;

  static const bucket = 'content-media';

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<String> uploadBytes({
    required Uint8List bytes,
    required String fileName,
    String? topicId,
    String folder = 'media',
  }) async {
    if (!isAvailable) {
      throw const ContentMediaStorageException('Supabase unavailable');
    }

    final safeName = fileName.replaceAll(RegExp(r'[^\w.\-]'), '_');
    final prefix = topicId?.trim().isNotEmpty == true ? topicId!.trim() : 'draft';
    final path =
        '$prefix/$folder/${DateTime.now().millisecondsSinceEpoch}_$safeName';

    try {
      await _client!.storage.from(bucket).uploadBinary(
            path,
            bytes,
            fileOptions: const FileOptions(upsert: true),
          );
      return _client.storage.from(bucket).getPublicUrl(path);
    } on StorageException catch (e) {
      throw ContentMediaStorageException(e.message);
    }
  }
}
