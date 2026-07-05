import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/theme/app_typography.dart';

/// Light and dark [ThemeData] for the application.
abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primary.withValues(alpha: 0.12),
      onPrimaryContainer: AppColors.primary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondary.withValues(alpha: 0.2),
      onSecondaryContainer: AppColors.primaryDark,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiary.withValues(alpha: 0.12),
      onTertiaryContainer: AppColors.tertiary,
      error: AppColors.error,
      onError: AppColors.onPrimary,
      surface: isLight ? AppColors.background : AppColors.backgroundDark,
      onSurface: isLight ? AppColors.textPrimary : AppColors.textPrimaryDark,
      onSurfaceVariant:
          isLight ? AppColors.textSecondary : AppColors.textSecondaryDark,
      outline: isLight ? AppColors.border : AppColors.borderDark,
      outlineVariant: isLight ? AppColors.divider : AppColors.dividerDark,
      shadow: AppColors.shadow,
      surfaceContainerLowest:
          isLight ? AppColors.surface : AppColors.surfaceDark,
      surfaceContainerLow:
          isLight ? AppColors.surface : AppColors.surfaceDark,
      surfaceContainer:
          isLight ? AppColors.surface : AppColors.surfaceDark,
      surfaceContainerHigh:
          isLight ? AppColors.surface : AppColors.surfaceDark,
      surfaceContainerHighest:
          isLight ? AppColors.surfaceMuted : AppColors.surfaceMutedDark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: AppTypography.textTheme(brightness),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.surfaceContainerHigh,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTypography.textTheme(brightness).titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: AppDecorations.cardRadius,
          side: BorderSide(color: colorScheme.outline),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.secondary,
          minimumSize: const Size.fromHeight(48),
          side: const BorderSide(color: AppColors.secondary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHigh,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: ChipThemeData(
        backgroundColor:
            isLight ? AppColors.chipInactive : AppColors.chipInactiveDark,
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: isLight
              ? AppColors.chipInactiveText
              : AppColors.chipInactiveTextDark,
        ),
        secondaryLabelStyle: const TextStyle(color: AppColors.onPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDecorations.radiusXl),
        ),
        side: BorderSide.none,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.fabGold,
        foregroundColor: AppColors.fabGoldIcon,
        elevation: 4,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surfaceContainerHigh,
        indicatorColor: AppColors.primary,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            );
          }
          return TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.onPrimary, size: 22);
          }
          return IconThemeData(
            color: colorScheme.onSurfaceVariant,
            size: 22,
          );
        }),
        height: 72,
        elevation: 8,
        shadowColor: AppColors.shadow,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: TextStyle(color: colorScheme.onSurface),
      ),
    );
  }
}
