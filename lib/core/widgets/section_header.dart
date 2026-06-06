import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.seeAllLabel,
    this.onSeeAll,
    this.padding,
    super.key,
  });

  final String title;
  final String? seeAllLabel;
  final VoidCallback? onSeeAll;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final showSeeAll =
        seeAllLabel != null && onSeeAll != null;

    return Padding(
      padding: padding ?? EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          if (showSeeAll)
            TextButton(
              onPressed: onSeeAll,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                seeAllLabel!,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.primary,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
