import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/learning_path/learning_path_node_status.dart';

/// Circular lesson node for Duolingo-style learning paths.
class LearningPathLessonNode extends StatefulWidget {
  const LearningPathLessonNode({
    required this.index,
    required this.status,
    required this.onTap,
    this.points,
    super.key,
  });

  final int index;
  final LearningPathNodeStatus status;
  final VoidCallback? onTap;
  final int? points;

  @override
  State<LearningPathLessonNode> createState() => _LearningPathLessonNodeState();
}

class _LearningPathLessonNodeState extends State<LearningPathLessonNode>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    if (widget.status == LearningPathNodeStatus.current) {
      unawaited(_pulseController.repeat(reverse: true));
    }
  }

  @override
  void didUpdateWidget(LearningPathLessonNode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status == LearningPathNodeStatus.current) {
      if (!_pulseController.isAnimating) {
        unawaited(_pulseController.repeat(reverse: true));
      }
    } else {
      _pulseController.stop();
      _pulseController.value = 0;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color _fillColor(ColorScheme scheme) {
    return switch (widget.status) {
      LearningPathNodeStatus.completed => AppColors.success,
      LearningPathNodeStatus.current => AppColors.secondary,
      LearningPathNodeStatus.locked => AppColors.chipInactive,
    };
  }

  Color _iconColor(ColorScheme scheme) {
    return switch (widget.status) {
      LearningPathNodeStatus.completed => AppColors.onPrimary,
      LearningPathNodeStatus.current => AppColors.onSecondary,
      LearningPathNodeStatus.locked => AppColors.chipInactiveText,
    };
  }

  IconData _icon() {
    return switch (widget.status) {
      LearningPathNodeStatus.completed => Icons.check_rounded,
      LearningPathNodeStatus.current => Icons.play_arrow_rounded,
      LearningPathNodeStatus.locked => Icons.lock_outline_rounded,
    };
  }

  String _semanticsLabel() {
    final step = widget.index + 1;
    return switch (widget.status) {
      LearningPathNodeStatus.completed => 'Step $step, completed',
      LearningPathNodeStatus.current => 'Step $step, current',
      LearningPathNodeStatus.locked => 'Step $step, locked',
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = widget.status == LearningPathNodeStatus.current ? 76.w : 64.w;

    Widget node = Material(
      elevation: widget.status == LearningPathNodeStatus.current ? 6 : 2,
      shadowColor: AppColors.shadow,
      shape: const CircleBorder(),
      color: _fillColor(scheme),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: widget.onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            _icon(),
            color: _iconColor(scheme),
            size: widget.status == LearningPathNodeStatus.current ? 34.sp : 28.sp,
          ),
        ),
      ),
    );

    if (widget.status == LearningPathNodeStatus.current) {
      node = AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final scale = 1 + (_pulseController.value * 0.08);
          return Transform.scale(scale: scale, child: child);
        },
        child: node,
      );
    }

    return Semantics(
      button: widget.status != LearningPathNodeStatus.locked,
      enabled: widget.status != LearningPathNodeStatus.locked,
      label: _semanticsLabel(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          node,
          SizedBox(height: 6.h),
          Text(
            '${widget.index + 1}',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: widget.status == LearningPathNodeStatus.locked
                      ? AppColors.textSecondary
                      : AppColors.textPrimary,
                  fontWeight: widget.status == LearningPathNodeStatus.current
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
          ),
          if (widget.points != null && widget.points! > 0) ...[
            SizedBox(height: 2.h),
            Text(
              '+${widget.points}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
