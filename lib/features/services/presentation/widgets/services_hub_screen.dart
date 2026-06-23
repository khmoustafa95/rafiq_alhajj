import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/home_app_header.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class ServicesHubScreen extends StatelessWidget {
  const ServicesHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeAppHeader(title: l10n.navServices, actions: const []),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20.w),
                children: [
                  _ServicesHero(l10n: l10n),
                  SizedBox(height: 20.h),
                  _ServiceTile(
                    icon: Icons.hiking_rounded,
                    color: AppColors.primary,
                    title: l10n.homeMyHajjJourney,
                    subtitle: l10n.servicesJourneySubtitle,
                    onTap: () => unawaited(context.push(AppRoutes.hajjJourney)),
                  ),
                  SizedBox(height: 12.h),
                  _ServiceTile(
                    icon: Icons.emoji_events_outlined,
                    color: AppColors.secondary,
                    title: l10n.homeCompetitions,
                    subtitle: l10n.servicesCompetitionsSubtitle,
                    onTap: () => unawaited(context.push(AppRoutes.competitions)),
                  ),
                  SizedBox(height: 12.h),
                  _ServiceTile(
                    icon: Icons.contact_phone_outlined,
                    color: AppColors.info,
                    title: l10n.supportContactsTitle,
                    subtitle: l10n.servicesContactsSubtitle,
                    onTap: () =>
                        unawaited(context.push(AppRoutes.supportContacts)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServicesHero extends StatelessWidget {
  const _ServicesHero({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.tertiary],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: -8,
            bottom: -16,
            child: Icon(
              Icons.mosque_rounded,
              size: 96.sp,
              color: AppColors.textOnDark.withValues(alpha: 0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  l10n.servicesHeroBadge,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                l10n.servicesHeroTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textOnDark,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              SizedBox(height: 8.h),
              Text(
                l10n.servicesHeroSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMutedOnDark,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
        child: Container(
          decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withValues(alpha: 0.85),
                      color,
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(AppDecorations.radiusMd),
                ),
                child: Icon(icon, color: AppColors.onPrimary, size: 28.sp),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
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
    );
  }
}
