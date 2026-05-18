import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Displayed when [GoRouter] cannot match a location.
class RouteNotFoundScreen extends StatelessWidget {
  const RouteNotFoundScreen({
    required this.location,
    super.key,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.routeNotFoundTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.search_off,
              size: 64.sp,
              color: colorScheme.primary,
            ),
            SizedBox(height: 24.h),
            Text(
              l10n.routeNotFoundMessage,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            FilledButton(
              onPressed: () => context.go(AppRoutes.home),
              child: Text(l10n.goHome),
            ),
          ],
        ),
      ),
    );
  }
}
