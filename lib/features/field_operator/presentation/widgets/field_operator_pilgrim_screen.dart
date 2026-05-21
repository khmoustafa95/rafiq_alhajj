import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_field_record.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/providers/field_operator_providers.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class FieldOperatorPilgrimScreen extends ConsumerStatefulWidget {
  const FieldOperatorPilgrimScreen({required this.profileId, super.key});

  final String profileId;

  @override
  ConsumerState<FieldOperatorPilgrimScreen> createState() =>
      _FieldOperatorPilgrimScreenState();
}

class _FieldOperatorPilgrimScreenState
    extends ConsumerState<FieldOperatorPilgrimScreen> {
  String? _fieldStatus;
  final _medicalController = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _medicalController.dispose();
    super.dispose();
  }

  void _bindRecord(PilgrimFieldRecord record) {
    if (_initialized) {
      return;
    }
    _fieldStatus = record.fieldStatus ?? FieldPilgrimStatus.pending;
    _medicalController.text = record.medicalTestStatus ?? '';
    _initialized = true;
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final saved = await ref
        .read(fieldOperatorPilgrimDetailProvider(widget.profileId).notifier)
        .save(
          fieldStatus: _fieldStatus,
          medicalTestStatus: _medicalController.text.trim().isEmpty
              ? null
              : _medicalController.text.trim(),
        );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          saved ? l10n.fieldOperatorSaveSuccess : l10n.fieldOperatorSaveError,
        ),
      ),
    );
  }

  void _shareSummary(PilgrimFieldRecord record) {
    final l10n = AppLocalizations.of(context);
    final summary = l10n.fieldOperatorShareSummary(
      record.fullName,
      fieldStatusLabel(l10n, _fieldStatus),
      _medicalController.text.trim().isEmpty
          ? l10n.fieldStatusNotSet
          : _medicalController.text.trim(),
      record.hotelName ?? l10n.fieldStatusNotSet,
    );

    unawaited(Clipboard.setData(ClipboardData(text: summary)));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.fieldOperatorCopied)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final detailAsync =
        ref.watch(fieldOperatorPilgrimDetailProvider(widget.profileId));
    final isSaving = detailAsync.isLoading && _initialized;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.fieldOperatorPilgrimTitle)),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.fieldOperatorLoadError)),
        data: (record) {
          if (record == null) {
            return Center(child: Text(l10n.fieldOperatorNotFound));
          }

          _bindRecord(record);

          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              Text(
                record.fullName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 8.h),
              if (record.passportNumber != null)
                Text('${l10n.operatorPassport}: ${record.passportNumber}'),
              if (record.travelPermitNumber != null)
                Text(
                  '${l10n.operatorTravelPermit}: ${record.travelPermitNumber}',
                ),
              SizedBox(height: 24.h),
              Text(
                l10n.fieldOperatorStatusSection,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.h),
              RadioGroup<String>(
                groupValue: _fieldStatus,
                onChanged: (value) => setState(() => _fieldStatus = value),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
              SizedBox(height: 16.h),
              TextField(
                controller: _medicalController,
                enabled: !isSaving,
                decoration: InputDecoration(
                  labelText: l10n.fieldOperatorMedicalLabel,
                ),
              ),
              if (record.hotelName != null) ...[
                SizedBox(height: 16.h),
                Text('${l10n.fieldOperatorHotelLabel}: ${record.hotelName}'),
              ],
              if (record.transportationDetails != null) ...[
                SizedBox(height: 8.h),
                Text(
                  '${l10n.fieldOperatorTransportLabel}: '
                  '${record.transportationDetails}',
                ),
              ],
              SizedBox(height: 24.h),
              FilledButton(
                onPressed: isSaving ? null : _save,
                child: isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.fieldOperatorSave),
              ),
              SizedBox(height: 12.h),
              OutlinedButton.icon(
                onPressed: isSaving ? null : () => _shareSummary(record),
                icon: const Icon(Icons.copy_outlined),
                label: Text(l10n.fieldOperatorShare),
              ),
            ],
          );
        },
      ),
    );
  }
}
