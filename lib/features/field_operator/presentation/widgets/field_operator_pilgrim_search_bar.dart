import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class FieldOperatorPilgrimSearchBar extends StatelessWidget {
  const FieldOperatorPilgrimSearchBar({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      child: Semantics(
        textField: true,
        label: l10n.fieldOperatorSearchHintExtended,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: l10n.fieldOperatorSearchHintExtended,
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
