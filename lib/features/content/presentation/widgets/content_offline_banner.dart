import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/network/staff_connectivity.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Pilgrim-facing banner shown when the device has no network connectivity.
class ContentOfflineBanner extends ConsumerWidget {
  const ContentOfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final online = ref.watch(staffConnectivityProvider);
    if (online) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);
    return Material(
      color: AppColors.secondary.withValues(alpha: 0.9),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            Icon(Icons.cloud_off_outlined, size: 18.sp, color: AppColors.primaryDark),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                l10n.contentOfflineBanner,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
