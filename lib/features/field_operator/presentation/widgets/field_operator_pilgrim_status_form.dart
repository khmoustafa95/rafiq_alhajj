import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FieldOperatorPilgrimStatusForm extends StatelessWidget {
  const FieldOperatorPilgrimStatusForm({
    required this.form,
    required this.fieldStatus,
    required this.isSaving,
    required this.onFieldStatusChanged,
    required this.onSave,
    required this.onCancel,
    required this.onShare,
    super.key,
  });

  final FormGroup form;
  final String? fieldStatus;
  final bool isSaving;
  final ValueChanged<String?> onFieldStatusChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.fieldOperatorStatusSection,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8.h),
            RadioGroup<String>(
              groupValue: fieldStatus,
              onChanged: (value) {
                if (isSaving) {
                  return;
                }
                onFieldStatusChanged(value);
              },
              child: Column(
                children: [
                  for (final status in FieldPilgrimStatus.values)
                    RadioListTile<String>(
                      title: Text(fieldStatusLabel(l10n, status)),
                      value: status,
                      enabled: !isSaving,
                    ),
                ],
              ),
            ),
            ReactiveForm(
              formGroup: form,
              child: ReactiveTextField<String>(
                formControlName: 'medical',
                decoration: InputDecoration(
                  labelText: l10n.fieldOperatorMedicalLabel,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Semantics(
              button: true,
              label: l10n.fieldOperatorSave,
              enabled: !isSaving,
              child: FilledButton(
                onPressed: isSaving ? null : onSave,
                child: isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.fieldOperatorSave),
              ),
            ),
            SizedBox(height: 8.h),
            Semantics(
              button: true,
              label: l10n.dialogCancel,
              enabled: !isSaving,
              child: OutlinedButton(
                onPressed: isSaving ? null : onCancel,
                child: Text(l10n.dialogCancel),
              ),
            ),
            SizedBox(height: 8.h),
            Semantics(
              button: true,
              label: l10n.fieldOperatorShare,
              enabled: !isSaving,
              child: OutlinedButton.icon(
                onPressed: isSaving ? null : onShare,
                icon: const Icon(Icons.copy_outlined),
                label: Text(l10n.fieldOperatorShare),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
