import 'package:flutter/material.dart';

/// Compact icon buttons for [StaffDataTable] trailing cells.
class StaffTableRowActions extends StatelessWidget {
  const StaffTableRowActions({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  static Widget iconButton({
    required IconData icon,
    required VoidCallback? onPressed,
    String? tooltip,
  }) {
    return Semantics(
      button: true,
      label: tooltip,
      enabled: onPressed != null,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        tooltip: tooltip,
        visualDensity: VisualDensity.compact,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints.tightFor(width: 40, height: 36),
      ),
    );
  }
}
