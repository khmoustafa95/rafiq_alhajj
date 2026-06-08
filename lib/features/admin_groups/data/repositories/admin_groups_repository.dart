import 'dart:typed_data';

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/utils/postgrest_search_sanitize.dart';
import 'package:rafiq_alhajj/features/admin_groups/domain/models/group_administration_member.dart';
import 'package:rafiq_alhajj/features/admin_groups/domain/models/group_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_groups/domain/models/hajj_group.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminGroupsException implements Exception {
  const AdminGroupsException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Group management request failed';
}

class AdminGroupsRepository {
  AdminGroupsRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  static const _groupSelect =
      'id, name, code, logo_url, president_name, president_phone, '
      'created_at, updated_at, '
      'group_administration_members(id, name, position, contact, photo_url, sort_order)';

  Future<PaginatedResult<HajjGroup>> fetchPage(StaffTableQuery query) async {
    if (!isAvailable) {
      throw const AdminGroupsException('Supabase is not configured');
    }

    try {
      var request = _client!.from('groups').select(_groupSelect);

      final search = query.search.trim();
      if (search.isNotEmpty) {
        final term = sanitizePostgrestSearchTerm(search);
        request = request.or(
          'name.ilike.%$term%,president_name.ilike.%$term%,code.ilike.%$term%',
        );
      }

      final sortColumn = switch (query.sortColumnId) {
        'president_name' => 'president_name',
        'code' => 'code',
        'created_at' => 'created_at',
        _ => 'name',
      };

      final response = await request
          .order(sortColumn, ascending: query.sortAscending)
          .range(query.from, query.to)
          .count(CountOption.exact);

      final rows = response.data as List<dynamic>;
      return PaginatedResult(
        items: rows.map(_rowToGroup).toList(),
        totalCount: response.count,
        pageSize: query.pageSize,
      );
    } on PostgrestException catch (e) {
      throw AdminGroupsException(e.message);
    }
  }

  Future<HajjGroup> fetchById(String id) async {
    if (!isAvailable) {
      throw const AdminGroupsException('Supabase is not configured');
    }

    try {
      final row = await _client!
          .from('groups')
          .select(_groupSelect)
          .eq('id', id)
          .single();

      return _rowToGroup(row);
    } on PostgrestException catch (e) {
      throw AdminGroupsException(e.message);
    }
  }

  Future<HajjGroup> save(GroupEditorInput input) async {
    if (!isAvailable) {
      throw const AdminGroupsException('Supabase is not configured');
    }

    try {
      final client = _client!;
      final groupId = input.id;
      String resolvedGroupId;

      if (groupId != null) {
        await client
            .from('groups')
            .update({
              'name': input.name.trim(),
              'president_name': _nullableTrim(input.presidentName),
              'president_phone': _nullableTrim(input.presidentPhone),
              'updated_at': DateTime.now().toUtc().toIso8601String(),
            })
            .eq('id', groupId);
        resolvedGroupId = groupId;
      } else {
        final code = await _uniqueCode(input.name.trim());
        final row = await client
            .from('groups')
            .insert({
              'name': input.name.trim(),
              'code': code,
              'president_name': _nullableTrim(input.presidentName),
              'president_phone': _nullableTrim(input.presidentPhone),
            })
            .select('id')
            .single();
        resolvedGroupId = row['id'] as String;
      }

      var logoUrl = input.logoUrl;
      if (input.logoBytes != null && input.logoFileName != null) {
        logoUrl = await _uploadAsset(
          groupId: resolvedGroupId,
          folder: 'logo',
          fileName: input.logoFileName!,
          bytes: input.logoBytes!,
        );
      }

      if (logoUrl != null) {
        await client
            .from('groups')
            .update({'logo_url': logoUrl})
            .eq('id', resolvedGroupId);
      }

      await client
          .from('group_administration_members')
          .delete()
          .eq('group_id', resolvedGroupId);

      final memberRows = <Map<String, dynamic>>[];
      for (var i = 0; i < input.members.length; i++) {
        final member = input.members[i];
        if (member.name.trim().isEmpty) {
          continue;
        }

        var photoUrl = member.photoUrl;
        if (member.photoBytes != null && member.photoFileName != null) {
          photoUrl = await _uploadAsset(
            groupId: resolvedGroupId,
            folder: 'members/$i',
            fileName: member.photoFileName!,
            bytes: member.photoBytes!,
          );
        }

        memberRows.add({
          if (member.id != null) 'id': member.id,
          'group_id': resolvedGroupId,
          'name': member.name.trim(),
          'position': _nullableTrim(member.position),
          'contact': _nullableTrim(member.contact),
          'photo_url': photoUrl,
          'sort_order': member.sortOrder,
        });
      }

      if (memberRows.isNotEmpty) {
        await client.from('group_administration_members').insert(memberRows);
      }

      return fetchById(resolvedGroupId);
    } on AdminGroupsException {
      rethrow;
    } on PostgrestException catch (e) {
      throw AdminGroupsException(e.message);
    } on StorageException catch (e) {
      throw AdminGroupsException(e.message);
    }
  }

  Future<bool> delete(String id) async {
    if (!isAvailable) {
      throw const AdminGroupsException('Supabase is not configured');
    }

    try {
      await _client!.from('groups').delete().eq('id', id);
      return true;
    } on PostgrestException catch (e) {
      throw AdminGroupsException(e.message);
    }
  }

  Future<String> _uniqueCode(String name) async {
    final base = _slugify(name);
    final candidate = base.isEmpty ? 'group' : base;
    var suffix = 0;

    while (true) {
      final code = suffix == 0 ? candidate : '$candidate-$suffix';
      final existing = await _client!
          .from('groups')
          .select('id')
          .eq('code', code)
          .maybeSingle();
      if (existing == null) {
        return code;
      }
      suffix++;
    }
  }

  String _slugify(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  String? _nullableTrim(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  Future<String> _uploadAsset({
    required String groupId,
    required String folder,
    required String fileName,
    required Uint8List bytes,
  }) async {
    final safeName = fileName.replaceAll(RegExp(r'[^\w.\-]'), '_');
    final path =
        '$groupId/$folder/${DateTime.now().millisecondsSinceEpoch}_$safeName';
    final client = _client!;

    await client.storage.from('group-assets').uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );

    return client.storage.from('group-assets').getPublicUrl(path);
  }

  HajjGroup _rowToGroup(dynamic row) {
    final map = Map<String, dynamic>.from(row as Map);
    final membersRaw = map['group_administration_members'];
    final members = <GroupAdministrationMember>[];

    if (membersRaw is List) {
      for (final raw in membersRaw) {
        final memberMap = Map<String, dynamic>.from(raw as Map);
        members.add(
          GroupAdministrationMember(
            id: memberMap['id'] as String,
            name: memberMap['name'] as String? ?? '',
            position: memberMap['position'] as String?,
            contact: memberMap['contact'] as String?,
            photoUrl: memberMap['photo_url'] as String?,
            sortOrder: memberMap['sort_order'] as int? ?? 0,
          ),
        );
      }
      members.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    }

    return HajjGroup(
      id: map['id'] as String,
      name: map['name'] as String? ?? '',
      code: map['code'] as String? ?? '',
      logoUrl: map['logo_url'] as String?,
      presidentName: map['president_name'] as String?,
      presidentPhone: map['president_phone'] as String?,
      members: members,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'] as String)
          : null,
    );
  }
}
