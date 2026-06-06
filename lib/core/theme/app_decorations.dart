import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';

abstract final class AppDecorations {
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;

  static BorderRadius get cardRadius => BorderRadius.circular(radiusMd);

  static List<BoxShadow> get cardShadow => const [
        BoxShadow(
          color: AppColors.shadow,
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ];

  static BoxDecoration card({
    Color? color,
    Border? border,
    double radius = radiusMd,
  }) {
    return BoxDecoration(
      color: color ?? AppColors.surface,
      borderRadius: BorderRadius.circular(radius),
      border: border ?? Border.all(color: AppColors.border),
      boxShadow: cardShadow,
    );
  }
}
