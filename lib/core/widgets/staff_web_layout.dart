import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/staff_back_fallback.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_button_styles.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_shell.dart';
import 'package:rafiq_alhajj/core/widgets/themed_surface_card.dart';

/// Standard staff web page: header + scrollable content with max width.
class StaffWebPage extends StatelessWidget {
  const StaffWebPage({
    required this.title,
    required this.body,
    this.subtitle,
    this.actions = const [],
    this.bottomBar,
    this.top,
    this.scrollable = true,
    this.backFallbackRoute,
    super.key,
  });

  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final Widget body;
  final Widget? bottomBar;
  final Widget? top;
  final bool scrollable;

  /// When set (or auto-detected from the current route), shows a back button in
  /// the web page header for staff sub-routes opened via [GoRouter.go].
  final String? backFallbackRoute;

  static const maxContentWidth = 1120.0;

  @override
  Widget build(BuildContext context) {
    if (!AppPlatform.isWeb) {
      return body;
    }

    final scheme = Theme.of(context).colorScheme;
    final resolvedBackRoute = backFallbackRoute ??
        staffBackFallbackRoute(GoRouterState.of(context).matchedLocation);

    return SizedBox.expand(
      child: ColoredBox(
        color: scheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StaffWebHeader(
              title: title,
              subtitle: subtitle,
              actions: actions,
              backFallbackRoute: resolvedBackRoute,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final contentWidth = constraints.maxWidth > maxContentWidth
                      ? maxContentWidth
                      : constraints.maxWidth;

                  return Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: contentWidth,
                      height: constraints.maxHeight,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          sw(24),
                          sh(24),
                          sw(24),
                          sh(32),
                        ),
                        child: _buildContentArea(),
                      ),
                    ),
                  );
                },
              ),
            ),
            ?bottomBar,
          ],
        ),
      ),
    );
  }

  Widget _buildContentArea() {
    if (scrollable) {
      return SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: body,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (top != null) ...[
          top!,
          SizedBox(height: sh(16)),
        ],
        Expanded(child: body),
      ],
    );
  }
}

/// Grouped form block with icon header inside a card.
class StaffFormSection extends StatelessWidget {
  const StaffFormSection({
    required this.title,
    required this.child,
    this.subtitle,
    this.icon,
    this.trailing,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ThemedSurfaceCard(
      padding: EdgeInsets.all(sw(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Container(
                  padding: EdgeInsets.all(sw(10)),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: ss(22)),
                ),
                SizedBox(width: sw(14)),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: sh(4)),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              height: 1.4,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null)
                Theme(
                  data: Theme.of(context).copyWith(
                    outlinedButtonTheme: OutlinedButtonThemeData(
                      style: staffRowOutlinedButtonStyle(context),
                    ),
                    filledButtonTheme: FilledButtonThemeData(
                      style: staffRowFilledButtonStyle(context),
                    ),
                  ),
                  child: trailing!,
                ),
            ],
          ),
          SizedBox(height: sh(20)),
          child,
        ],
      ),
    );
  }
}

/// Responsive grid for form fields: 1 / 2 / 3 columns by width.
class ResponsiveFormGrid extends StatelessWidget {
  const ResponsiveFormGrid({
    required this.children,
    this.maxColumns = 2,
    this.spacing = 16,
    super.key,
  });

  final List<Widget> children;
  final int maxColumns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (!constraints.hasBoundedWidth) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _withSpacing(children, spacing, vertical: true),
          );
        }

        final columns = width >= 900
            ? maxColumns.clamp(1, 3)
            : width >= 520
                ? 2
                : 1;

        if (columns == 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _withSpacing(children, spacing, vertical: true),
          );
        }

        final itemWidth = (width - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children
              .map((child) => SizedBox(width: itemWidth, child: child))
              .toList(),
        );
      },
    );
  }

  List<Widget> _withSpacing(
    List<Widget> items,
    double gap, {
    required bool vertical,
  }) {
    final result = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      result.add(items[i]);
      if (i < items.length - 1) {
        result.add(vertical ? SizedBox(height: gap) : SizedBox(width: gap));
      }
    }
    return result;
  }
}

/// Compact left-aligned form action buttons (shared by web + mobile footers).
class StaffFormActionButtons extends StatelessWidget {
  const StaffFormActionButtons({
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.isLoading = false,
    super.key,
  });

  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          onPressed: isLoading ? null : onPrimary,
          style: staffFormActionFilledButtonStyle(context),
          child: isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : Text(primaryLabel),
        ),
        if (secondaryLabel != null && onSecondary != null) ...[
          SizedBox(width: sw(12)),
          OutlinedButton(
            onPressed: isLoading ? null : onSecondary,
            style: staffFormActionOutlinedButtonStyle(context),
            child: Text(secondaryLabel!),
          ),
        ],
      ],
    );
  }
}

/// Sticky footer bar for primary form actions on web.
class StaffFormActionsBar extends StatelessWidget {
  const StaffFormActionsBar({
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.isLoading = false,
    super.key,
  });

  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        border: Border(top: BorderSide(color: scheme.outline)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw(24), vertical: sh(12)),
          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: StaffWebPage.maxContentWidth),
              child: Align(
                alignment: Alignment.centerLeft,
                child: StaffFormActionButtons(
                  primaryLabel: primaryLabel,
                  onPrimary: onPrimary,
                  secondaryLabel: secondaryLabel,
                  onSecondary: onSecondary,
                  isLoading: isLoading,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Mobile scaffold footer matching [StaffFormActionsBar] alignment.
class StaffFormMobileActionsBar extends StatelessWidget {
  const StaffFormMobileActionsBar({
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.isLoading = false,
    super.key,
  });

  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sw(16), vertical: sh(12)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: StaffFormActionButtons(
            primaryLabel: primaryLabel,
            onPrimary: onPrimary,
            secondaryLabel: secondaryLabel,
            onSecondary: onSecondary,
            isLoading: isLoading,
          ),
        ),
      ),
    );
  }
}

/// Consistent date picker field for staff forms.
class StaffDateFormField extends StatelessWidget {
  const StaffDateFormField({
    required this.label,
    required this.value,
    required this.onPick,
    this.unsetLabel,
    this.enabled = true,
    super.key,
  });

  final String label;
  final DateTime? value;
  final String? unsetLabel;
  final VoidCallback? onPick;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10nUnset = unsetLabel ?? '—';
    final display = value == null
        ? l10nUnset
        : MaterialLocalizations.of(context).formatMediumDate(value!);
    final scheme = Theme.of(context).colorScheme;

    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today_outlined),
          onPressed: enabled ? onPick : null,
        ),
      ),
      child: InkWell(
        onTap: enabled ? onPick : null,
        child: Text(
          display,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: value == null ? scheme.onSurfaceVariant : null,
              ),
        ),
      ),
    );
  }
}

/// Empty state for staff list pages.
class StaffEmptyState extends StatelessWidget {
  const StaffEmptyState({
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sw(24), vertical: sh(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: ss(40), color: scheme.onSurfaceVariant),
            SizedBox(height: sh(12)),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: sh(16)),
              FilledButton.tonal(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

/// Wraps content for web staff pages; on mobile returns [mobile] scaffold.
class StaffAdaptivePage extends StatelessWidget {
  const StaffAdaptivePage({
    required this.web,
    required this.mobile,
    super.key,
  });

  final Widget web;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return AppPlatform.isWeb ? web : mobile;
  }
}
