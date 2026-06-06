import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class QuickActionTiles extends StatelessWidget {
  const QuickActionTiles({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final items = [
      _QuickAction(
        icon: Icons.menu_book_rounded,
        label: l10n.toolsQuranTitle,
        color: AppColors.primary.withValues(alpha: 0.12),
        iconColor: AppColors.primary,
        route: AppRoutes.quran,
      ),
      _QuickAction(
        icon: Icons.explore_rounded,
        label: l10n.toolsQiblaTitle,
        color: AppColors.secondary.withValues(alpha: 0.2),
        iconColor: AppColors.primaryDark,
        route: AppRoutes.qibla,
      ),
      _QuickAction(
        icon: Icons.schedule_rounded,
        label: l10n.toolsPrayerTimesTitle,
        color: AppColors.tertiary.withValues(alpha: 0.12),
        iconColor: AppColors.tertiary,
        route: AppRoutes.prayerTimes,
      ),
    ];

    return Row(
      children: items.map((item) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: item == items.last ? 0 : 10.w,
            ),
            child: Material(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
              child: InkWell(
                onTap: () => unawaited(context.push(item.route)),
                borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Column(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: item.color,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(item.icon, color: item.iconColor, size: 24.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        item.label,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _QuickAction {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
    required this.route,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;
  final String route;
}
