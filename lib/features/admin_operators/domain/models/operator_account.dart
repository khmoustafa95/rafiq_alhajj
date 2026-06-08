import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_permissions.dart';

class OperatorAccount {
  const OperatorAccount({
    required this.id,
    required this.fullName,
    required this.email,
    required this.isActive,
    required this.permissions,
    this.updatedAt,
  });

  final String id;
  final String fullName;
  final String email;
  final bool isActive;
  final OperatorPermissions permissions;
  final DateTime? updatedAt;
}
