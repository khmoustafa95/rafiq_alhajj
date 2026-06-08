import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/l10n/locale_controller.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Compact language control for [AppBar] actions.
class LanguageSwitcherAppBarAction extends ConsumerWidget {
  const LanguageSwitcherAppBarAction({this.compact = false, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(localeControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final shortLabel = locale.languageCode == 'ar'
        ? l10n.languageArabicShort
        : l10n.languageEnglishShort;

    if (compact) {
      return IconButton(
        onPressed: () => showLanguagePickerSheet(context),
        tooltip: l10n.languageSwitcherTitle,
        icon: Icon(
          Icons.translate_rounded,
          color: colorScheme.onSurfaceVariant,
        ),
      );
    }

    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: Center(
        child: Material(
          color: colorScheme.primaryContainer.withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(20.r),
          child: InkWell(
            onTap: () => showLanguagePickerSheet(context),
            borderRadius: BorderRadius.circular(20.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.translate_rounded,
                    size: 16.sp,
                    color: colorScheme.onPrimaryContainer,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    shortLabel,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
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

Future<void> showLanguagePickerSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheetContext) => const _LanguagePickerSheet(),
  );
}

class _LanguagePickerSheet extends ConsumerWidget {
  const _LanguagePickerSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final selected = ref.watch(localeControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.languageSwitcherTitle,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.languageSwitcherSubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            _LanguageOptionTile(
              locale: const Locale('ar'),
              selected: selected,
              title: l10n.languageArabic,
              subtitle: l10n.languageArabicSubtitle,
              badge: l10n.languageArabicShort,
              onTap: () => _select(context, ref, const Locale('ar')),
            ),
            SizedBox(height: 12.h),
            _LanguageOptionTile(
              locale: const Locale('en'),
              selected: selected,
              title: l10n.languageEnglish,
              subtitle: l10n.languageEnglishSubtitle,
              badge: l10n.languageEnglishShort,
              onTap: () => _select(context, ref, const Locale('en')),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _select(
    BuildContext context,
    WidgetRef ref,
    Locale locale,
  ) async {
    await ref.read(localeControllerProvider.notifier).setLocale(locale);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.locale,
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.onTap,
  });

  final Locale locale;
  final Locale selected;
  final String title;
  final String subtitle;
  final String badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = selected.languageCode == locale.languageCode;

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
                  child: Text(
                    badge,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                        ),
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
