import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/providers/hajj_journey_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminHajjJourneyListScreen extends ConsumerWidget {
  const AdminHajjJourneyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final stepsAsync = ref.watch(adminHajjJourneyStepsProvider);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: RafiqAppBar(title: Text(l10n.adminHajjJourneyTitle)),
      body: stepsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.adminHajjJourneyLoadError)),
        data: (steps) {
          if (steps.isEmpty) {
            return Center(child: Text(l10n.adminHajjJourneyEmpty));
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(adminHajjJourneyStepsProvider);
            },
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: steps.length,
              separatorBuilder: (_, _) => SizedBox(height: 10.h),
              itemBuilder: (context, index) {
                final step = steps[index];
                return _StepCard(
                  step: step,
                  title: isArabic ? step.titleAr : step.titleEn,
                  mediaCount: step.media.length,
                  onTap: () => unawaited(
                    context.push(
                      AppRoutes.adminHajjJourneyEditPath(step.ritualKey),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.step,
    required this.title,
    required this.mediaCount,
    required this.onTap,
  });

  final HajjJourneyStep step;
  final String title;
  final int mediaCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: Container(
          decoration: AppDecorations.card(),
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: Text('${step.sortOrder}'),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      l10n.adminHajjJourneyMediaCount(mediaCount),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              if (!step.isActive)
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 8.w),
                  child: Chip(
                    label: Text(l10n.adminHajjJourneyInactive),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
