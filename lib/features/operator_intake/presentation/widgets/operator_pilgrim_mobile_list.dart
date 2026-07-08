import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_list_formatters.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_mobile_card.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Mobile pilgrim registry list (non-web).
class OperatorPilgrimMobileList extends StatelessWidget {
  const OperatorPilgrimMobileList({
    required this.items,
    required this.onTap,
    required this.onAddPilgrim,
    super.key,
  });

  final List<OperatorPilgrimSummary> items;
  final ValueChanged<OperatorPilgrimSummary> onTap;
  final VoidCallback onAddPilgrim;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (items.isEmpty) {
      return StaffEmptyState(
        message: l10n.operatorPilgrimListEmpty,
        icon: Icons.people_outline,
        actionLabel: l10n.adminPilgrimAdd,
        onAction: onAddPilgrim,
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(sw(16)),
      itemCount: items.length,
      separatorBuilder: (_, _) => SizedBox(height: sh(10)),
      itemBuilder: (context, index) {
        final item = items[index];
        return OperatorPilgrimMobileCard(
          item: item,
          subtitle: OperatorPilgrimListFormatters.mobileSubtitle(
            context,
            l10n,
            item,
          ),
          onTap: () => onTap(item),
        );
      },
    );
  }
}
