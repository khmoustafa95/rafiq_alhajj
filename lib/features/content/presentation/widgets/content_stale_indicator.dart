import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/content/domain/models/catalog_snapshot.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Subtle badge when catalog data is served from cache or being refreshed.
class ContentStaleIndicator extends StatelessWidget {
  const ContentStaleIndicator({
    required this.snapshot,
    super.key,
  });

  final CatalogSnapshot<dynamic>? snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot == null) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);
    final showStale = snapshot!.isStale || snapshot!.isRefreshing;
    if (!showStale) {
      return const SizedBox.shrink();
    }

    final label = snapshot!.isRefreshing
        ? l10n.contentCatalogRefreshing
        : l10n.contentCatalogCached;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Row(
        children: [
          if (snapshot!.isRefreshing)
            Padding(
              padding: EdgeInsetsDirectional.only(end: 6.w),
              child: SizedBox(
                width: 12.w,
                height: 12.w,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            Icon(
              Icons.history_outlined,
              size: 14.sp,
              color: AppColors.textSecondary,
            ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
