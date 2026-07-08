import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_dashboard_mobile_scaffold.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_dashboard_web_body.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const StaffAdaptivePage(
      web: AdminDashboardWebBody(),
      mobile: AdminDashboardMobileScaffold(),
    );
  }
}
