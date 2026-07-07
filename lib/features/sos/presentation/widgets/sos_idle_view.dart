import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class SosIdleView extends StatelessWidget {
  const SosIdleView({
    required this.isBusy,
    required this.onRaise,
    super.key,
  });

  final bool isBusy;
  final VoidCallback onRaise;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24.h),
          Center(
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.sos_rounded,
                size: 64.sp,
                color: AppColors.error,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            l10n.sosIntro,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
          ),
          SizedBox(height: 32.h),
          Semantics(
            button: true,
            label: l10n.sosRaiseButton,
            enabled: !isBusy,
            child: FilledButton.icon(
              onPressed: isBusy ? null : onRaise,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 18.h),
              ),
              icon: isBusy
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.onPrimary,
                      ),
                    )
                  : const Icon(Icons.campaign_rounded),
              label: Text(l10n.sosRaiseButton),
            ),
          ),
        ],
      ),
    );
  }
}
