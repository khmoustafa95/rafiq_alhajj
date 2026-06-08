import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/language_switcher.dart';
import 'package:rafiq_alhajj/core/widgets/staff_button_styles.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_bell_button.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class StaffWebShell extends ConsumerStatefulWidget {
  const StaffWebShell({
    required this.child,
    super.key,
  });

  final Widget child;

  static const compactBreakpoint = 960.0;
  static const sidebarWidth = 260.0;

  @override
  ConsumerState<StaffWebShell> createState() => _StaffWebShellState();
}

class _StaffWebShellState extends ConsumerState<StaffWebShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigate(String route) {
    context.go(route);
    if (MediaQuery.sizeOf(context).width < StaffWebShell.compactBreakpoint) {
      _scaffoldKey.currentState?.closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final location = GoRouterState.of(context).matchedLocation;
    final profileName = ref.watch(authProfileFullNameProvider);
    final accessMode = ref.watch(authAccessModeProvider);
    final isAdmin = accessMode == AppAccessMode.admin;
    final isCompact =
        MediaQuery.sizeOf(context).width < StaffWebShell.compactBreakpoint;

    final navItems = isAdmin
        ? _adminNavItems(l10n, location)
        : _operatorNavItems(l10n, location);

    final sidebar = _StaffSidebar(
      l10n: l10n,
      profileName: profileName,
      isAdmin: isAdmin,
      navItems: navItems,
      onNavigate: _navigate,
      onSignOut: () => ref.read(signOutControllerProvider.notifier).signOut(),
    );

    if (isCompact) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
        drawer: Drawer(
          width: StaffWebShell.sidebarWidth,
          child: sidebar,
        ),
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            _pageTitle(l10n, location, isAdmin),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: const [
            NotificationBellButton(),
            LanguageSwitcherAppBarAction(compact: true),
            SizedBox(width: 8),
          ],
        ),
        body: Material(
          color: AppColors.background,
          child: widget.child,
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          SizedBox(width: StaffWebShell.sidebarWidth, child: sidebar),
          Expanded(
            child: Material(
              color: AppColors.background,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }

  List<_StaffNavItem> _adminNavItems(AppLocalizations l10n, String location) {
    return [
      _StaffNavItem(
        icon: Icons.home_rounded,
        label: l10n.staffNavHome,
        route: AppRoutes.adminDashboard,
        isActive: location == AppRoutes.adminDashboard,
      ),
      _StaffNavItem(
        icon: Icons.people_outline_rounded,
        label: l10n.staffNavPilgrims,
        route: AppRoutes.operatorPilgrims,
        isActive: location.startsWith(AppRoutes.operatorPilgrims),
      ),
      _StaffNavItem(
        icon: Icons.badge_outlined,
        label: l10n.staffNavOperators,
        route: AppRoutes.adminOperators,
        isActive: location.startsWith(AppRoutes.adminOperators),
      ),
      _StaffNavItem(
        icon: Icons.article_outlined,
        label: l10n.staffNavContent,
        route: AppRoutes.adminContent,
        isActive: location.startsWith(AppRoutes.adminContent),
      ),
      _StaffNavItem(
        icon: Icons.emoji_events_outlined,
        label: l10n.staffNavCompetitions,
        route: AppRoutes.adminCompetitions,
        isActive: location.startsWith(AppRoutes.adminCompetitions),
      ),
      _StaffNavItem(
        icon: Icons.campaign_outlined,
        label: l10n.staffNavNotifications,
        route: AppRoutes.adminNotificationSend,
        isActive: location == AppRoutes.adminNotificationSend,
      ),
    ];
  }

  List<_StaffNavItem> _operatorNavItems(AppLocalizations l10n, String location) {
    return [
      _StaffNavItem(
        icon: Icons.person_add_alt_1_outlined,
        label: l10n.staffNavRegister,
        route: AppRoutes.operatorIntake,
        isActive: location == AppRoutes.operatorIntake,
      ),
      _StaffNavItem(
        icon: Icons.people_outline_rounded,
        label: l10n.staffNavPilgrims,
        route: AppRoutes.operatorPilgrims,
        isActive: location.startsWith(AppRoutes.operatorPilgrims),
      ),
    ];
  }

  String _pageTitle(AppLocalizations l10n, String location, bool isAdmin) {
    if (location == AppRoutes.operatorIntake) {
      return l10n.operatorIntakeTitle;
    }
    if (location.startsWith(AppRoutes.operatorPilgrims)) {
      return l10n.operatorPilgrimListTitle;
    }
    if (location.startsWith(AppRoutes.adminOperators)) {
      return l10n.adminOperatorsTitle;
    }
    if (location == AppRoutes.adminDashboard) {
      return l10n.adminDashboardTitle;
    }
    if (location.startsWith(AppRoutes.adminContent)) {
      return l10n.adminContentListTitle;
    }
    if (location.startsWith(AppRoutes.adminCompetitions)) {
      return l10n.adminCompetitionsTitle;
    }
    if (location == AppRoutes.adminNotificationSend) {
      return l10n.adminNotificationSendTitle;
    }
    return isAdmin ? l10n.staffPortalSubtitle : l10n.staffOperatorPortalSubtitle;
  }
}

class _StaffSidebar extends StatelessWidget {
  const _StaffSidebar({
    required this.l10n,
    required this.profileName,
    required this.isAdmin,
    required this.navItems,
    required this.onNavigate,
    required this.onSignOut,
  });

  final AppLocalizations l10n;
  final String? profileName;
  final bool isAdmin;
  final List<_StaffNavItem> navItems;
  final ValueChanged<String> onNavigate;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.mosque_rounded,
                    color: AppColors.onPrimary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.appTitle,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Text(
                        isAdmin
                            ? l10n.staffPortalSubtitle
                            : l10n.staffOperatorPortalSubtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: navItems
                  .map(
                    (item) => _SidebarTile(
                      item: item,
                      onTap: () => onNavigate(item.route),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  child: const Icon(Icons.person, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileName ?? l10n.staffDefaultUser,
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        isAdmin ? l10n.staffAdminRole : l10n.staffOperatorRole,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onSignOut,
                  icon: const Icon(Icons.logout_rounded, size: 20),
                  tooltip: l10n.signOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StaffNavItem {
  const _StaffNavItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.isActive,
  });

  final IconData icon;
  final String label;
  final String route;
  final bool isActive;
}

class _SidebarTile extends StatelessWidget {
  const _SidebarTile({
    required this.item,
    required this.onTap,
  });

  final _StaffNavItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: item.isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 20,
                  color: item.isActive
                      ? AppColors.onPrimary
                      : AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: item.isActive
                              ? AppColors.onPrimary
                              : AppColors.textPrimary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Top bar for staff web content pages (wide layout).
class StaffWebHeader extends StatelessWidget {
  const StaffWebHeader({
    required this.title,
    this.subtitle,
    this.actions = const [],
    super.key,
  });

  final String title;
  final String? subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final isCompact =
        MediaQuery.sizeOf(context).width < StaffWebShell.compactBreakpoint;

    if (isCompact) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.fromLTRB(sw(24), sh(20), sw(24), sh(16)),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          filledButtonTheme: FilledButtonThemeData(
            style: staffRowFilledButtonStyle(context),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: staffRowOutlinedButtonStyle(context),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: sh(4)),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: sw(8)),
            Flexible(
              child: Wrap(
                spacing: sw(8),
                runSpacing: sh(8),
                children: [
                  const NotificationBellButton(),
                  const LanguageSwitcherAppBarAction(compact: true),
                  ...actions,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// KPI stat card for admin dashboards.
class StaffStatCard extends StatelessWidget {
  const StaffStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.accentColor,
    this.badge,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color accentColor;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final labelStyle = locale.languageCode == 'ar'
        ? Theme.of(context).textTheme.labelMedium
        : Theme.of(context).textTheme.labelSmall?.copyWith(
              letterSpacing: 0.5,
            );

    return DecoratedBox(
      decoration: AppDecorations.card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppDecorations.radiusMd),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(sw(16)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.languageCode == 'ar' ? label : label.toUpperCase(),
                        style: labelStyle?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: sh(8)),
                      Text(
                        value,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.1,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (badge != null) ...[
                        SizedBox(height: sh(6)),
                        Text(
                          badge!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: sw(12)),
                Container(
                  width: sw(44),
                  height: sw(44),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(sr(10)),
                  ),
                  child: Icon(icon, color: accentColor, size: ss(22)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
