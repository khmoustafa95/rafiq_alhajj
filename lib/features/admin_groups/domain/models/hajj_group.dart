import 'package:rafiq_alhajj/features/admin_groups/domain/models/group_administration_member.dart';

class HajjGroup {
  const HajjGroup({
    required this.id,
    required this.name,
    required this.code,
    this.logoUrl,
    this.presidentName,
    this.presidentPhone,
    this.members = const [],
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String name;
  final String code;
  final String? logoUrl;
  final String? presidentName;
  final String? presidentPhone;
  final List<GroupAdministrationMember> members;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
