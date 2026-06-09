import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';

enum CompetitionLessonNodeStatus {
  completed,
  current,
  locked,
}

/// Circular lesson node for the Duolingo-style learning path.
class CompetitionLessonNode extends StatefulWidget {
  const CompetitionLessonNode({
    required this.index,
    required this.status,
    required this.onTap,
    this.points,
    super.key,
  });

  final int index;
  final CompetitionLessonNodeStatus status;
  final VoidCallback? onTap;
  final int? points;

  @override
  State<CompetitionLessonNode> createState() => _CompetitionLessonNodeState();
}

class _CompetitionLessonNodeState extends State<CompetitionLessonNode>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    if (widget.status == CompetitionLessonNodeStatus.current) {
      unawaited(_pulseController.repeat(reverse: true));
    }
  }

  @override
  void didUpdateWidget(CompetitionLessonNode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status == CompetitionLessonNodeStatus.current) {
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
      CompetitionLessonNodeStatus.completed => AppColors.success,
      CompetitionLessonNodeStatus.current => AppColors.secondary,
      CompetitionLessonNodeStatus.locked => AppColors.chipInactive,
    };
  }

  Color _iconColor(ColorScheme scheme) {
    return switch (widget.status) {
      CompetitionLessonNodeStatus.completed => AppColors.onPrimary,
      CompetitionLessonNodeStatus.current => AppColors.onSecondary,
      CompetitionLessonNodeStatus.locked => AppColors.chipInactiveText,
    };
  }

  IconData _icon() {
    return switch (widget.status) {
      CompetitionLessonNodeStatus.completed => Icons.check_rounded,
      CompetitionLessonNodeStatus.current => Icons.play_arrow_rounded,
      CompetitionLessonNodeStatus.locked => Icons.lock_outline_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = widget.status == CompetitionLessonNodeStatus.current
        ? 76.w
        : 64.w;

    Widget node = Material(
      elevation: widget.status == CompetitionLessonNodeStatus.current ? 6 : 2,
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
            size: widget.status == CompetitionLessonNodeStatus.current
                ? 34.sp
                : 28.sp,
          ),
        ),
      ),
    );

    if (widget.status == CompetitionLessonNodeStatus.current) {
      node = AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final scale = 1 + (_pulseController.value * 0.08);
          return Transform.scale(scale: scale, child: child);
        },
        child: node,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        node,
        SizedBox(height: 6.h),
        Text(
          '${widget.index + 1}',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: widget.status == CompetitionLessonNodeStatus.locked
                    ? AppColors.textSecondary
                    : AppColors.textPrimary,
                fontWeight: widget.status == CompetitionLessonNodeStatus.current
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
    );
  }
}
