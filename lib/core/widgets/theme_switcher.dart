import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/theme_mode_controller.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Compact theme control for [AppBar] actions, placed next to the language switcher.
class ThemeSwitcherAppBarAction extends ConsumerWidget {
  const ThemeSwitcherAppBarAction({this.compact = false, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final icon = _iconForThemeMode(themeMode);

    if (compact) {
      return IconButton(
        onPressed: () => showThemePickerSheet(context),
        tooltip: l10n.themeSwitcherTitle,
        icon: Icon(icon, color: colorScheme.onSurfaceVariant),
      );
    }

    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: Center(
        child: Material(
          color: colorScheme.secondaryContainer.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(20.r),
          child: InkWell(
            onTap: () => showThemePickerSheet(context),
            borderRadius: BorderRadius.circular(20.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 16.sp,
                    color: colorScheme.onSecondaryContainer,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    _shortLabel(l10n, themeMode),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

IconData _iconForThemeMode(ThemeMode mode) {
  return switch (mode) {
    ThemeMode.light => Icons.light_mode_rounded,
    ThemeMode.dark => Icons.dark_mode_rounded,
    ThemeMode.system => Icons.brightness_auto_rounded,
  };
}

String _shortLabel(AppLocalizations l10n, ThemeMode mode) {
  return switch (mode) {
    ThemeMode.light => l10n.themeModeLightShort,
    ThemeMode.dark => l10n.themeModeDarkShort,
    ThemeMode.system => l10n.themeModeSystemShort,
  };
}

Future<void> showThemePickerSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheetContext) => const _ThemePickerSheet(),
  );
}

class _ThemePickerSheet extends ConsumerWidget {
  const _ThemePickerSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final selected = ref.watch(themeModeControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.themeSwitcherTitle,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.themeSwitcherSubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            _ThemeOptionTile(
              mode: ThemeMode.system,
              selected: selected,
              title: l10n.themeModeSystem,
              subtitle: l10n.themeModeSystemSubtitle,
              icon: Icons.brightness_auto_rounded,
              onTap: () => _select(context, ref, ThemeMode.system),
            ),
            SizedBox(height: 12.h),
            _ThemeOptionTile(
              mode: ThemeMode.light,
              selected: selected,
              title: l10n.themeModeLight,
              subtitle: l10n.themeModeLightSubtitle,
              icon: Icons.light_mode_rounded,
              onTap: () => _select(context, ref, ThemeMode.light),
            ),
            SizedBox(height: 12.h),
            _ThemeOptionTile(
              mode: ThemeMode.dark,
              selected: selected,
              title: l10n.themeModeDark,
              subtitle: l10n.themeModeDarkSubtitle,
              icon: Icons.dark_mode_rounded,
              onTap: () => _select(context, ref, ThemeMode.dark),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _select(
    BuildContext context,
    WidgetRef ref,
    ThemeMode mode,
  ) async {
    await ref.read(themeModeControllerProvider.notifier).setThemeMode(mode);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}

class _ThemeOptionTile extends StatelessWidget {
  const _ThemeOptionTile({
    required this.mode,
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final ThemeMode mode;
  final ThemeMode selected;
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = selected == mode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primaryContainer.withValues(alpha: 0.55)
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: isSelected
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHigh,
                  child: Icon(
                    icon,
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: isSelected
                      ? Icon(
                          Icons.check_circle_rounded,
                          key: const ValueKey('selected'),
                          color: colorScheme.primary,
                        )
                      : Icon(
                          Icons.circle_outlined,
                          key: const ValueKey('unselected'),
                          color: colorScheme.outline,
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
