import 'package:freezed_annotation/freezed_annotation.dart';

part 'created_pilgrim_account.freezed.dart';

@freezed
abstract class CreatedPilgrimAccount with _$CreatedPilgrimAccount {
  const factory CreatedPilgrimAccount({
    required String profileId,
    required String email,
    required String password,
  }) = _CreatedPilgrimAccount;
}
