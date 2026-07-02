import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/section_header.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Pilgrim shortcuts to learning hub features (My Learning, search, downloads).
class ContentHubQuickActions extends StatelessWidget {
  const ContentHubQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final actions = [
      _HubAction(
        icon: Icons.school_outlined,
        label: l10n.contentMyLearningTitle,
        color: AppColors.primary,
        route: AppRoutes.contentMyLearning,
      ),
      _HubAction(
        icon: Icons.search,
        label: l10n.contentSearchTitle,
        color: AppColors.tertiary,
        route: AppRoutes.contentSearch,
      ),
      _HubAction(
        icon: Icons.folder_outlined,
        label: l10n.contentDownloadsTitle,
        color: AppColors.primaryDark,
        route: AppRoutes.contentDownloads,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l10n.contentHubQuickActionsTitle,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 12.h),
        ),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: actions.length,
            separatorBuilder: (_, _) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final action = actions[index];
              return _HubTile(action: action);
            },
          ),
        ),
      ],
    );
  }
}

class _HubAction {
  const _HubAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.route,
  });

  final IconData icon;
  final String label;
  final Color color;
  final String route;
}

class _HubTile extends StatelessWidget {
  const _HubTile({required this.action});

  final _HubAction action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 108.w,
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: InkWell(
          onTap: () => unawaited(context.push(action.route)),
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          child: Ink(
            decoration: AppDecorations.card(radius: AppDecorations.radiusMd),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: action.color.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(action.icon, color: action.color, size: 22.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    action.label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
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
  }
}
