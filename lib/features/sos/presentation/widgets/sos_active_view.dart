import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_alert.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class SosActiveView extends StatelessWidget {
  const SosActiveView({
    required this.alert,
    required this.isBusy,
    required this.onCancel,
    super.key,
  });

  final SosAlert alert;
  final bool isBusy;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lastUpdate = alert.lastLocationAt;

    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.h),
          Center(
            child: Container(
              width: 110.w,
              height: 110.w,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.verified_user_rounded,
                size: 56.sp,
                color: AppColors.success,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            l10n.sosActiveTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.sosActiveBody,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
          ),
          SizedBox(height: 24.h),
          Container(
            decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.sosSharingLocation,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      if (lastUpdate != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          l10n.sosLastUpdate(
                            TimeOfDay.fromDateTime(lastUpdate).format(context),
                          ),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ] else ...[
                        SizedBox(height: 4.h),
                        Text(
                          l10n.sosLocationPending,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Semantics(
            button: true,
            label: l10n.sosCancelButton,
            enabled: !isBusy,
            child: OutlinedButton.icon(
              onPressed: isBusy ? null : onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.success,
                padding: EdgeInsets.symmetric(vertical: 16.h),
              ),
              icon: const Icon(Icons.check_circle_outline),
              label: Text(l10n.sosCancelButton),
            ),
          ),
        ],
      ),
    );
  }
}
