import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldOperatorStatusFilterChip extends StatelessWidget {
  const FieldOperatorStatusFilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: Semantics(
        button: true,
        selected: selected,
        label: label,
        child: FilterChip(
          label: Text(label),
          selected: selected,
          onSelected: (_) => onSelected(),
          showCheckmark: false,
          selectedColor: colorScheme.primaryContainer,
          checkmarkColor: colorScheme.primary,
          labelStyle: TextStyle(
            color: selected
                ? colorScheme.onPrimaryContainer
                : colorScheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
