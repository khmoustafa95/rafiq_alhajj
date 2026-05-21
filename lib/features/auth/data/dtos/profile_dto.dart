import 'package:json_annotation/json_annotation.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/user_profile.dart';

part 'profile_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileDto {
  const ProfileDto({
    required this.id,
    required this.fullName,
    required this.role,
  });

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  final String id;
  final String? fullName;
  final String role;

  UserProfile toDomain() {
    return UserProfile(
      id: id,
      fullName: fullName,
      role: AppUserRole.fromDatabase(role),
    );
  }
}
