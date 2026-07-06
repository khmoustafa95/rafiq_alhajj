import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/language_switcher.dart';
import 'package:rafiq_alhajj/core/widgets/theme_switcher.dart';

/// Responsive split-layout shell for staff (operator / admin) web sign-in.
class StaffWebLoginScaffold extends StatelessWidget {
  const StaffWebLoginScaffold({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.form,
    this.footer,
    this.highlights = const [],
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget form;
  final Widget? footer;
  final List<StaffLoginHighlight> highlights;

  static const _wideBreakpoint = 900.0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= _wideBreakpoint;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            if (isWide)
              Row(
                children: [
                  Expanded(
                    flex: 11,
                    child: _HeroPanel(
                      title: title,
                      subtitle: subtitle,
                      icon: icon,
                      highlights: highlights,
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: _FormPanel(
                      title: title,
                      subtitle: subtitle,
                      form: form,
                      footer: footer,
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  _CompactHero(
                    title: title,
                    subtitle: subtitle,
                    icon: icon,
                  ),
                  Expanded(
                    child: _FormPanel(
                      title: title,
                      subtitle: subtitle,
                      form: form,
                      footer: footer,
                      compact: true,
                    ),
                  ),
                ],
              ),
            const Positioned(
              top: 8,
              left: 8,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ThemeSwitcherAppBarAction(compact: true),
                  LanguageSwitcherAppBarAction(compact: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StaffLoginHighlight {
  const StaffLoginHighlight({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.highlights,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<StaffLoginHighlight> highlights;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, size: 40, color: AppColors.onPrimary),
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textMutedOnDark,
                  height: 1.5,
                ),
          ),
          if (highlights.isNotEmpty) ...[
            const Spacer(),
            ...highlights.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Icon(item.icon, color: AppColors.secondary, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.label,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.onPrimary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CompactHero extends StatelessWidget {
  const _CompactHero({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: AppColors.onPrimary),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textMutedOnDark,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FormPanel extends StatelessWidget {
  const _FormPanel({
    required this.title,
    required this.subtitle,
    required this.form,
    this.footer,
    this.compact = false,
  });

  final String title;
  final String subtitle;
  final Widget form;
  final Widget? footer;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 20 : 40,
          vertical: compact ? 20 : 32,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Container(
            decoration: AppDecorations.card(radius: AppDecorations.radiusXl),
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!compact) ...[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 28),
                ],
                form,
                if (footer != null) ...[
                  const SizedBox(height: 20),
                  footer!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
