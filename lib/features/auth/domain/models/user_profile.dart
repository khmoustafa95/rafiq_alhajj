import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';

part 'user_profile.freezed.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String? fullName,
    required AppUserRole role,
  }) = _UserProfile;
}
