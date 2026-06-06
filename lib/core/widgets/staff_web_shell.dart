import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/language_switcher.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class StaffWebShell extends ConsumerWidget {
  const StaffWebShell({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final location = GoRouterState.of(context).matchedLocation;
    final profileName = ref.watch(authProfileFullNameProvider);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final navItems = [
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

    final sidebar = Container(
      width: 260.w,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: isRtl ? BorderSide.none : const BorderSide(color: AppColors.border),
          left: isRtl ? const BorderSide(color: AppColors.border) : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.mosque_rounded,
                    color: AppColors.onPrimary,
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),
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
                        l10n.staffPortalSubtitle,
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
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              children: navItems
                  .map(
                    (item) => _SidebarTile(
                      item: item,
                      onTap: () => context.go(item.route),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  child: Icon(Icons.person, color: AppColors.primary, size: 20.sp),
                ),
                SizedBox(width: 10.w),
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
                        l10n.staffAdminRole,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed:
                      ref.read(signOutControllerProvider.notifier).signOut,
                  icon: const Icon(Icons.logout_rounded, size: 20),
                  tooltip: l10n.signOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: isRtl
            ? [Expanded(child: child), sidebar]
            : [sidebar, Expanded(child: child)],
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
      padding: EdgeInsets.only(bottom: 4.h),
      child: Material(
        color: item.isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 20.sp,
                  color:
                      item.isActive ? AppColors.onPrimary : AppColors.textSecondary,
                ),
                SizedBox(width: 12.w),
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

/// Top bar for staff web content pages.
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
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 16.h),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 4.h),
                  Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ],
            ),
          ),
          const LanguageSwitcherAppBarAction(),
          ...actions,
        ],
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
    return DecoratedBox(
      decoration: AppDecorations.card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              letterSpacing: 0.5,
                            ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        value,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      if (badge != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          badge!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: accentColor, size: 22.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
