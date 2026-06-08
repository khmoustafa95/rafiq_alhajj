import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/admin_settings/domain/models/system_settings.dart';
import 'package:rafiq_alhajj/features/admin_settings/domain/models/system_settings_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SystemSettingsException implements Exception {
  const SystemSettingsException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'System settings request failed';
}

class SystemSettingsRepository {
  SystemSettingsRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  static const globalId = 'global';

  static const _selectColumns =
      'organization_name, support_email, support_phone, hajj_season_label, '
      'registration_open, maintenance_mode, maintenance_message, '
      'require_documents_on_intake, auto_generate_pilgrim_password, '
      'allow_operator_self_registration, enable_public_content_feed, '
      'enable_competitions, enable_push_notifications, enable_in_app_notifications, '
      'pilgrim_ritual_tracking_enabled, max_pilgrims_per_group, updated_at';

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<SystemSettings> fetch() async {
    if (!isAvailable) {
      return SystemSettings.defaults();
    }

    try {
      final row = await _client!
          .from('system_settings')
          .select(_selectColumns)
          .eq('id', globalId)
          .maybeSingle();

      if (row == null) {
        return SystemSettings.defaults();
      }

      return _mapRow(Map<String, dynamic>.from(row));
    } on PostgrestException catch (e) {
      throw SystemSettingsException(e.message);
    }
  }

  Future<SystemSettings> save(SystemSettingsInput input) async {
    if (!isAvailable) {
      throw const SystemSettingsException('Supabase is not configured');
    }

    try {
      final userId = _client!.auth.currentUser?.id;
      final payload = {
        'organization_name': input.organizationName.trim(),
        'support_email': _nullableTrim(input.supportEmail),
        'support_phone': _nullableTrim(input.supportPhone),
        'hajj_season_label': _nullableTrim(input.hajjSeasonLabel),
        'registration_open': input.registrationOpen,
        'maintenance_mode': input.maintenanceMode,
        'maintenance_message': _nullableTrim(input.maintenanceMessage),
        'require_documents_on_intake': input.requireDocumentsOnIntake,
        'auto_generate_pilgrim_password': input.autoGeneratePilgrimPassword,
        'allow_operator_self_registration': input.allowOperatorSelfRegistration,
        'enable_public_content_feed': input.enablePublicContentFeed,
        'enable_competitions': input.enableCompetitions,
        'enable_push_notifications': input.enablePushNotifications,
        'enable_in_app_notifications': input.enableInAppNotifications,
        'pilgrim_ritual_tracking_enabled': input.pilgrimRitualTrackingEnabled,
        'max_pilgrims_per_group': input.maxPilgrimsPerGroup,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
        'updated_by': ?userId,
      };

      final row = await _client
          .from('system_settings')
          .update(payload)
          .eq('id', globalId)
          .select(_selectColumns)
          .single();

      return _mapRow(Map<String, dynamic>.from(row));
    } on PostgrestException catch (e) {
      throw SystemSettingsException(e.message);
    }
  }

  String? _nullableTrim(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  SystemSettings _mapRow(Map<String, dynamic> map) {
    return SystemSettings(
      organizationName: map['organization_name'] as String? ?? 'Rafiq Al-Hajj',
      supportEmail: map['support_email'] as String?,
      supportPhone: map['support_phone'] as String?,
      hajjSeasonLabel: map['hajj_season_label'] as String?,
      registrationOpen: map['registration_open'] as bool? ?? true,
      maintenanceMode: map['maintenance_mode'] as bool? ?? false,
      maintenanceMessage: map['maintenance_message'] as String?,
      requireDocumentsOnIntake:
          map['require_documents_on_intake'] as bool? ?? true,
      autoGeneratePilgrimPassword:
          map['auto_generate_pilgrim_password'] as bool? ?? true,
      allowOperatorSelfRegistration:
          map['allow_operator_self_registration'] as bool? ?? false,
      enablePublicContentFeed:
          map['enable_public_content_feed'] as bool? ?? true,
      enableCompetitions: map['enable_competitions'] as bool? ?? true,
      enablePushNotifications:
          map['enable_push_notifications'] as bool? ?? true,
      enableInAppNotifications:
          map['enable_in_app_notifications'] as bool? ?? true,
      pilgrimRitualTrackingEnabled:
          map['pilgrim_ritual_tracking_enabled'] as bool? ?? true,
      maxPilgrimsPerGroup: map['max_pilgrims_per_group'] as int?,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'] as String)
          : null,
    );
  }
}
