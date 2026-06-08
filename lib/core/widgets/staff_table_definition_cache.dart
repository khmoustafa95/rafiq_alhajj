import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Caches [StaffTableColumn] and [StaffTableFilter] lists per locale so list
/// screens do not rebuild column/filter metadata on every frame.
class StaffTableDefinitionCache<T> {
  StaffTableDefinitionCache({
    required this.buildColumns,
    this.buildFilters,
  });

  final List<StaffTableColumn<T>> Function(AppLocalizations l10n) buildColumns;
  final List<StaffTableFilter> Function(AppLocalizations l10n)? buildFilters;

  Locale? _locale;
  List<StaffTableColumn<T>>? _columns;
  List<StaffTableFilter>? _filters;
  Object? _filtersExtraKey;

  List<StaffTableColumn<T>> columns(BuildContext context) {
    _syncLocale(context);
    return _columns!;
  }

  List<StaffTableFilter> filters(
    BuildContext context, {
    Object? extraKey,
  }) {
    if (buildFilters == null) {
      return const [];
    }

    _syncLocale(context);

    if (_filtersExtraKey != extraKey || _filters == null) {
      _filtersExtraKey = extraKey;
      _filters = buildFilters!(AppLocalizations.of(context));
    }

    return _filters!;
  }

  void _syncLocale(BuildContext context) {
    final locale = Localizations.localeOf(context);
    if (_locale == locale && _columns != null) {
      return;
    }

    _locale = locale;
    final l10n = AppLocalizations.of(context);
    _columns = buildColumns(l10n);
    _filters = null;
    _filtersExtraKey = null;
  }
}
