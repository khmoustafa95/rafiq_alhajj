import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/learning_path/learning_path_connector.dart';
import 'package:rafiq_alhajj/core/widgets/learning_path/learning_path_lesson_node.dart';
import 'package:rafiq_alhajj/core/widgets/learning_path/learning_path_node_status.dart';

/// Shared zigzag learning-path layout used by competitions and Hajj journey.
class LearningPathScaffold extends StatelessWidget {
  const LearningPathScaffold({
    required this.title,
    required this.subtitle,
    required this.itemCount,
    required this.isCompleted,
    required this.onStepTap,
    this.onLockedTap,
    this.emptyMessage,
    this.emptyIcon,
    this.pointsForIndex,
    this.captionBuilder,
    this.nodeHorizontalPadding = 24,
    super.key,
  });

  final String title;
  final String subtitle;
  final int itemCount;
  final bool Function(int index) isCompleted;
  final ValueChanged<int> onStepTap;
  final VoidCallback? onLockedTap;
  final String? emptyMessage;
  final IconData? emptyIcon;
  final int? Function(int index)? pointsForIndex;
  final Widget? Function(
    BuildContext context,
    int index,
    LearningPathNodeStatus status,
  )? captionBuilder;
  final double nodeHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      final message = emptyMessage ?? '';
      return DecoratedBox(
        decoration: AppDecorations.themedCard(context),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: emptyIcon == null
              ? Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                )
              : Row(
                  children: [
                    Icon(
                      emptyIcon,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 28.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ),
                  ],
                ),
        ),
      );
    }

    return DecoratedBox(
      decoration: AppDecorations.themedCard(
        context,
        radius: AppDecorations.radiusLg,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            SizedBox(height: 20.h),
            for (var i = 0; i < itemCount; i++) ...[
              if (i > 0)
                Align(
                  alignment: i.isOdd
                      ? AlignmentDirectional.centerEnd
                      : AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: i.isOdd ? 0 : nodeHorizontalPadding.w,
                      end: i.isOdd ? nodeHorizontalPadding.w : 0,
                    ),
                    child: LearningPathConnector(
                      fromRight: i.isOdd,
                      isCompleted: isCompleted(i - 1),
                    ),
                  ),
                ),
              Align(
                alignment: i.isEven
                    ? AlignmentDirectional.centerStart
                    : AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: nodeHorizontalPadding.w),
                  child: _buildNode(context, i),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNode(BuildContext context, int index) {
    final status = learningPathStatusFor(
      index: index,
      itemCount: itemCount,
      isCompleted: isCompleted,
    );
    final caption = captionBuilder?.call(context, index, status);

    final node = LearningPathLessonNode(
      index: index,
      status: status,
      points: pointsForIndex?.call(index),
      onTap: () {
        if (status == LearningPathNodeStatus.locked) {
          onLockedTap?.call();
          return;
        }
        onStepTap(index);
      },
    );

    if (caption == null) {
      return node;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        node,
        caption,
      ],
    );
  }
}
