import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class IslamicToolEntry {
  const IslamicToolEntry({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String route;
  final Color color;
}

List<IslamicToolEntry> islamicToolsCatalog(AppLocalizations l10n) => [
      IslamicToolEntry(
        icon: Icons.schedule_rounded,
        title: l10n.toolsPrayerTimesTitle,
        subtitle: l10n.toolsPrayerTimesSubtitle,
        route: AppRoutes.prayerTimes,
        color: AppColors.primary,
      ),
      IslamicToolEntry(
        icon: Icons.explore_rounded,
        title: l10n.toolsQiblaTitle,
        subtitle: l10n.toolsQiblaSubtitle,
        route: AppRoutes.qibla,
        color: AppColors.secondary,
      ),
      IslamicToolEntry(
        icon: Icons.view_in_ar_rounded,
        title: l10n.toolsVirtualTourTitle,
        subtitle: l10n.toolsVirtualTourSubtitle,
        route: AppRoutes.virtualTour,
        color: AppColors.accentPurple,
      ),
      IslamicToolEntry(
        icon: Icons.menu_book_rounded,
        title: l10n.toolsQuranTitle,
        subtitle: l10n.toolsQuranSubtitle,
        route: AppRoutes.quran,
        color: AppColors.tertiary,
      ),
      IslamicToolEntry(
        icon: Icons.favorite_rounded,
        title: l10n.toolsAdhkarTitle,
        subtitle: l10n.toolsAdhkarSubtitle,
        route: AppRoutes.adhkar,
        color: AppColors.accentTeal,
      ),
    ];
