import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/competitions/data/data_sources/admin_competitions_remote_data_source.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_editor_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminCompetitionsRepository {
  AdminCompetitionsRepository([SupabaseClient? client])
      : _remote = AppConfig.hasSupabase && client != null
            ? AdminCompetitionsRemoteDataSource(client)
            : null;

  final AdminCompetitionsRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<List<Competition>> fetchAll() async {
    final remote = _remote;
    if (remote == null) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final rows = await remote.fetchAll();

      return rows.map(_mapCompetition).toList();
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Future<PaginatedResult<Competition>> fetchPage(StaffTableQuery query) async {
    final remote = _remote;
    if (remote == null) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final page = await remote.fetchPage(query);
      return PaginatedResult(
        items: page.rows.map(_mapCompetition).toList(growable: false),
        totalCount: page.count,
        pageSize: query.pageSize,
      );
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Future<Competition> upsert(CompetitionEditorInput input) async {
    final remote = _remote;
    if (remote == null) {
      throw const CompetitionsException('Supabase is not configured');
    }

    final payload = input.toDatabasePayload();

    try {
      if (input.id != null) {
        final row = await remote.update(input.id!, payload);
        return _mapCompetition(row);
      }

      final row = await remote.insert(payload);
      return _mapCompetition(row);
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Future<void> delete(String id) async {
    final remote = _remote;
    if (remote == null) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      await remote.delete(id);
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Competition _mapCompetition(Map<String, dynamic> row) {
    return Competition(
      id: row['id'] as String,
      title: row['title'] as String,
      description: row['description'] as String?,
      startsAt: DateTime.parse(row['starts_at'] as String),
      endsAt: DateTime.parse(row['ends_at'] as String),
      isActive: row['is_active'] as bool? ?? true,
    );
  }
}
