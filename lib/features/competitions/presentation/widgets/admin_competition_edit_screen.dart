import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_editor_input.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/admin_competition_questions_panel.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminCompetitionEditScreen extends ConsumerStatefulWidget {
  const AdminCompetitionEditScreen({this.competitionId, super.key});

  final String? competitionId;

  @override
  ConsumerState<AdminCompetitionEditScreen> createState() =>
      _AdminCompetitionEditScreenState();
}

class _AdminCompetitionEditScreenState
    extends ConsumerState<AdminCompetitionEditScreen> {
  late final FormGroup _form;
  DateTime? _startsAt;
  DateTime? _endsAt;
  bool _isActive = true;
  bool _loaded = false;

  bool get _isEditing => widget.competitionId != null;

  String _pageTitle(AppLocalizations l10n) =>
      _isEditing ? l10n.adminCompetitionEditTitle : l10n.adminCompetitionNewTitle;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'title': FormControl<String>(value: '', validators: [Validators.required]),
      'description': FormControl<String>(value: ''),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _bind(Competition competition) {
    if (_loaded) {
      return;
    }
    _form.control('title').updateValue(competition.title);
    _form.control('description').updateValue(competition.description ?? '');
    _startsAt = competition.startsAt.toLocal();
    _endsAt = competition.endsAt.toLocal();
    _isActive = competition.isActive;
    _loaded = true;
  }

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: (isStart ? _startsAt : _endsAt) ?? DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startsAt = picked;
        } else {
          _endsAt = picked;
        }
      });
    }
  }

  void _cancel() {
    staffNavigateBack(context, fallbackRoute: AppRoutes.adminCompetitions);
  }

  Future<void> _submit() async {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }
    if (_startsAt == null || _endsAt == null) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final ok = await ref.read(adminCompetitionSaveProvider.notifier).save(
          CompetitionEditorInput(
            id: widget.competitionId,
            title: _form.control('title').value as String,
            description: _form.control('description').value as String? ?? '',
            startsAt: _startsAt!,
            endsAt: _endsAt!,
            isActive: _isActive,
          ),
        );

    if (!mounted) {
      return;
    }

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminCompetitionSaveSuccess)),
      );
      context.go(AppRoutes.adminCompetitions);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminCompetitionSaveError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isSaving = ref.watch(
      adminCompetitionSaveProvider.select((state) => state.isLoading),
    );
    if (isSaving && _form.enabled) {
      _form.markAsDisabled();
    } else if (!isSaving && _form.disabled) {
      _form.markAsEnabled();
    }

    if (_isEditing) {
      final listAsync = ref.watch(adminCompetitionListProvider);
      return listAsync.when(
        loading: () => StaffAdaptivePage(
          web: StaffWebPage(
            title: _pageTitle(l10n),
            body: const Center(child: CircularProgressIndicator()),
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(title: Text(_pageTitle(l10n))),
            body: const Center(child: CircularProgressIndicator()),
          ),
        ),
        error: (_, _) => StaffAdaptivePage(
          web: StaffWebPage(
            title: _pageTitle(l10n),
            body: StaffEmptyState(message: l10n.adminCompetitionsLoadError),
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(title: Text(_pageTitle(l10n))),
            body: Center(child: Text(l10n.adminCompetitionsLoadError)),
          ),
        ),
        data: (items) {
          Competition? found;
          for (final item in items) {
            if (item.id == widget.competitionId) {
              found = item;
              break;
            }
          }
          if (found == null) {
            return StaffAdaptivePage(
              web: StaffWebPage(
                title: _pageTitle(l10n),
                body: StaffEmptyState(message: l10n.competitionNotFound),
              ),
              mobile: Scaffold(
                appBar: RafiqAppBar(title: Text(_pageTitle(l10n))),
                body: Center(child: Text(l10n.competitionNotFound)),
              ),
            );
          }
          _bind(found);
          return _buildForm(l10n, isSaving);
        },
      );
    }

    _startsAt ??= DateTime.now();
    _endsAt ??= DateTime.now().add(const Duration(days: 30));
    return _buildForm(l10n, isSaving);
  }

  Widget _buildForm(AppLocalizations l10n, bool isSaving) {
    final form = ReactiveForm(
      formGroup: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaffFormSection(
            icon: Icons.emoji_events_outlined,
            title: l10n.adminCompetitionsTitle,
            child: ResponsiveFormGrid(
              children: [
                ReactiveTextField<String>(
                  formControlName: 'title',
                  decoration:
                      InputDecoration(labelText: l10n.adminContentTitleLabel),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        l10n.adminContentTitleRequired,
                  },
                ),
                ReactiveTextField<String>(
                  formControlName: 'description',
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: l10n.adminContentDescriptionLabel,
                  ),
                ),
                StaffDateFormField(
                  label: l10n.adminCompetitionStartsAt,
                  value: _startsAt,
                  onPick: isSaving ? null : () => _pickDate(isStart: true),
                  enabled: !isSaving,
                ),
                StaffDateFormField(
                  label: l10n.adminCompetitionEndsAt,
                  value: _endsAt,
                  onPick: isSaving ? null : () => _pickDate(isStart: false),
                  enabled: !isSaving,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.adminCompetitionActive),
                  value: _isActive,
                  onChanged: isSaving
                      ? null
                      : (value) => setState(() => _isActive = value),
                ),
              ],
            ),
          ),
          if (_isEditing && widget.competitionId != null) ...[
            SizedBox(height: 16.h),
            AdminCompetitionQuestionsPanel(
              competitionId: widget.competitionId!,
            ),
          ],
        ],
      ),
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: _pageTitle(l10n),
        body: SingleChildScrollView(child: form),
        bottomBar: StaffFormActionsBar(
          primaryLabel: l10n.adminContentSave,
          onPrimary: _submit,
          secondaryLabel: l10n.dialogCancel,
          onSecondary: isSaving ? null : _cancel,
          isLoading: isSaving,
        ),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(title: Text(_pageTitle(l10n))),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: form,
        ),
        bottomNavigationBar: StaffFormMobileActionsBar(
          primaryLabel: l10n.adminContentSave,
          onPrimary: _submit,
          secondaryLabel: l10n.dialogCancel,
          onSecondary: isSaving ? null : _cancel,
          isLoading: isSaving,
        ),
      ),
    );
  }
}
