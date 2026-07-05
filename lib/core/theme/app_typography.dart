import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';

abstract final class AppTypography {
  static TextTheme textTheme(Brightness brightness) {
    final base = ThemeData(brightness: brightness).textTheme;
    final isLight = brightness == Brightness.light;
    final color =
        isLight ? AppColors.textPrimary : AppColors.textPrimaryDark;
    final secondary =
        isLight ? AppColors.textSecondary : AppColors.textSecondaryDark;

    return base.copyWith(
      displaySmall: base.displaySmall?.copyWith(
        fontWeight: FontWeight.w700,
        color: color,
        height: 1.2,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: color,
        height: 1.25,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: color,
        height: 1.3,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: color,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: color,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: color,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 16,
        color: color,
        height: 1.5,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 14,
        color: secondary,
        height: 1.5,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontSize: 12,
        color: secondary,
        height: 1.4,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: color,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: secondary,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        color: secondary,
      ),
    );
  }
}
