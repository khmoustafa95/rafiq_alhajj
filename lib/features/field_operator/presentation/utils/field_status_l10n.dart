import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

String fieldStatusLabel(AppLocalizations l10n, String? status) {
  return switch (status) {
    FieldPilgrimStatus.pending => l10n.fieldStatusPending,
    FieldPilgrimStatus.medicalDone => l10n.fieldStatusMedicalDone,
    FieldPilgrimStatus.arrivedHotel => l10n.fieldStatusArrivedHotel,
    FieldPilgrimStatus.inTransit => l10n.fieldStatusInTransit,
    FieldPilgrimStatus.completed => l10n.fieldStatusCompleted,
    null || '' => l10n.fieldStatusNotSet,
    _ => status,
  };
}
