import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/virtual_tour/domain/data/haram_landmarks.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class HaramGuidePanel extends StatelessWidget {
  const HaramGuidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;

    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          child: Image.asset(
            'assets/virtual_tour/images/kaaba.jpg',
            height: 180.h,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              height: 180.h,
              color: AppColors.primary.withValues(alpha: 0.12),
              child: Icon(
                Icons.mosque_rounded,
                size: 64.sp,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          l10n.toolsVirtualTourPhotoCredit,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
            border: Border.all(
              color: AppColors.warning.withValues(alpha: 0.35),
            ),
          ),
          child: Text(
            l10n.toolsVirtualTourDisclaimer,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          l10n.toolsVirtualTourGuideHeading,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        SizedBox(height: 12.h),
        ...haramLandmarks.map(
          (landmark) => _LandmarkGuideCard(
            landmark: landmark,
            languageCode: lang,
            stepsLabel: l10n.toolsVirtualTourStepsLabel,
            tipsLabel: l10n.toolsVirtualTourTipsLabel,
            ritualLabel: l10n.toolsVirtualTourRitualLabel,
          ),
        ),
      ],
    );
  }
}

class _LandmarkGuideCard extends StatelessWidget {
  const _LandmarkGuideCard({
    required this.landmark,
    required this.languageCode,
    required this.stepsLabel,
    required this.tipsLabel,
    required this.ritualLabel,
  });

  final HaramLandmark landmark;
  final String languageCode;
  final String stepsLabel;
  final String tipsLabel;
  final String ritualLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: landmark.color.withValues(alpha: 0.12),
            child: Icon(landmark.icon, color: landmark.color, size: 22.sp),
          ),
          title: Text(
            landmark.titleFor(languageCode),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(
            landmark.summaryFor(languageCode),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoChip(
                    label: ritualLabel,
                    value: landmark.ritualFor(languageCode),
                    color: landmark.color,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    stepsLabel,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 6.h),
                  ...landmark.stepsFor(languageCode).map(
                        (step) => Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• ', style: TextStyle(fontSize: 14.sp)),
                              Expanded(
                                child: Text(
                                  step,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  SizedBox(height: 12.h),
                  Text(
                    tipsLabel,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 6.h),
                  ...landmark.tipsFor(languageCode).map(
                        (tip) => Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                size: 16.sp,
                                color: AppColors.secondary,
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  tip,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
