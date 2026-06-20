import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/admin_content/data/data_sources/admin_content_remote_data_source.dart';
import 'package:rafiq_alhajj/features/admin_content/domain/models/content_editor_input.dart';
import 'package:rafiq_alhajj/features/content/data/dtos/content_item_dto.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminContentException implements Exception {
  const AdminContentException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Content CMS request failed';
}

class AdminContentRepository {
  AdminContentRepository([SupabaseClient? client])
      : _remote = AppConfig.hasSupabase && client != null
            ? AdminContentRemoteDataSource(client)
            : null;

  final AdminContentRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<ContentItem?> fetchById(String id) async {
    final remote = _remote;
    if (remote == null) {
      throw const AdminContentException('Supabase is not configured');
    }

    try {
      final row = await remote.fetchById(id);

      if (row == null) {
        return null;
      }

      return ContentItemDto.fromJson(row).toDomain();
    } on PostgrestException catch (e) {
      throw AdminContentException(e.message);
    }
  }

  Future<PaginatedResult<ContentItem>> fetchPage(StaffTableQuery query) async {
    final remote = _remote;
    if (remote == null) {
      throw const AdminContentException('Supabase is not configured');
    }

    try {
      final page = await remote.fetchPage(query);

      return PaginatedResult(
        items: page.rows
            .map(
              (row) => ContentItemDto.fromJson(row).toDomain(),
            )
            .toList(),
        totalCount: page.count,
        pageSize: query.pageSize,
      );
    } on PostgrestException catch (e) {
      throw AdminContentException(e.message);
    }
  }

  Future<List<ContentItem>> fetchAll() async {
    final remote = _remote;
    if (remote == null) {
      throw const AdminContentException('Supabase is not configured');
    }

    try {
      final rows = await remote.fetchAll();

      return rows
          .map(
            (row) => ContentItemDto.fromJson(row).toDomain(),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw AdminContentException(e.message);
    }
  }

  Future<ContentItem> upsert(ContentEditorInput input) async {
    final remote = _remote;
    if (remote == null) {
      throw const AdminContentException('Supabase is not configured');
    }

    try {
      final payload = input.toDatabasePayload();

      final row = await remote.upsert(payload, id: input.id);
      return ContentItemDto.fromJson(row).toDomain();
    } on PostgrestException catch (e) {
      throw AdminContentException(e.message);
    }
  }

  Future<void> delete(String id) async {
    final remote = _remote;
    if (remote == null) {
      throw const AdminContentException('Supabase is not configured');
    }

    try {
      await remote.delete(id);
    } on PostgrestException catch (e) {
      throw AdminContentException(e.message);
    }
  }
}
