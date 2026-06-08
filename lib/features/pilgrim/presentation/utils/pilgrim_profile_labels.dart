import 'package:rafiq_alhajj/l10n/app_localizations.dart';

typedef PilgrimLabelFn = String Function(AppLocalizations l10n);

abstract final class PilgrimProfileLabels {
  static String yesNo(AppLocalizations l10n, bool? value) {
    if (value == null) {
      return l10n.pilgrimNotProvided;
    }
    return value ? l10n.pilgrimYes : l10n.pilgrimNo;
  }
}
