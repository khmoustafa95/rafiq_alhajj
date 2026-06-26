import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/forms/pilgrim_field_catalog.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Multi-field bulk editor: pick any catalog fields, enter new values, and
/// apply them to every selected pilgrim at once (with an opt-out notify
/// toggle). Only enabled fields are sent, so untouched fields are preserved.
class PilgrimBulkEditDialog extends ConsumerStatefulWidget {
  const PilgrimBulkEditDialog({required this.pilgrimIds, super.key});

  final List<String> pilgrimIds;

  static Future<void> show(
    BuildContext context,
    List<String> pilgrimIds,
  ) {
    return showDialog<void>(
      context: context,
      builder: (_) => PilgrimBulkEditDialog(pilgrimIds: pilgrimIds),
    );
  }

  @override
  ConsumerState<PilgrimBulkEditDialog> createState() =>
      _PilgrimBulkEditDialogState();
}

class _PilgrimBulkEditDialogState extends ConsumerState<PilgrimBulkEditDialog> {
  final Map<String, _FieldEntry> _entries = {};
  bool _notify = true;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    for (final field in pilgrimFields) {
      _entries[field.key] = _FieldEntry(
        text: field.kind == PilgrimFieldKind.boolean ||
                field.kind == PilgrimFieldKind.date
            ? null
            : TextEditingController(),
      );
    }
  }

  @override
  void dispose() {
    for (final entry in _entries.values) {
      entry.text?.dispose();
    }
    super.dispose();
  }

  int get _enabledCount =>
      _entries.values.where((entry) => entry.enabled).length;

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final person = <String, dynamic>{};
    final enrollment = <String, dynamic>{};
    for (final field in pilgrimFields) {
      final entry = _entries[field.key]!;
      if (!entry.enabled) {
        continue;
      }
      final value = entry.valueFor(field.kind);
      if (field.table == PilgrimFieldTable.person) {
        person[field.key] = value;
      } else {
        enrollment[field.key] = value;
      }
    }

    if (person.isEmpty && enrollment.isEmpty) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.bulkEditNoFields)));
      return;
    }

    setState(() => _submitting = true);
    final ok = await ref.read(pilgrimBulkEditProvider.notifier).apply(
          pilgrimIds: widget.pilgrimIds,
          person: person,
          enrollment: enrollment,
          notify: _notify,
        );
    if (!mounted) {
      return;
    }
    setState(() => _submitting = false);

    if (ok) {
      Navigator.of(context).pop();
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.bulkEditSuccess(widget.pilgrimIds.length))),
      );
    } else {
      messenger.showSnackBar(SnackBar(content: Text(l10n.bulkEditError)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 720),
        child: Padding(
          padding: EdgeInsets.all(sw(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.bulkEditTitle(widget.pilgrimIds.length),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: sh(4)),
              Text(
                l10n.bulkEditDescription,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              SizedBox(height: sh(16)),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final section in pilgrimFieldSections)
                        _SectionBlock(
                          section: section,
                          entries: _entries,
                          enabled: !_submitting,
                          onChanged: () => setState(() {}),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: sh(12)),
              SwitchListTile(
                value: _notify,
                onChanged: _submitting
                    ? null
                    : (value) => setState(() => _notify = value),
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.bulkEditNotify),
                subtitle: Text(l10n.bulkEditNotifyHint),
              ),
              SizedBox(height: sh(8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _submitting
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(l10n.dialogCancel),
                  ),
                  SizedBox(width: sw(8)),
                  FilledButton(
                    onPressed: _submitting || _enabledCount == 0
                        ? null
                        : () => unawaited(_submit()),
                    child: _submitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.bulkEditApply(widget.pilgrimIds.length)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({
    required this.section,
    required this.entries,
    required this.enabled,
    required this.onChanged,
  });

  final PilgrimFieldSection section;
  final Map<String, _FieldEntry> entries;
  final bool enabled;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: sh(8)),
          child: Row(
            children: [
              Icon(section.icon, size: ss(18), color: AppColors.primary),
              SizedBox(width: sw(8)),
              Text(
                section.title(l10n),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
        for (final field in section.fields)
          _FieldRow(
            field: field,
            entry: entries[field.key]!,
            enabled: enabled,
            onChanged: onChanged,
          ),
        const Divider(height: 1, color: AppColors.border),
      ],
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.field,
    required this.entry,
    required this.enabled,
    required this.onChanged,
  });

  final PilgrimField field;
  final _FieldEntry entry;
  final bool enabled;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final label = field.label(l10n);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: sh(6)),
      child: Row(
        children: [
          Checkbox(
            value: entry.enabled,
            onChanged: enabled
                ? (value) {
                    entry.enabled = value ?? false;
                    onChanged();
                  }
                : null,
            visualDensity: VisualDensity.compact,
          ),
          SizedBox(width: sw(4)),
          Expanded(
            child: _input(context, l10n, label),
          ),
        ],
      ),
    );
  }

  Widget _input(BuildContext context, AppLocalizations l10n, String label) {
    final active = enabled && entry.enabled;
    switch (field.kind) {
      case PilgrimFieldKind.boolean:
        return Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: active ? null : AppColors.textSecondary,
                    ),
              ),
            ),
            Switch(
              value: entry.boolValue,
              onChanged: active
                  ? (value) {
                      entry.boolValue = value;
                      onChanged();
                    }
                  : null,
            ),
          ],
        );
      case PilgrimFieldKind.date:
        return StaffDateFormField(
          label: label,
          value: entry.dateValue,
          enabled: active,
          onPick: () async {
            final picked = await showDatePicker(
              context: context,
              firstDate: DateTime(2024),
              lastDate: DateTime(2030),
              initialDate: entry.dateValue ?? DateTime.now(),
            );
            if (picked != null) {
              entry.dateValue = picked;
              onChanged();
            }
          },
        );
      case PilgrimFieldKind.gender:
        return DropdownButtonFormField<String>(
          initialValue: entry.genderValue,
          decoration: InputDecoration(labelText: label, isDense: true),
          items: [
            DropdownMenuItem(value: 'male', child: Text(l10n.pilgrimGenderMale)),
            DropdownMenuItem(
              value: 'female',
              child: Text(l10n.pilgrimGenderFemale),
            ),
          ],
          onChanged: active
              ? (value) {
                  if (value != null) {
                    entry.genderValue = value;
                  }
                }
              : null,
        );
      case PilgrimFieldKind.text:
      case PilgrimFieldKind.multiline:
      case PilgrimFieldKind.url:
      case PilgrimFieldKind.phone:
        return TextField(
          controller: entry.text,
          enabled: active,
          maxLines: field.kind == PilgrimFieldKind.multiline ? 2 : 1,
          keyboardType: switch (field.kind) {
            PilgrimFieldKind.url => TextInputType.url,
            PilgrimFieldKind.phone => TextInputType.phone,
            _ => TextInputType.text,
          },
          decoration: InputDecoration(labelText: label, isDense: true),
        );
    }
  }
}

class _FieldEntry {
  _FieldEntry({this.text});

  bool enabled = false;
  final TextEditingController? text;
  bool boolValue = false;
  DateTime? dateValue;
  String genderValue = 'male';

  dynamic valueFor(PilgrimFieldKind kind) {
    switch (kind) {
      case PilgrimFieldKind.boolean:
        return boolValue;
      case PilgrimFieldKind.date:
        final date = dateValue;
        if (date == null) {
          return null;
        }
        return '${date.year.toString().padLeft(4, '0')}-'
            '${date.month.toString().padLeft(2, '0')}-'
            '${date.day.toString().padLeft(2, '0')}';
      case PilgrimFieldKind.gender:
        return genderValue;
      case PilgrimFieldKind.text:
      case PilgrimFieldKind.multiline:
      case PilgrimFieldKind.url:
      case PilgrimFieldKind.phone:
        final value = text?.text.trim() ?? '';
        return value.isEmpty ? null : value;
    }
  }
}
