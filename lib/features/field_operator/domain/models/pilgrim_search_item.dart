import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';

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
    String? groupName,
    String? stickerNumber,
    String? visaNumber,
    String? phoneNumber,
    String? cluster,
  }) = _PilgrimSearchItem;

  factory PilgrimSearchItem.fromPilgrim(Pilgrim pilgrim) {
    return PilgrimSearchItem(
      profileId: pilgrim.profileId ?? '',
      fullName: pilgrim.displayName ?? pilgrim.fullNameAr ?? '',
      passportNumber: pilgrim.passportNumber,
      travelPermitNumber: pilgrim.travelPermitNumber,
      fieldStatus: pilgrim.fieldStatus,
      medicalTestStatus: pilgrim.medicalTestStatus,
      groupName: pilgrim.groupName,
      stickerNumber: pilgrim.stickerNumber,
      visaNumber: pilgrim.visaNumber,
      phoneNumber: pilgrim.phoneNumber ?? pilgrim.whatsappNumber,
      cluster: pilgrim.cluster,
    );
  }
}
