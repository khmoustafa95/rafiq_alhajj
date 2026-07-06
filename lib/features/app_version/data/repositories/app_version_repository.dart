import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/app_version/data/data_sources/app_version_remote_data_source.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/app_version_policy.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/app_version_policy_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppVersionException implements Exception {
  const AppVersionException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'App version request failed';
}

class AppVersionRepository {
  AppVersionRepository([SupabaseClient? client])
      : _remote =
            client == null ? null : AppVersionRemoteDataSource(client);

  final AppVersionRemoteDataSource? _remote;

  bool get isAvailable => AppConfig.hasSupabase && _remote != null;

  Future<List<AppVersionPolicy>> fetchAll() async {
    if (!isAvailable) {
      return const [];
    }
    try {
      final rows = await _remote!.fetchAll();
      return rows.map(_mapRow).toList(growable: false);
    } on PostgrestException catch (e) {
      throw AppVersionException(e.message);
    }
  }

  Future<AppVersionPolicy?> fetchForPlatform(String platform) async {
    if (!isAvailable) {
      return null;
    }
    try {
      final row = await _remote!.fetchForPlatform(platform);
      if (row == null) {
        return null;
      }
      return _mapRow(row);
    } on PostgrestException catch (e) {
      throw AppVersionException(e.message);
    }
  }

  Future<AppVersionPolicy> save(AppVersionPolicyInput input) async {
    if (!isAvailable) {
      throw const AppVersionException('Supabase is not configured');
    }
    try {
      final remote = _remote!;
      final userId = remote.currentUserId;
      final row = await remote.upsert({
        'platform': input.platform,
        'min_version': input.minVersion.trim(),
        'latest_version': input.latestVersion.trim(),
        'store_url': _nullableTrim(input.storeUrl),
        'release_notes_ar': _nullableTrim(input.releaseNotesAr),
        'release_notes_en': _nullableTrim(input.releaseNotesEn),
        'updated_at': DateTime.now().toUtc().toIso8601String(),
        'updated_by': userId,
      });
      return _mapRow(row);
    } on PostgrestException catch (e) {
      throw AppVersionException(e.message);
    }
  }

  String? _nullableTrim(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  AppVersionPolicy _mapRow(Map<String, dynamic> map) {
    return AppVersionPolicy(
      platform: map['platform'] as String,
      minVersion: map['min_version'] as String? ?? '1.0.0',
      latestVersion: map['latest_version'] as String? ?? '1.0.0',
      storeUrl: map['store_url'] as String?,
      releaseNotesAr: map['release_notes_ar'] as String?,
      releaseNotesEn: map['release_notes_en'] as String?,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'] as String)
          : null,
    );
  }
}
