import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class CompetitionListHero extends StatelessWidget {
  const CompetitionListHero({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.tertiary],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: -8,
            bottom: -16,
            child: Icon(
              Icons.auto_stories_rounded,
              size: 96.sp,
              color: AppColors.textOnDark.withValues(alpha: 0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  l10n.competitionLearnBadge,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                l10n.competitionLearnHeroTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textOnDark,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              SizedBox(height: 8.h),
              Text(
                l10n.competitionLearnHeroSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMutedOnDark,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
