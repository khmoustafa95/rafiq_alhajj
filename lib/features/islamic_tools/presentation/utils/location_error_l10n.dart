import 'package:rafiq_alhajj/features/islamic_tools/data/location/location_repository.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

String locationErrorMessage(AppLocalizations l10n, Object error) {
  if (error is LocationException) {
    return switch (error.failure) {
      LocationFailure.serviceDisabled => l10n.locationErrorServiceDisabled,
      LocationFailure.permissionDenied => l10n.locationErrorPermissionDenied,
      LocationFailure.permissionDeniedForever =>
        l10n.locationErrorPermissionDeniedForever,
      LocationFailure.unavailable => l10n.locationErrorUnavailable,
    };
  }
  return l10n.locationErrorUnavailable;
}
