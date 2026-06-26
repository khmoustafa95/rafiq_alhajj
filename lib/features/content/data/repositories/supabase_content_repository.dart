import 'dart:async';
import 'dart:io';

import 'package:rafiq_alhajj/features/content/data/data_sources/content_remote_data_source.dart';
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
  SupabaseContentRepository(SupabaseClient client)
      : _remote = ContentRemoteDataSource(client);

  final ContentRemoteDataSource _remote;

  @override
  Future<PublicContentFeed> fetchBrowsableFeed({
    required bool includePilgrimOnly,
  }) async {
    try {
      final rows = await _remote.fetchBrowsableFeed();

      final items = rows
          .map(
            (row) => ContentItemDto.fromJson(row).toDomain(),
          )
          .where(
            (item) =>
                (item.type == ContentType.news ||
                    item.type == ContentType.announcement) &&
                (item.visibility == ContentVisibility.public ||
                    (includePilgrimOnly &&
                        item.visibility == ContentVisibility.pilgrimOnly)),
          )
          .toList();

      return PublicContentFeed(
        announcements: items
            .where((item) => item.type == ContentType.announcement)
            .toList(),
        news: items.where((item) => item.type == ContentType.news).toList(),
        topics: const [],
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
      final row = await _remote.fetchById(id);

      if (row == null) {
        return null;
      }

      return ContentItemDto.fromJson(row).toDomain();
    } on PostgrestException {
      throw const ContentFetchException();
    } on SocketException {
      throw const ContentFetchException();
    } on TimeoutException {
      throw const ContentFetchException();
    }
  }
}
