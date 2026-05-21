import 'package:freezed_annotation/freezed_annotation.dart';

part 'pilgrim_search_item.freezed.dart';

@freezed
abstract class PilgrimSearchItem with _$PilgrimSearchItem {
  const factory PilgrimSearchItem({
    required String profileId,
    required String fullName,
    required String? passportNumber,
    required String? travelPermitNumber,
    required String? fieldStatus,
    required String? medicalTestStatus,
  }) = _PilgrimSearchItem;
}
