import 'dart:async';
import 'dart:io';

import 'package:rafiq_alhajj/features/content/data/dtos/content_item_dto.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_repository.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContentFetchException implements Exception {
  const ContentFetchException();
}

class SupabaseContentRepository implements ContentRepository {
  SupabaseContentRepository(this._client);

  final SupabaseClient _client;
  static const Duration _requestTimeout = Duration(seconds: 15);

  @override
  Future<PublicContentFeed> fetchBrowsableFeed({
    required bool includePilgrimOnly,
  }) async {
    try {
      final rows = await _client
          .from('content_library')
          .select(
            'id, title, description, media_url, type, visibility, created_at',
          )
          .order('created_at', ascending: false)
          .timeout(_requestTimeout);

      final items = (rows as List<dynamic>)
          .map(
            (row) => ContentItemDto.fromJson(
              Map<String, dynamic>.from(row as Map),
            ).toDomain(),
          )
          .where(
            (item) =>
                item.visibility == ContentVisibility.public ||
                (includePilgrimOnly &&
                    item.visibility == ContentVisibility.pilgrimOnly),
          )
          .toList();

      final videos = items
          .where((item) => item.type == ContentType.video)
          .toList();
      final newsAndAnnouncements = items
          .where(
            (item) =>
                item.type == ContentType.news ||
                item.type == ContentType.announcement,
          )
          .toList();

      return PublicContentFeed(
        videos: videos,
        newsAndAnnouncements: newsAndAnnouncements,
      );
    } on PostgrestException {
      throw const ContentFetchException();
    } on SocketException {
      throw const ContentFetchException();
    } on TimeoutException {
      throw const ContentFetchException();
    }
  }

  @override
  Future<ContentItem?> fetchById(String id) async {
    try {
      final row = await _client
          .from('content_library')
          .select(
            'id, title, description, media_url, type, visibility, created_at',
          )
          .eq('id', id)
          .maybeSingle()
          .timeout(_requestTimeout);

      if (row == null) {
        return null;
      }

      return ContentItemDto.fromJson(Map<String, dynamic>.from(row)).toDomain();
    } on PostgrestException {
      throw const ContentFetchException();
    } on SocketException {
      throw const ContentFetchException();
    } on TimeoutException {
      throw const ContentFetchException();
    }
  }
}
