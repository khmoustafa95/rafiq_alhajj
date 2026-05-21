import 'package:rafiq_alhajj/features/admin_analytics/data/repositories/admin_analytics_repository.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

String chartSliceLabel(AppLocalizations l10n, String key) {
  if (key == kUnassignedGroupKey) {
    return l10n.adminUnassignedGroup;
  }
  if (key == kUnknownOperatorKey) {
    return l10n.adminUnknownOperator;
  }
  if (FieldPilgrimStatus.values.contains(key)) {
    return fieldStatusLabel(l10n, key);
  }
  return key;
}
