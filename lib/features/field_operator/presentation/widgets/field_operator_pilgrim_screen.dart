import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/providers/field_operator_providers.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_l10n.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_pilgrim_header_card.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_pilgrim_status_form.dart';
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
              FieldOperatorPilgrimHeaderCard(pilgrim: pilgrim, name: name),
              SizedBox(height: 16.h),
              FieldOperatorPilgrimStatusForm(
                form: _form,
                fieldStatus: _fieldStatus,
                isSaving: isSaving,
                onFieldStatusChanged: (value) =>
                    setState(() => _fieldStatus = value),
                onSave: _save,
                onCancel: _cancel,
                onShare: () => _shareSummary(pilgrim),
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
