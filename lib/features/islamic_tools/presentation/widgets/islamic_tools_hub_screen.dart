import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class IslamicToolsHubScreen extends StatelessWidget {
  const IslamicToolsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    final tiles = [
      _ToolTile(
        icon: Icons.schedule,
        title: l10n.toolsPrayerTimesTitle,
        subtitle: l10n.toolsPrayerTimesSubtitle,
        route: AppRoutes.prayerTimes,
      ),
      _ToolTile(
        icon: Icons.explore_outlined,
        title: l10n.toolsQiblaTitle,
        subtitle: l10n.toolsQiblaSubtitle,
        route: AppRoutes.qibla,
      ),
      _ToolTile(
        icon: Icons.menu_book_outlined,
        title: l10n.toolsQuranTitle,
        subtitle: l10n.toolsQuranSubtitle,
        route: AppRoutes.quran,
      ),
      _ToolTile(
        icon: Icons.favorite_outline,
        title: l10n.toolsAdhkarTitle,
        subtitle: l10n.toolsAdhkarSubtitle,
        route: AppRoutes.adhkar,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.toolsHubTitle),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: tiles.length,
        separatorBuilder: (_, _) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final tile = tiles[index];
          return Card(
            child: ListTile(
              leading: Icon(tile.icon, color: colorScheme.primary, size: 32.sp),
              title: Text(tile.title),
              subtitle: Text(tile.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => unawaited(context.push(tile.route)),
            ),
          );
        },
      ),
    );
  }
}

class _ToolTile {
  const _ToolTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String route;
}
