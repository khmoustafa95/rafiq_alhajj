import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Prominent SOS entry on the pilgrim home screen.
class SosHomeCard extends StatelessWidget {
  const SosHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Material(
      color: AppColors.error,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: () => unawaited(context.push(AppRoutes.sos)),
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: AppColors.onPrimary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  Icons.sos_rounded,
                  color: AppColors.onPrimary,
                  size: 28.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.sosHomeButton,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      l10n.sosHomeSubtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.onPrimary.withValues(alpha: 0.9),
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.onPrimary.withValues(alpha: 0.9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
