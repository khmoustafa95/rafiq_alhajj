import 'package:rafiq_alhajj/features/auth/data/repositories/supabase_auth_repository.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

String authErrorMessage(AppLocalizations l10n, Object error) {
  if (error is PilgrimAuthException) {
    return switch (error.code) {
      PilgrimAuthErrorCode.invalidCredentials => l10n.authErrorInvalidCredentials,
      PilgrimAuthErrorCode.emailNotConfirmed => l10n.authErrorEmailNotConfirmed,
      PilgrimAuthErrorCode.notPilgrimRole => l10n.authErrorNotPilgrimRole,
      PilgrimAuthErrorCode.notStaffRole => l10n.authErrorNotStaffRole,
      PilgrimAuthErrorCode.notAdminRole => l10n.authErrorNotAdminRole,
      PilgrimAuthErrorCode.profileNotFound => l10n.authErrorProfileNotFound,
      PilgrimAuthErrorCode.network => l10n.authErrorSupabaseUnavailable,
      PilgrimAuthErrorCode.unknown => l10n.authErrorUnknown,
    };
  }
  return l10n.authErrorUnknown;
}
