import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/providers/field_operator_providers.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_colors.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_l10n.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';
import 'package:rafiq_alhajj/features/pilgrim/presentation/widgets/pilgrim_profile_sections.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
  late final FormGroup _form;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({'medical': FormControl<String>(value: '')});
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _bindRecord(Pilgrim pilgrim) {
    if (_initialized) {
      return;
    }
    _fieldStatus = pilgrim.fieldStatus ?? FieldPilgrimStatus.pending;
    _form.control('medical').updateValue(pilgrim.medicalTestStatus ?? '');
    _initialized = true;
  }

  void _cancel() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.fieldOperatorPilgrims);
    }
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final medical = (_form.control('medical').value as String? ?? '').trim();
    final saved = await ref
        .read(fieldOperatorPilgrimDetailProvider(widget.profileId).notifier)
        .save(
          fieldStatus: _fieldStatus,
          medicalTestStatus: medical.isEmpty ? null : medical,
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

  void _shareSummary(Pilgrim pilgrim) {
    final l10n = AppLocalizations.of(context);
    final name = pilgrim.displayName ?? pilgrim.fullNameAr ?? '';
    final medical = (_form.control('medical').value as String? ?? '').trim();
    final summary = l10n.fieldOperatorShareSummary(
      name,
      fieldStatusLabel(l10n, _fieldStatus),
      medical.isEmpty ? l10n.fieldStatusNotSet : medical,
      pilgrim.makkahHotel ?? pilgrim.hotelName ?? l10n.fieldStatusNotSet,
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
    if (isSaving && _form.enabled) {
      _form.markAsDisabled();
    } else if (!isSaving && _form.disabled) {
      _form.markAsEnabled();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: RafiqAppBar(
        title: Text(l10n.fieldOperatorPilgrimTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: isSaving ? null : _cancel,
        ),
        automaticallyImplyLeading: false,
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.fieldOperatorLoadError)),
        data: (pilgrim) {
          if (pilgrim == null) {
            return Center(child: Text(l10n.fieldOperatorNotFound));
          }

          _bindRecord(pilgrim);
          final name = pilgrim.displayName ?? pilgrim.fullNameAr ?? '';

          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              _HeaderCard(pilgrim: pilgrim, name: name),
              SizedBox(height: 16.h),
              Card(
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
                        groupValue: _fieldStatus,
                        onChanged: (value) {
                          if (isSaving) {
                            return;
                          }
                          setState(() => _fieldStatus = value);
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
                        formGroup: _form,
                        child: ReactiveTextField<String>(
                          formControlName: 'medical',
                          decoration: InputDecoration(
                            labelText: l10n.fieldOperatorMedicalLabel,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
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
                      SizedBox(height: 8.h),
                      OutlinedButton(
                        onPressed: isSaving ? null : _cancel,
                        child: Text(l10n.dialogCancel),
                      ),
                      SizedBox(height: 8.h),
                      OutlinedButton.icon(
                        onPressed: isSaving ? null : () => _shareSummary(pilgrim),
                        icon: const Icon(Icons.copy_outlined),
                        label: Text(l10n.fieldOperatorShare),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                l10n.pilgrimProfileTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 12.h),
              PilgrimProfileSections(pilgrim: pilgrim),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.pilgrim,
    required this.name,
  });

  final Pilgrim pilgrim;
  final String name;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final statusLabel = fieldStatusLabel(l10n, pilgrim.fieldStatus);
    final statusBg = FieldStatusColors.background(pilgrim.fieldStatus);
    final statusFg = FieldStatusColors.foreground(pilgrim.fieldStatus);
    final initial = name.isNotEmpty ? name[0] : '?';

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: Text(
                initial,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (pilgrim.groupName != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      pilgrim.groupName!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                  if (pilgrim.stickerNumber != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      '${l10n.pilgrimLabelSticker}: ${pilgrim.stickerNumber}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: statusBg,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                statusLabel,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: statusFg,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
