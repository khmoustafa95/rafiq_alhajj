import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';

class CompetitionQuizTopBar extends StatelessWidget {
  const CompetitionQuizTopBar({
    required this.currentIndex,
    required this.total,
    required this.onClose,
    super.key,
  });

  final int currentIndex;
  final int total;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 4.h, 16.w, 12.h),
      child: Row(
        children: [
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded),
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          ),
          Expanded(
            child: Row(
              children: List.generate(total, (index) {
                final isPast = index < currentIndex;
                final isCurrent = index == currentIndex;

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: isPast || isCurrent
                            ? AppColors.primary
                            : AppColors.border,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
