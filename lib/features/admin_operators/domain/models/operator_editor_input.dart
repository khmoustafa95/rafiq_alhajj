import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_group_grant.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_permissions.dart';

class OperatorEditorInput {
  const OperatorEditorInput({
    this.id,
    required this.fullName,
    required this.email,
    this.password,
    this.isActive = true,
    required this.permissions,
    this.groupAccess = const [],
  });

  final String? id;
  final String fullName;
  final String email;
  final String? password;
  final bool isActive;
  final OperatorPermissions permissions;
  final List<OperatorGroupGrant> groupAccess;

  bool get isEditing => id != null;
}
