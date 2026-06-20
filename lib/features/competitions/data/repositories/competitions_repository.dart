import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/competitions/data/data_sources/competitions_remote_data_source.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompetitionsException implements Exception {
  const CompetitionsException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Competitions request failed';
}

class CompetitionsRepository {
  CompetitionsRepository([SupabaseClient? client])
      : _remote = AppConfig.hasSupabase && client != null
            ? CompetitionsRemoteDataSource(client)
            : null;

  final CompetitionsRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<List<Competition>> fetchActive() async {
    final remote = _remote;
    if (remote == null) {
      return [];
    }

    try {
      final rows = await remote.fetchActive();
      return rows.map(_mapCompetition).toList();
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Future<CompetitionWithEntries?> fetchWithEntries(
    String competitionId, {
    String? currentProfileId,
  }) async {
    final remote = _remote;
    if (remote == null) {
      return null;
    }

    try {
      final compRow = await remote.fetchById(competitionId);

      if (compRow == null) {
        return null;
      }

      final entryRows = await remote.fetchEntries(competitionId);

      final entries = _mapEntries(entryRows);
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
        competition: _mapCompetition(compRow),
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
    final remote = _remote;
    if (remote == null) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final row = await remote.insertEntry(
        competitionId: competitionId,
        profileId: profileId,
      );

      return _mapEntry(row);
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
    final remote = _remote;
    if (remote == null) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final current = await remote.fetchEntryScore(entryId);

      final newScore =
          (current['score'] as int? ?? 0) + delta;

      final row = await remote.updateEntryScore(
        entryId: entryId,
        score: newScore,
      );

      return _mapEntry(row);
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
