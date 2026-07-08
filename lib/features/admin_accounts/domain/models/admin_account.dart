import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_account.freezed.dart';

@freezed
abstract class AdminAccount with _$AdminAccount {
  const factory AdminAccount({
    required String id,
    required String fullName,
    required String email,
    required bool canManageAdmins,
    required bool isActive,
    DateTime? updatedAt,
  }) = _AdminAccount;
}
