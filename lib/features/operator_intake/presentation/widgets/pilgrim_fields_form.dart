import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/forms/pilgrim_field_catalog.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Renders pilgrim catalog [sections] as grouped reactive form fields.
///
/// Shared by the intake screen and the edit screen so both expose the exact
/// same field set (DRY). Must be placed inside a [ReactiveForm].
class PilgrimFieldsForm extends StatelessWidget {
  const PilgrimFieldsForm({
    this.sections = pilgrimFieldSections,
    this.enabled = true,
    super.key,
  });

  final List<PilgrimFieldSection> sections;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final section in sections) ...[
          StaffFormSection(
            icon: section.icon,
            title: section.title(l10n),
            child: ResponsiveFormGrid(
              maxColumns: 3,
              children: [
                for (final field in section.fields)
                  PilgrimFieldInput(field: field, enabled: enabled),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ],
    );
  }
}

/// A single catalog field rendered as the appropriate reactive control.
class PilgrimFieldInput extends StatelessWidget {
  const PilgrimFieldInput({
    required this.field,
    this.enabled = true,
    super.key,
  });

  final PilgrimField field;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final label = field.label(l10n);
    final prefixIcon = field.icon == null ? null : Icon(field.icon);

    switch (field.kind) {
      case PilgrimFieldKind.gender:
        return ReactiveDropdownField<String>(
          formControlName: field.key,
          decoration: InputDecoration(labelText: label),
          items: [
            DropdownMenuItem(value: '', child: Text(l10n.staffTableFilterAll)),
            DropdownMenuItem(value: 'male', child: Text(l10n.pilgrimGenderMale)),
            DropdownMenuItem(
              value: 'female',
              child: Text(l10n.pilgrimGenderFemale),
            ),
          ],
        );
      case PilgrimFieldKind.boolean:
        return _BoolField(controlName: field.key, label: label, enabled: enabled);
      case PilgrimFieldKind.date:
        return _DateField(controlName: field.key, label: label, enabled: enabled);
      case PilgrimFieldKind.multiline:
        return ReactiveTextField<String>(
          formControlName: field.key,
          maxLines: 3,
          decoration: InputDecoration(labelText: label, prefixIcon: prefixIcon),
        );
      case PilgrimFieldKind.url:
      case PilgrimFieldKind.phone:
      case PilgrimFieldKind.text:
        return ReactiveTextField<String>(
          formControlName: field.key,
          keyboardType: switch (field.kind) {
            PilgrimFieldKind.url => TextInputType.url,
            PilgrimFieldKind.phone => TextInputType.phone,
            _ => TextInputType.text,
          },
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: label, prefixIcon: prefixIcon),
          validationMessages: field.required
              ? {ValidationMessage.required: (_) => l10n.operatorRequired}
              : const {},
        );
    }
  }
}

class _BoolField extends StatelessWidget {
  const _BoolField({
    required this.controlName,
    required this.label,
    required this.enabled,
  });

  final String controlName;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(border: InputBorder.none),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          ReactiveSwitch(formControlName: controlName),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.controlName,
    required this.label,
    required this.enabled,
  });

  final String controlName;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ReactiveValueListenableBuilder<DateTime>(
      formControlName: controlName,
      builder: (context, control, _) {
        final value = control.value;
        return StaffDateFormField(
          label: label,
          value: value,
          unsetLabel: '—',
          enabled: enabled,
          onPick: () async {
            final picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2024),
              lastDate: DateTime(2030),
              initialDate: value ?? DateTime.now(),
            );
            if (picked != null) {
              control.updateValue(picked);
            }
          },
        );
      },
    );
  }
}
