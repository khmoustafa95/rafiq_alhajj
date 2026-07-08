import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_colors.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_l10n.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class FieldOperatorPilgrimHeaderCard extends StatelessWidget {
  const FieldOperatorPilgrimHeaderCard({
    required this.pilgrim,
    required this.name,
    super.key,
  });

  final Pilgrim pilgrim;
  final String name;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final statusLabel = fieldStatusLabel(l10n, pilgrim.fieldStatus);
    final statusBg = FieldStatusColors.background(pilgrim.fieldStatus);
    final statusFg = FieldStatusColors.foreground(pilgrim.fieldStatus);
    final initial = name.isNotEmpty ? name[0] : '?';

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: Text(
                initial,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (pilgrim.groupName != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      pilgrim.groupName!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                  if (pilgrim.stickerNumber != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      '${l10n.pilgrimLabelSticker}: ${pilgrim.stickerNumber}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: statusBg,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                statusLabel,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: statusFg,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
