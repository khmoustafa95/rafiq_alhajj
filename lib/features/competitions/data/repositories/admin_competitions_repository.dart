import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_editor_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminCompetitionsRepository {
  AdminCompetitionsRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<List<Competition>> fetchAll() async {
    if (!isAvailable) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final rows = await _client!
          .from('competitions')
          .select('id, title, description, starts_at, ends_at, is_active')
          .order('starts_at', ascending: false);

      return (rows as List<dynamic>)
          .map((row) => _mapCompetition(Map<String, dynamic>.from(row as Map)))
          .toList();
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Future<Competition> upsert(CompetitionEditorInput input) async {
    if (!isAvailable) {
      throw const CompetitionsException('Supabase is not configured');
    }

    final payload = input.toDatabasePayload();

    try {
      if (input.id != null) {
        final row = await _client!
            .from('competitions')
            .update(payload)
            .eq('id', input.id!)
            .select('id, title, description, starts_at, ends_at, is_active')
            .single();
        return _mapCompetition(Map<String, dynamic>.from(row));
      }

      final row = await _client!
          .from('competitions')
          .insert(payload)
          .select('id, title, description, starts_at, ends_at, is_active')
          .single();
      return _mapCompetition(Map<String, dynamic>.from(row));
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Future<void> delete(String id) async {
    if (!isAvailable) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      await _client!.from('competitions').delete().eq('id', id);
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
