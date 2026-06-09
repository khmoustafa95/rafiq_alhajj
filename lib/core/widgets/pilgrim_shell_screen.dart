import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';

/// Mobile shell with animated bottom bar and a center-docked home FAB.
class PilgrimShellScreen extends StatelessWidget {
  const PilgrimShellScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const int homeBranchIndex = 2;

  static const List<IconData> _barIcons = [
    Icons.menu_book_rounded,
    Icons.mosque_rounded,
    Icons.notifications_outlined,
    Icons.person_outline_rounded,
  ];

  void _onBranchTap(int branchIndex) {
    navigationShell.goBranch(
      branchIndex,
      initialLocation: branchIndex == navigationShell.currentIndex,
    );
  }

  int _barIndexForBranch(int branchIndex) {
    return switch (branchIndex) {
      0 => 0,
      1 => 1,
      3 => 2,
      4 => 3,
      _ => 0,
    };
  }

  int _branchForBarIndex(int barIndex) {
    return switch (barIndex) {
      0 => 0,
      1 => 1,
      2 => 3,
      3 => 4,
      _ => 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    final branchIndex = navigationShell.currentIndex;
    final isHome = branchIndex == homeBranchIndex;
    final barIndex = _barIndexForBranch(branchIndex);

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onBranchTap(homeBranchIndex),
        backgroundColor: isHome ? AppColors.secondary : AppColors.primary,
        foregroundColor: isHome ? AppColors.onSecondary : AppColors.onPrimary,
        elevation: isHome ? 10 : 6,
        shape: const CircleBorder(),
        child: Icon(Icons.home_rounded, size: isHome ? 34 : 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _barIcons.length,
        tabBuilder: (int index, bool isActive) {
          final actuallyActive = !isHome && isActive;
          return Icon(
            _barIcons[index],
            size: 26,
            color: actuallyActive ? AppColors.primary : AppColors.textSecondary,
          );
        },
        activeIndex: isHome ? 0 : barIndex,
        splashColor: AppColors.primary.withValues(alpha: 0.15),
        splashSpeedInMilliseconds: 280,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 28,
        rightCornerRadius: 28,
        backgroundColor: AppColors.surface,
        shadow: const BoxShadow(
          color: AppColors.shadow,
          blurRadius: 16,
          offset: Offset(0, -4),
        ),
        height: 68,
        onTap: (index) => _onBranchTap(_branchForBarIndex(index)),
      ),
    );
  }
}

int pilgrimShellBranchIndex(String location) {
  if (location.startsWith(AppRoutes.tools)) {
    return 0;
  }
  if (location == AppRoutes.services) {
    return 1;
  }
  if (location == AppRoutes.notifications) {
    return 3;
  }
  if (location == AppRoutes.profile) {
    return 4;
  }
  if (location == AppRoutes.home) {
    return PilgrimShellScreen.homeBranchIndex;
  }
  return PilgrimShellScreen.homeBranchIndex;
}
