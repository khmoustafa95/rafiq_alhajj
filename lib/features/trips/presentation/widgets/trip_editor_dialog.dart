import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip_editor_input.dart';
import 'package:rafiq_alhajj/features/trips/presentation/providers/trips_providers.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/trip_labels.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Shows the create/edit trip dialog. Returns true when a trip was saved.
Future<bool> showTripEditorDialog(BuildContext context, {Trip? trip}) async {
  final saved = await showDialog<bool>(
    context: context,
    builder: (_) => TripEditorDialog(trip: trip),
  );
  return saved ?? false;
}

class TripEditorDialog extends ConsumerStatefulWidget {
  const TripEditorDialog({this.trip, super.key});

  final Trip? trip;

  @override
  ConsumerState<TripEditorDialog> createState() => _TripEditorDialogState();
}

class _TripEditorDialogState extends ConsumerState<TripEditorDialog> {
  late final FormGroup _form;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    final trip = widget.trip;
    _form = FormGroup({
      'name': FormControl<String>(
        value: trip?.name ?? '',
        validators: [Validators.required],
      ),
      'type': FormControl<String>(value: trip?.type ?? 'hajj'),
      'seasonYear': FormControl<int>(
        value: trip?.seasonYear ?? DateTime.now().year,
        validators: [
          Validators.required,
          Validators.min(1900),
          Validators.max(3000),
        ],
      ),
      'status': FormControl<String>(value: trip?.status ?? 'active'),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }
    setState(() => _submitting = true);

    final input = TripEditorInput(
      id: widget.trip?.id,
      type: _form.control('type').value as String,
      seasonYear: _form.control('seasonYear').value as int,
      name: (_form.control('name').value as String).trim(),
      status: _form.control('status').value as String,
    );

    final ok = await ref.read(tripSaveProvider.notifier).save(input);
    if (!mounted) {
      return;
    }
    setState(() => _submitting = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? (widget.trip == null
                  ? l10n.adminTripCreateSuccess
                  : l10n.adminTripSaveSuccess)
              : l10n.adminTripSaveError,
        ),
      ),
    );
    if (ok) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(
        widget.trip == null ? l10n.adminTripNewTitle : l10n.adminTripEditTitle,
      ),
      content: SizedBox(
        width: 420,
        child: ReactiveForm(
          formGroup: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReactiveTextField<String>(
                formControlName: 'name',
                decoration: InputDecoration(labelText: l10n.adminTripName),
                validationMessages: {
                  ValidationMessage.required: (_) => l10n.adminTripNameRequired,
                },
              ),
              const SizedBox(height: 12),
              ReactiveDropdownField<String>(
                formControlName: 'type',
                decoration: InputDecoration(labelText: l10n.adminTripType),
                items: [
                  for (final type in tripTypes)
                    DropdownMenuItem(
                      value: type,
                      child: Text(tripTypeLabel(l10n, type)),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              ReactiveTextField<int>(
                formControlName: 'seasonYear',
                valueAccessor: IntValueAccessor(),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration:
                    InputDecoration(labelText: l10n.adminTripSeasonYear),
                validationMessages: {
                  ValidationMessage.required: (_) =>
                      l10n.adminTripSeasonYearRequired,
                  ValidationMessage.min: (_) =>
                      l10n.adminTripSeasonYearRequired,
                  ValidationMessage.max: (_) =>
                      l10n.adminTripSeasonYearRequired,
                },
              ),
              const SizedBox(height: 12),
              ReactiveDropdownField<String>(
                formControlName: 'status',
                decoration: InputDecoration(labelText: l10n.adminTripStatus),
                items: [
                  // Active / finished plus the current value if it is a legacy
                  // status, so editing an old trip never blanks the field.
                  for (final status in {
                    ...tripEditableStatuses,
                    if (widget.trip != null) widget.trip!.status,
                  })
                    DropdownMenuItem(
                      value: status,
                      child: Text(tripStatusLabel(l10n, status)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(false),
          child: Text(l10n.dialogCancel),
        ),
        FilledButton(
          onPressed: _submitting ? null : _submit,
          child: _submitting
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.adminTripSave),
        ),
      ],
    );
  }
}
