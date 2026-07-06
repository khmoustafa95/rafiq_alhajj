import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/providers/admin_analytics_providers.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_dashboard_content.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_bell_button.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminDashboardMobileScaffold extends ConsumerWidget {
  const AdminDashboardMobileScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.adminDashboardTitle),
        actions: [
          const NotificationBellButton(),
          IconButton(
            onPressed: () {
              unawaited(ref.read(adminDashboardProvider.notifier).refresh());
            },
            tooltip: l10n.retry,
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: ref.read(signOutControllerProvider.notifier).signOut,
            tooltip: l10n.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const AdminDashboardContent(),
    );
  }
}
