import 'package:rafiq_alhajj/l10n/app_localizations.dart';

const tripTypes = ['hajj', 'umrah'];

/// All status values known to the DB (kept for labelling legacy rows).
const tripStatuses = ['planning', 'active', 'completed', 'cancelled'];

/// Statuses the admin can pick: a trip is either active (نشطة) or finished
/// (منتهية).
const tripEditableStatuses = ['active', 'completed'];

String tripTypeLabel(AppLocalizations l10n, String type) {
  return switch (type) {
    'umrah' => l10n.adminTripTypeUmrah,
    _ => l10n.adminTripTypeHajj,
  };
}

String tripStatusLabel(AppLocalizations l10n, String status) {
  return switch (status) {
    'active' => l10n.adminTripStatusActive,
    'completed' => l10n.adminTripStatusCompleted,
    'cancelled' => l10n.adminTripStatusCancelled,
    _ => l10n.adminTripStatusPlanning,
  };
}
