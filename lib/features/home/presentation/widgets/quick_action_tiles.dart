import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/section_header.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/data/islamic_tools_catalog.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class QuickActionTiles extends StatelessWidget {
  const QuickActionTiles({super.key});

  static const double _tileWidth = 96;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = islamicToolsCatalog(l10n);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l10n.homeQuickActionsTitle,
          seeAllLabel: l10n.homeSeeAll,
          onSeeAll: () => context.go(AppRoutes.tools),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 12.h),
        ),
        SizedBox(
          height: 112.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: items.length,
            separatorBuilder: (_, _) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final item = items[index];
              return SizedBox(
                width: _tileWidth.w,
                child: Material(
                  color: AppColors.surfaceMuted,
                  borderRadius:
                      BorderRadius.circular(AppDecorations.radiusMd),
                  child: InkWell(
                    onTap: () => unawaited(context.push(item.route)),
                    borderRadius:
                        BorderRadius.circular(AppDecorations.radiusMd),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      child: Column(
                        children: [
                          Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: item.color.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item.icon,
                              color: item.color,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            item.title,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: AppColors.textPrimary),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
