import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/language_switcher.dart';
import 'package:rafiq_alhajj/core/widgets/staff_button_styles.dart';
import 'package:rafiq_alhajj/core/widgets/staff_connectivity_banner.dart';
import 'package:rafiq_alhajj/core/widgets/staff_sidebar_provider.dart';
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
  static const collapsedSidebarWidth = 76.0;

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
    final isAdmin = ref.watch(
      authAccessModeProvider.select((mode) => mode == AppAccessMode.admin),
    );
    final isCompact =
        MediaQuery.sizeOf(context).width < StaffWebShell.compactBreakpoint;
    final scheme = Theme.of(context).colorScheme;
    // Collapsing only applies to the wide (persistent) sidebar; the compact
    // drawer always shows full-width labels.
    final collapsed =
        !isCompact && ref.watch(staffSidebarCollapsedProvider);

    final navItems = isAdmin
        ? _adminNavItems(l10n, location)
        : _operatorNavItems(l10n, location);

    final sidebar = _StaffSidebar(
      l10n: l10n,
      profileName: profileName,
      isAdmin: isAdmin,
      navItems: navItems,
      collapsed: collapsed,
      // Collapsing is a wide-layout affordance only; hide the toggle in the
      // compact drawer where the sidebar is always full-width.
      canCollapse: !isCompact,
      onNavigate: _navigate,
      onSignOut: () => ref.read(signOutControllerProvider.notifier).signOut(),
      onToggleCollapse: () =>
          ref.read(staffSidebarCollapsedProvider.notifier).toggle(),
    );

    final pageBody = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const StaffConnectivityBanner(),
        Expanded(child: widget.child),
      ],
    );

    if (isCompact) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: scheme.surface,
        drawer: Drawer(
          width: StaffWebShell.sidebarWidth,
          child: sidebar,
        ),
        appBar: AppBar(
          backgroundColor: scheme.surfaceContainerHigh,
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
          color: scheme.surface,
          child: pageBody,
        ),
      );
    }

    return Scaffold(
      backgroundColor: scheme.surface,
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: collapsed
                ? StaffWebShell.collapsedSidebarWidth
                : StaffWebShell.sidebarWidth,
            // Force the sidebar to its target width and clip the overflow so its
            // contents lay out at the final width (no squeezing) and are simply
            // revealed/hidden as the container animates — avoids transient
            // RenderFlex overflow on the nav tiles mid-animation.
            child: ClipRect(
              child: OverflowBox(
                alignment: AlignmentDirectional.topStart,
                minWidth: collapsed
                    ? StaffWebShell.collapsedSidebarWidth
                    : StaffWebShell.sidebarWidth,
                maxWidth: collapsed
                    ? StaffWebShell.collapsedSidebarWidth
                    : StaffWebShell.sidebarWidth,
                child: sidebar,
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: scheme.surface,
              child: pageBody,
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
        icon: Icons.groups_outlined,
        label: l10n.staffNavGroups,
        route: AppRoutes.adminGroups,
        isActive: location.startsWith(AppRoutes.adminGroups),
      ),
      _StaffNavItem(
        icon: Icons.flight_takeoff_outlined,
        label: l10n.staffNavTrips,
        route: AppRoutes.adminTrips,
        isActive: location.startsWith(AppRoutes.adminTrips),
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
        isActive: location == AppRoutes.adminNotificationSend ||
            location == AppRoutes.adminPushFailures,
      ),
      _StaffNavItem(
        icon: Icons.contact_phone_outlined,
        label: l10n.staffNavContacts,
        route: AppRoutes.adminSupportContacts,
        isActive: location.startsWith(AppRoutes.adminSupportContacts),
      ),
      _StaffNavItem(
        icon: Icons.sos_rounded,
        label: l10n.staffNavSos,
        route: AppRoutes.adminSos,
        isActive: location.startsWith(AppRoutes.adminSos),
      ),
      _StaffNavItem(
        icon: Icons.settings_outlined,
        label: l10n.staffNavSettings,
        route: AppRoutes.adminSettings,
        isActive: location.startsWith(AppRoutes.adminSettings),
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
    if (location.startsWith(AppRoutes.adminGroups)) {
      return l10n.adminGroupsTitle;
    }
    if (location.startsWith(AppRoutes.adminTrips)) {
      return l10n.adminTripsTitle;
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
    if (location.startsWith(AppRoutes.adminSettings)) {
      return l10n.adminSettingsTitle;
    }
    if (location.startsWith(AppRoutes.adminSupportContacts)) {
      return l10n.adminSupportContactsTitle;
    }
    if (location.startsWith(AppRoutes.adminSos)) {
      return l10n.sosMonitorTitle;
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
    required this.collapsed,
    required this.canCollapse,
    required this.onNavigate,
    required this.onSignOut,
    required this.onToggleCollapse,
  });

  final AppLocalizations l10n;
  final String? profileName;
  final bool isAdmin;
  final List<_StaffNavItem> navItems;
  final bool collapsed;
  final bool canCollapse;
  final ValueChanged<String> onNavigate;
  final VoidCallback onSignOut;
  final VoidCallback onToggleCollapse;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: scheme.surfaceContainerHigh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(context),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: collapsed ? 8 : 12,
                vertical: 8,
              ),
              children: navItems
                  .map(
                    (item) => _SidebarTile(
                      item: item,
                      collapsed: collapsed,
                      onTap: () => onNavigate(item.route),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Divider(height: 1),
          _footer(context),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    final logo = Container(
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
    );

    if (collapsed) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            logo,
            const SizedBox(height: 12),
            IconButton(
              onPressed: onToggleCollapse,
              icon: const Icon(Icons.menu_open_rounded),
              tooltip: l10n.staffSidebarExpand,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 8, 16),
      child: Row(
        children: [
          logo,
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (canCollapse)
            IconButton(
              onPressed: onToggleCollapse,
              icon: const Icon(Icons.menu_open_rounded),
              tooltip: l10n.staffSidebarCollapse,
            ),
        ],
      ),
    );
  }

  Widget _footer(BuildContext context) {
    final avatar = CircleAvatar(
      radius: 20,
      backgroundColor: AppColors.primary.withValues(alpha: 0.12),
      child: const Icon(Icons.person, color: AppColors.primary, size: 20),
    );

    if (collapsed) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          children: [
            Tooltip(
              message: profileName ?? l10n.staffDefaultUser,
              child: avatar,
            ),
            const SizedBox(height: 8),
            IconButton(
              onPressed: onSignOut,
              icon: const Icon(Icons.logout_rounded, size: 20),
              tooltip: l10n.signOut,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          avatar,
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
    required this.collapsed,
    required this.onTap,
  });

  final _StaffNavItem item;
  final bool collapsed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final iconColor =
        item.isActive ? AppColors.onPrimary : scheme.onSurfaceVariant;
    final icon = Icon(item.icon, size: 20, color: iconColor);

    final content = collapsed
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(child: icon),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: item.isActive
                              ? AppColors.onPrimary
                              : scheme.onSurface,
                        ),
                  ),
                ),
              ],
            ),
          );

    Widget tappable = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: content,
    );
    if (collapsed) {
      tappable = Tooltip(
        message: item.label,
        waitDuration: const Duration(milliseconds: 300),
        child: tappable,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: item.isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: tappable,
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

    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(sw(24), sh(20), sw(24), sh(16)),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        border: Border(bottom: BorderSide(color: scheme.outline)),
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
                            color: scheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const NotificationBellButton(),
                SizedBox(width: sw(8)),
                const LanguageSwitcherAppBarAction(compact: true),
                ...actions.expand(
                  (action) => [SizedBox(width: sw(8)), action],
                ),
              ],
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
    this.onTap,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color accentColor;
  final String? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final labelStyle = locale.languageCode == 'ar'
        ? Theme.of(context).textTheme.labelMedium
        : Theme.of(context).textTheme.labelSmall?.copyWith(
              letterSpacing: 0.5,
            );

    final card = DecoratedBox(
      decoration: AppDecorations.themedCard(context),
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
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
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

    if (onTap == null) {
      return card;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: card,
      ),
    );
  }
}
