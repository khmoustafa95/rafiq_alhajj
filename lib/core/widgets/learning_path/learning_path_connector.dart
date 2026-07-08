import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';

/// Curved connector between lesson nodes on a zigzag learning path.
class LearningPathConnector extends StatelessWidget {
  const LearningPathConnector({
    required this.fromRight,
    this.isCompleted = false,
    super.key,
  });

  final bool fromRight;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      height: 48.h,
      child: CustomPaint(
        painter: _PathConnectorPainter(
          fromRight: fromRight,
          color: isCompleted ? AppColors.success : AppColors.border,
        ),
      ),
    );
  }
}

class _PathConnectorPainter extends CustomPainter {
  _PathConnectorPainter({
    required this.fromRight,
    required this.color,
  });

  final bool fromRight;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final start = fromRight
        ? Offset(size.width * 0.75, 0)
        : Offset(size.width * 0.25, 0);
    final end = fromRight
        ? Offset(size.width * 0.25, size.height)
        : Offset(size.width * 0.75, size.height);

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..cubicTo(
        start.dx,
        size.height * 0.45,
        end.dx,
        size.height * 0.55,
        end.dx,
        end.dy,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _PathConnectorPainter oldDelegate) {
    return oldDelegate.fromRight != fromRight || oldDelegate.color != color;
  }
}
