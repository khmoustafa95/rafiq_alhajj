import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact.dart';

/// Write payload for creating/updating a [SupportContact].
class SupportContactInput {
  const SupportContactInput({
    this.id,
    required this.labelAr,
    required this.labelEn,
    this.descriptionAr,
    this.descriptionEn,
    this.phoneNumber,
    this.whatsappNumber,
    required this.scope,
    this.groupId,
    required this.isActive,
    required this.sortOrder,
  });

  final String? id;
  final String labelAr;
  final String labelEn;
  final String? descriptionAr;
  final String? descriptionEn;
  final String? phoneNumber;
  final String? whatsappNumber;
  final SupportContactScope scope;
  final String? groupId;
  final bool isActive;
  final int sortOrder;
}
