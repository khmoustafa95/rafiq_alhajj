import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';

/// Material-based card surface for settings/forms with [ListTile] children.
///
/// Prefer this over [DecoratedBox] + [AppDecorations.themedCard] when the card
/// contains [ListTile] / [SwitchListTile] so ink splashes render correctly.
class ThemedSurfaceCard extends StatelessWidget {
  const ThemedSurfaceCard({
    required this.child,
    this.padding,
    this.radius = AppDecorations.radiusLg,
    this.color,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: color ?? scheme.surfaceContainerHigh,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: scheme.outline),
      ),
      child: padding != null
          ? Padding(padding: padding!, child: child)
          : child,
    );
  }
}
