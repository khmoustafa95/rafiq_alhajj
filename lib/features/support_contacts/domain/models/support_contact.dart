import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_contact.freezed.dart';

enum SupportContactScope {
  global,
  group;

  static SupportContactScope fromName(String? value) {
    return SupportContactScope.values.firstWhere(
      (scope) => scope.name == value,
      orElse: () => SupportContactScope.global,
    );
  }
}

@freezed
abstract class SupportContact with _$SupportContact {
  const factory SupportContact({
    required String id,
    required String labelAr,
    required String labelEn,
    String? descriptionAr,
    String? descriptionEn,
    String? phoneNumber,
    String? whatsappNumber,
    @Default(SupportContactScope.global) SupportContactScope scope,
    String? groupId,
    String? groupName,
    @Default(true) bool isActive,
    @Default(0) int sortOrder,
  }) = _SupportContact;

  const SupportContact._();

  bool get hasPhone => phoneNumber?.trim().isNotEmpty ?? false;
  bool get hasWhatsapp => whatsappNumber?.trim().isNotEmpty ?? false;

  String label(String languageCode) =>
      languageCode == 'ar' ? labelAr : labelEn;

  String? description(String languageCode) =>
      languageCode == 'ar' ? descriptionAr : descriptionEn;
}
