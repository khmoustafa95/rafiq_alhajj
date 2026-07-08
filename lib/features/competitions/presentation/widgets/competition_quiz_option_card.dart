import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';

enum CompetitionQuizOptionState {
  idle,
  selected,
  correct,
  incorrect,
  revealCorrect,
}

class CompetitionQuizOptionCard extends StatelessWidget {
  const CompetitionQuizOptionCard({
    required this.label,
    required this.letter,
    required this.state,
    required this.onTap,
    super.key,
  });

  final String label;
  final String letter;
  final CompetitionQuizOptionState state;
  final VoidCallback? onTap;

  Color _borderColor(ColorScheme scheme) {
    return switch (state) {
      CompetitionQuizOptionState.correct ||
      CompetitionQuizOptionState.revealCorrect =>
        AppColors.success,
      CompetitionQuizOptionState.incorrect => scheme.error,
      CompetitionQuizOptionState.selected => AppColors.primary,
      CompetitionQuizOptionState.idle => scheme.outline,
    };
  }

  Color _fillColor(ColorScheme scheme) {
    return switch (state) {
      CompetitionQuizOptionState.correct ||
      CompetitionQuizOptionState.revealCorrect =>
        AppColors.success.withValues(alpha: 0.1),
      CompetitionQuizOptionState.incorrect =>
        scheme.error.withValues(alpha: 0.1),
      CompetitionQuizOptionState.selected =>
        AppColors.primary.withValues(alpha: 0.08),
      CompetitionQuizOptionState.idle => scheme.surface,
    };
  }

  Color _badgeColor(ColorScheme scheme) {
    return switch (state) {
      CompetitionQuizOptionState.correct ||
      CompetitionQuizOptionState.revealCorrect =>
        AppColors.success,
      CompetitionQuizOptionState.incorrect => scheme.error,
      CompetitionQuizOptionState.selected => AppColors.primary,
      CompetitionQuizOptionState.idle => scheme.surfaceContainerHigh,
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final borderColor = _borderColor(scheme);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: _fillColor(scheme),
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        border: Border.all(
          color: borderColor,
          width: state == CompetitionQuizOptionState.idle ? 1 : 2,
        ),
        boxShadow: state == CompetitionQuizOptionState.selected
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 36.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _badgeColor(scheme),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    letter,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: state == CompetitionQuizOptionState.idle
                              ? scheme.onSurface
                              : AppColors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: state == CompetitionQuizOptionState.selected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                  ),
                ),
                if (state == CompetitionQuizOptionState.correct ||
                    state == CompetitionQuizOptionState.revealCorrect)
                  const Icon(Icons.check_circle_rounded, color: AppColors.success)
                else if (state == CompetitionQuizOptionState.incorrect)
                  Icon(Icons.cancel_rounded, color: scheme.error),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
