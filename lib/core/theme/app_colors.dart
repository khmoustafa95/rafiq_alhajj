import 'package:flutter/material.dart';

/// Design tokens from the Hajj Companion visual system.
abstract final class AppColors {
  static const Color primary = Color(0xFF065F46);
  static const Color primaryDark = Color(0xFF064E3B);
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFFD4AF37);
  static const Color onSecondary = Color(0xFF065F46);

  static const Color tertiary = Color(0xFF312E81);
  static const Color onTertiary = Color(0xFFFFFFFF);

  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF3F4F6);

  /// Subtle tint used to highlight unread notification rows.
  static const Color notificationUnread = Color(0xFFF0FDF7);

  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textMutedOnDark = Color(0xFFD1FAE5);

  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFE5E7EB);

  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF3B82F6);

  static const Color accentRed = Color(0xFFEF4444);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentTeal = Color(0xFF14B8A6);

  static const Color fabGold = Color(0xFFFFD54F);
  static const Color fabGoldIcon = Color(0xFF5D4037);

  static const Color chipInactive = Color(0xFFF3F4F6);
  static const Color chipInactiveText = Color(0xFF374151);

  static const Color shadow = Color(0x1A000000);
}
