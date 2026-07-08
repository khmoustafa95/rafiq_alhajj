import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/forms/journey_media_form.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/providers/hajj_journey_providers.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/widgets/admin_hajj_journey_edit_form.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminHajjJourneyEditScreen extends ConsumerStatefulWidget {
  const AdminHajjJourneyEditScreen({required this.ritualKey, super.key});

  final String ritualKey;

  @override
  ConsumerState<AdminHajjJourneyEditScreen> createState() =>
      _AdminHajjJourneyEditScreenState();
}

class _AdminHajjJourneyEditScreenState
    extends ConsumerState<AdminHajjJourneyEditScreen> {
  late final FormGroup _form;
  bool _isActive = true;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'titleAr': FormControl<String>(value: ''),
      'titleEn': FormControl<String>(value: ''),
      'descriptionAr': FormControl<String>(value: ''),
      'descriptionEn': FormControl<String>(value: ''),
      'sortOrder': FormControl<String>(value: '1'),
      'media': FormArray<dynamic>([]),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  FormArray<dynamic> get _mediaArray => JourneyMediaForm.mediaArray(_form);

  void _populate(HajjJourneyStep step) {
    if (_initialized) {
      return;
    }
    _form.control('titleAr').updateValue(step.titleAr);
    _form.control('titleEn').updateValue(step.titleEn);
    _form.control('descriptionAr').updateValue(step.descriptionAr);
    _form.control('descriptionEn').updateValue(step.descriptionEn);
    _form.control('sortOrder').updateValue('${step.sortOrder}');
    _isActive = step.isActive;
    JourneyMediaForm.bindStepMedia(_form, step);
    _initialized = true;
  }

  void _addMedia() {
    setState(() {
      _mediaArray.add(JourneyMediaForm.newMediaGroup());
    });
  }

  void _removeMedia(int index) {
    setState(() {
      _mediaArray.removeAt(index);
    });
  }

  void _cancel() {
    staffNavigateBack(context, fallbackRoute: AppRoutes.adminHajjJourney);
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final sortOrder =
        int.tryParse((_form.control('sortOrder').value as String).trim()) ?? 1;

    final input = HajjJourneyEditorInput(
      ritualKey: widget.ritualKey,
      sortOrder: sortOrder,
      titleAr: (_form.control('titleAr').value as String).trim(),
      titleEn: (_form.control('titleEn').value as String).trim(),
      descriptionAr: (_form.control('descriptionAr').value as String).trim(),
      descriptionEn: (_form.control('descriptionEn').value as String).trim(),
      isActive: _isActive,
    );

    if (input.titleAr.isEmpty || input.titleEn.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminHajjJourneyTitleRequired)),
      );
      return;
    }

    final media = JourneyMediaForm.toInputs(_mediaArray);

    await ref.read(adminHajjJourneySaveProvider.notifier).save(
          ritualKey: widget.ritualKey,
          input: input,
          media: media,
        );

    if (!mounted) {
      return;
    }

    final saveState = ref.read(adminHajjJourneySaveProvider);
    if (saveState.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminHajjJourneySaveError)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.adminHajjJourneySaveSuccess)),
    );
    _cancel();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final stepAsync = ref.watch(adminHajjJourneyStepProvider(widget.ritualKey));
    final isSaving = ref.watch(adminHajjJourneySaveProvider).isLoading;

    final body = stepAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => Center(child: Text(l10n.adminHajjJourneyLoadError)),
      data: (step) {
        if (step != null) {
          _populate(step);
        }
        return AdminHajjJourneyEditForm(
          form: _form,
          isActive: _isActive,
          onActiveChanged: (v) => setState(() => _isActive = v),
          onAddMedia: _addMedia,
          onRemoveMedia: _removeMedia,
        );
      },
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.adminHajjJourneyEditTitle,
        body: body,
        bottomBar: StaffFormActionsBar(
          primaryLabel: l10n.adminContentSave,
          onPrimary: isSaving ? null : _save,
          secondaryLabel: l10n.dialogCancel,
          onSecondary: isSaving ? null : _cancel,
          isLoading: isSaving,
        ),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.adminHajjJourneyEditTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: isSaving ? null : _cancel,
          ),
          automaticallyImplyLeading: false,
        ),
        body: body,
        bottomNavigationBar: StaffFormMobileActionsBar(
          primaryLabel: l10n.adminContentSave,
          onPrimary: isSaving ? null : _save,
          secondaryLabel: l10n.dialogCancel,
          onSecondary: isSaving ? null : _cancel,
          isLoading: isSaving,
        ),
      ),
    );
  }
}
