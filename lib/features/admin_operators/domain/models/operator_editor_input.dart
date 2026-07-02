import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_group_grant.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_permissions.dart';

part 'operator_editor_input.freezed.dart';

@freezed
abstract class OperatorEditorInput with _$OperatorEditorInput {
  const factory OperatorEditorInput({
    String? id,
    required String fullName,
    required String email,
    String? password,
    @Default(true) bool isActive,
    required OperatorPermissions permissions,
    @Default([]) List<OperatorGroupGrant> groupAccess,
  }) = _OperatorEditorInput;

  const OperatorEditorInput._();

  bool get isEditing => id != null;
}
