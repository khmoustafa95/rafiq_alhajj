import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/models/qibla_state.dart';

class QiblaCompassWidget extends StatelessWidget {
  const QiblaCompassWidget({
    required this.state,
    super.key,
  });

  final QiblaState state;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final rotation = state.indicatorRotation;
    final rotationRadians =
        rotation != null ? rotation * math.pi / 180 : 0.0;

    return SizedBox(
      width: 260.w,
      height: 260.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 260.w,
            height: 260.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.outlineVariant, width: 2),
              color: colorScheme.surfaceContainerHighest,
            ),
            child: CustomPaint(
              painter: _CompassMarkingsPainter(color: colorScheme.outline),
            ),
          ),
          if (rotation != null)
            Transform.rotate(
              angle: rotationRadians,
              child: Icon(
                Icons.navigation,
                size: 72.sp,
                color: colorScheme.primary,
              ),
            )
          else
            Icon(
              Icons.explore_off_outlined,
              size: 48.sp,
              color: colorScheme.onSurfaceVariant,
            ),
        ],
      ),
    );
  }
}

class _CompassMarkingsPainter extends CustomPainter {
  _CompassMarkingsPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < 72; i++) {
      final angle = i * math.pi / 36;
      final inner = i % 9 == 0 ? radius - 16 : radius - 8;
      final start = Offset(
        center.dx + inner * math.sin(angle),
        center.dy - inner * math.cos(angle),
      );
      final end = Offset(
        center.dx + radius * math.sin(angle),
        center.dy - radius * math.cos(angle),
      );
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
