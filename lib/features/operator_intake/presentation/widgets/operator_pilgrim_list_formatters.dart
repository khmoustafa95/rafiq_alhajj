import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_table_definitions.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Formats pilgrim summary lines for mobile list cards.
abstract final class OperatorPilgrimListFormatters {
  static String mobileSubtitle(
    BuildContext context,
    AppLocalizations l10n,
    OperatorPilgrimSummary item,
  ) {
    final parts = <String>[];
    if (item.gender != null) {
      parts.add(OperatorPilgrimTableDefinitions.genderLabel(l10n, item.gender));
    }
    if (item.groupName != null) {
      parts.add(item.groupName!);
    }
    if (item.passportNumber != null) {
      parts.add('${l10n.operatorPassport}: ${item.passportNumber}');
    }
    if (item.travelDate != null) {
      parts.add(
        '${l10n.pilgrimTravelDate}: '
        '${MaterialLocalizations.of(context).formatMediumDate(item.travelDate!)}',
      );
    }
    return parts.isEmpty ? l10n.operatorPilgrimNoLogisticsYet : parts.join(' · ');
  }
}
