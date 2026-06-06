import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/home_app_header.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/data/islamic_tools_catalog.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class IslamicToolsHubScreen extends StatelessWidget {
  const IslamicToolsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final inShell = !AppPlatform.isWeb;

    final tiles = islamicToolsCatalog(l10n);

    final body = ListView.separated(
      padding: EdgeInsets.all(16.w),
      itemCount: tiles.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final tile = tiles[index];
        return Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          child: InkWell(
            onTap: () => unawaited(context.push(tile.route)),
            borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
            child: Container(
              decoration: AppDecorations.card(),
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: tile.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(tile.icon, color: tile.color, size: 26.sp),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tile.title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          tile.subtitle,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (inShell) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeAppHeader(title: l10n.navGuidance, actions: const []),
              const Divider(height: 1),
              Expanded(child: body),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: RafiqAppBar(title: Text(l10n.toolsHubTitle)),
      body: body,
    );
  }
}
