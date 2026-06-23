import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/support_contacts/data/data_sources/support_contacts_remote_data_source.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupportContactsException implements Exception {
  const SupportContactsException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Support contacts request failed';
}

class SupportContactsRepository {
  SupportContactsRepository([SupabaseClient? client])
      : _remote = (AppConfig.hasSupabase && client != null)
            ? SupportContactsRemoteDataSource(client)
            : null;

  final SupportContactsRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<List<SupportContact>> fetchVisible() async {
    final remote = _remote;
    if (remote == null) {
      return const [];
    }
    try {
      final rows = await remote.fetchVisible();
      return rows.map(_mapRow).toList(growable: false);
    } on PostgrestException catch (e) {
      throw SupportContactsException(e.message);
    }
  }

  Future<List<SupportContact>> fetchAll() async {
    final remote = _remote;
    if (remote == null) {
      return const [];
    }
    try {
      final rows = await remote.fetchAll();
      return rows.map(_mapRow).toList(growable: false);
    } on PostgrestException catch (e) {
      throw SupportContactsException(e.message);
    }
  }

  Future<void> save(SupportContactInput input) async {
    final remote = _remote;
    if (remote == null) {
      throw const SupportContactsException('Supabase is not configured');
    }

    try {
      final payload = <String, dynamic>{
        'label_ar': input.labelAr.trim(),
        'label_en': input.labelEn.trim(),
        'description_ar': _nullableTrim(input.descriptionAr),
        'description_en': _nullableTrim(input.descriptionEn),
        'phone_number': _nullableTrim(input.phoneNumber),
        'whatsapp_number': _nullableTrim(input.whatsappNumber),
        'scope': input.scope.name,
        'group_id':
            input.scope == SupportContactScope.group ? input.groupId : null,
        'is_active': input.isActive,
        'sort_order': input.sortOrder,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      };

      if (input.id == null) {
        payload['created_by'] = remote.currentUserId;
        await remote.insert(payload);
      } else {
        await remote.update(input.id!, payload);
      }
    } on PostgrestException catch (e) {
      throw SupportContactsException(e.message);
    }
  }

  Future<void> remove(String id) async {
    final remote = _remote;
    if (remote == null) {
      throw const SupportContactsException('Supabase is not configured');
    }
    try {
      await remote.delete(id);
    } on PostgrestException catch (e) {
      throw SupportContactsException(e.message);
    }
  }

  String? _nullableTrim(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  SupportContact _mapRow(Map<String, dynamic> map) {
    final group = map['groups'];
    final groupName = group is Map ? group['name'] as String? : null;

    return SupportContact(
      id: map['id'] as String,
      labelAr: map['label_ar'] as String? ?? '',
      labelEn: map['label_en'] as String? ?? '',
      descriptionAr: map['description_ar'] as String?,
      descriptionEn: map['description_en'] as String?,
      phoneNumber: map['phone_number'] as String?,
      whatsappNumber: map['whatsapp_number'] as String?,
      scope: SupportContactScope.fromName(map['scope'] as String?),
      groupId: map['group_id'] as String?,
      groupName: groupName,
      isActive: map['is_active'] as bool? ?? true,
      sortOrder: map['sort_order'] as int? ?? 0,
    );
  }
}
