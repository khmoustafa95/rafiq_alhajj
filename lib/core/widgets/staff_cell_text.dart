import 'package:flutter/material.dart';

/// Standardized data-table cell text: single line, ellipsis, and a hover
/// tooltip exposing the full value. Renders a muted placeholder when empty so
/// cramped columns stay scannable.
class StaffCellText extends StatelessWidget {
  const StaffCellText(
    this.value, {
    this.strong = false,
    this.placeholder = '—',
    super.key,
  });

  final String? value;
  final bool strong;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = (value ?? '').trim();
    if (text.isEmpty) {
      return Text(
        placeholder,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    return Tooltip(
      message: text,
      waitDuration: const Duration(milliseconds: 600),
      child: Text(
        text,
        style: strong ? theme.textTheme.titleSmall : theme.textTheme.bodyMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
