import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/home_app_header.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isPilgrim =
        ref.watch(authAccessModeProvider) == AppAccessMode.pilgrim;
    final pilgrimName = ref.watch(authProfileFullNameProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeAppHeader(
              title: l10n.navProfile,
              actions: const [],
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20.w),
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 44.r,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                      child: Icon(
                        Icons.person,
                        size: 44.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  if (isPilgrim && pilgrimName != null)
                    Text(
                      pilgrimName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  else
                    Text(
                      l10n.profileGuestTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  SizedBox(height: 8.h),
                  Text(
                    isPilgrim ? l10n.homePilgrimWelcome : l10n.profileGuestBody,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 24.h),
                  if (isPilgrim) ...[
                    _ProfileTile(
                      icon: Icons.hiking_rounded,
                      label: l10n.homeMyHajjJourney,
                      onTap: () =>
                          unawaited(context.push(AppRoutes.pilgrimDashboard)),
                    ),
                    _ProfileTile(
                      icon: Icons.emoji_events_outlined,
                      label: l10n.homeCompetitions,
                      onTap: () =>
                          unawaited(context.push(AppRoutes.competitions)),
                    ),
                    _ProfileTile(
                      icon: Icons.logout_rounded,
                      label: l10n.signOut,
                      onTap: ref.read(signOutControllerProvider.notifier).signOut,
                      isDestructive: true,
                    ),
                  ] else ...[
                    FilledButton(
                      onPressed: () => unawaited(context.push(AppRoutes.login)),
                      child: Text(l10n.homeSignInAsPilgrim),
                    ),
                    SizedBox(height: 12.h),
                    OutlinedButton(
                      onPressed: () => unawaited(context.push(AppRoutes.login)),
                      child: Text(l10n.loginTitle),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isDestructive ? AppColors.error : AppColors.primary,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: isDestructive ? AppColors.error : null,
                        ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
