import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_search_item.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_colors.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class PilgrimListTile extends StatelessWidget {
  const PilgrimListTile({
    required this.item,
    required this.onTap,
    super.key,
  });

  final PilgrimSearchItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final statusLabel = fieldStatusLabel(l10n, item.fieldStatus);
    final statusBg = FieldStatusColors.background(item.fieldStatus);
    final statusFg = FieldStatusColors.foreground(item.fieldStatus);
    final initial = item.fullName.isNotEmpty ? item.fullName[0] : '?';

    final subtitleParts = <String>[
      if (item.groupName != null) item.groupName!,
      if (item.stickerNumber != null)
        '${l10n.pilgrimLabelSticker}: ${item.stickerNumber}',
      if (item.passportNumber != null)
        '${l10n.operatorPassport}: ${item.passportNumber}',
    ];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  initial,
                  style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.fullName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (subtitleParts.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        subtitleParts.join(' · '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      statusLabel,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: statusFg,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
