import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class CompetitionListCard extends StatelessWidget {
  const CompetitionListCard({
    required this.competition,
    required this.onTap,
    super.key,
  });

  final Competition competition;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
        child: Ink(
          decoration: AppDecorations.card(
            radius: AppDecorations.radiusLg,
          ),
          child: Stack(
            children: [
              PositionedDirectional(
                end: -12,
                bottom: -12,
                child: Icon(
                  Icons.emoji_events_rounded,
                  size: 88.sp,
                  color: AppColors.primary.withValues(alpha: 0.06),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: competition.isOpen
                              ? [
                                  AppColors.secondary.withValues(alpha: 0.9),
                                  AppColors.secondary,
                                ]
                              : [
                                  AppColors.chipInactive,
                                  AppColors.border,
                                ],
                        ),
                        borderRadius:
                            BorderRadius.circular(AppDecorations.radiusMd),
                      ),
                      child: Icon(
                        competition.isOpen
                            ? Icons.school_rounded
                            : Icons.schedule_rounded,
                        color: competition.isOpen
                            ? AppColors.onSecondary
                            : AppColors.chipInactiveText,
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            competition.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            competition.description ??
                                l10n.competitionsNoDescription,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: competition.isOpen
                                  ? AppColors.success.withValues(alpha: 0.12)
                                  : scheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              competition.isOpen
                                  ? l10n.competitionStatusOpen
                                  : l10n.competitionStatusUpcoming,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: competition.isOpen
                                        ? AppColors.success
                                        : AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16.sp,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
