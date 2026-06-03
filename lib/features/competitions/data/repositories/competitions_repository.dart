import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompetitionsException implements Exception {
  const CompetitionsException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Competitions request failed';
}

class CompetitionsRepository {
  CompetitionsRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<List<Competition>> fetchActive() async {
    if (!isAvailable) {
      return [];
    }

    try {
      final rows = await _client!
          .from('competitions')
          .select('id, title, description, starts_at, ends_at, is_active')
          .eq('is_active', true)
          .gte('ends_at', DateTime.now().toUtc().toIso8601String())
          .order('starts_at');

      return (rows as List<dynamic>)
          .map((row) => _mapCompetition(Map<String, dynamic>.from(row as Map)))
          .toList();
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Future<CompetitionWithEntries?> fetchWithEntries(
    String competitionId, {
    String? currentProfileId,
  }) async {
    if (!isAvailable) {
      return null;
    }

    try {
      final compRow = await _client!
          .from('competitions')
          .select('id, title, description, starts_at, ends_at, is_active')
          .eq('id', competitionId)
          .maybeSingle();

      if (compRow == null) {
        return null;
      }

      final entryRows = await _client
          .from('competition_entries')
          .select(
            'id, competition_id, profile_id, score, joined_at, '
            'profiles(full_name)',
          )
          .eq('competition_id', competitionId)
          .order('score', ascending: false)
          .limit(20);

      final entries = _mapEntries(entryRows as List<dynamic>);
      CompetitionEntry? myEntry;
      if (currentProfileId != null) {
        for (final entry in entries) {
          if (entry.profileId == currentProfileId) {
            myEntry = entry;
            break;
          }
        }
      }

      return CompetitionWithEntries(
        competition: _mapCompetition(Map<String, dynamic>.from(compRow)),
        entries: entries,
        myEntry: myEntry,
      );
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Future<CompetitionEntry?> join({
    required String competitionId,
    required String profileId,
  }) async {
    if (!isAvailable) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final row = await _client!
          .from('competition_entries')
          .insert({
            'competition_id': competitionId,
            'profile_id': profileId,
          })
          .select(
            'id, competition_id, profile_id, score, joined_at, '
            'profiles(full_name)',
          )
          .single();

      return _mapEntry(Map<String, dynamic>.from(row));
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        return null;
      }
      throw CompetitionsException(e.message);
    }
  }

  Future<CompetitionEntry?> addScore({
    required String entryId,
    required int delta,
  }) async {
    if (!isAvailable) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final current = await _client!
          .from('competition_entries')
          .select('score')
          .eq('id', entryId)
          .single();

      final newScore =
          (current['score'] as int? ?? 0) + delta;

      final row = await _client
          .from('competition_entries')
          .update({'score': newScore})
          .eq('id', entryId)
          .select(
            'id, competition_id, profile_id, score, joined_at, '
            'profiles(full_name)',
          )
          .single();

      return _mapEntry(Map<String, dynamic>.from(row));
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

  List<CompetitionEntry> _mapEntries(List<dynamic> rows) {
    return rows
        .map((raw) => _mapEntry(Map<String, dynamic>.from(raw as Map)))
        .toList();
  }

  CompetitionEntry _mapEntry(Map<String, dynamic> row) {
    final profile = row['profiles'];
    String name = '';
    if (profile is Map) {
      name = profile['full_name'] as String? ?? '';
    } else if (profile is List && profile.isNotEmpty) {
      name = (profile.first as Map)['full_name'] as String? ?? '';
    }

    return CompetitionEntry(
      id: row['id'] as String,
      competitionId: row['competition_id'] as String,
      profileId: row['profile_id'] as String,
      participantName: name,
      score: row['score'] as int? ?? 0,
      joinedAt: DateTime.parse(row['joined_at'] as String),
    );
  }
}
