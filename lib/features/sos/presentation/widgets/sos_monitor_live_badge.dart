import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Pulsing "live" indicator with the active SOS alert count.
class SosMonitorLiveBadge extends StatelessWidget {
  const SosMonitorLiveBadge({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.only(end: sw(8)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sw(10), vertical: sh(6)),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ss(8),
              height: ss(8),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: sw(6)),
            Text(
              '${l10n.sosMonitorLive} · ${l10n.sosMonitorActiveCount(count)}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
