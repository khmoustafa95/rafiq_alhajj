import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';

class CompetitionQuizFeedbackBanner extends StatelessWidget {
  const CompetitionQuizFeedbackBanner({
    required this.isCorrect,
    required this.title,
    this.explanation,
    required this.actionLabel,
    required this.onAction,
    super.key,
  });

  final bool isCorrect;
  final String title;
  final String? explanation;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = isCorrect ? AppColors.success : scheme.error;

    return AnimatedSlide(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      offset: Offset.zero,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.08),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppDecorations.radiusXl),
          ),
          border: Border(top: BorderSide(color: accent, width: 3)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(
                      isCorrect
                          ? Icons.celebration_rounded
                          : Icons.lightbulb_outline_rounded,
                      color: accent,
                      size: 28.sp,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: accent,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ],
                ),
                if (explanation != null && explanation!.isNotEmpty) ...[
                  SizedBox(height: 10.h),
                  Text(
                    explanation!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
                SizedBox(height: 16.h),
                FilledButton(
                  onPressed: onAction,
                  style: FilledButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: AppColors.onPrimary,
                    minimumSize: Size(double.infinity, 48.h),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDecorations.radiusMd),
                    ),
                  ),
                  child: Text(actionLabel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
