import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';

/// A staff table toolbar action.
///
/// Secondary actions render icon-only with a hover tooltip to save horizontal
/// room (Airtable/Linear-style); the primary action keeps its label so the
/// main task stays discoverable.
class StaffToolbarButton extends StatelessWidget {
  const StaffToolbarButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.primary = false,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    if (primary) {
      return Semantics(
        button: true,
        label: label,
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: ss(18)),
          label: Text(label),
        ),
      );
    }
    return Semantics(
      button: true,
      label: label,
      child: IconButton.outlined(
        onPressed: onPressed,
        tooltip: label,
        icon: Icon(icon, size: ss(20)),
        style: IconButton.styleFrom(
          minimumSize: Size(sw(44), sh(44)),
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
