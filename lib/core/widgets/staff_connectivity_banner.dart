import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/network/staff_connectivity.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Thin offline banner shown at the top of staff web pages.
class StaffConnectivityBanner extends ConsumerWidget {
  const StaffConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!AppPlatform.isWeb) {
      return const SizedBox.shrink();
    }

    final isOnline = ref.watch(staffConnectivityProvider);
    if (isOnline) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);

    return Material(
      color: AppColors.warning.withValues(alpha: 0.15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sw(16), vertical: sh(8)),
        child: Row(
          children: [
            Icon(Icons.wifi_off_rounded, color: AppColors.warning, size: ss(18)),
            SizedBox(width: sw(8)),
            Expanded(
              child: Text(
                l10n.staffOfflineBanner,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  ref.read(staffConnectivityProvider.notifier).refresh(),
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
