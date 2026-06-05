import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_editor_input.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminCompetitionEditScreen extends ConsumerStatefulWidget {
  const AdminCompetitionEditScreen({this.competitionId, super.key});

  final String? competitionId;

  @override
  ConsumerState<AdminCompetitionEditScreen> createState() =>
      _AdminCompetitionEditScreenState();
}

class _AdminCompetitionEditScreenState
    extends ConsumerState<AdminCompetitionEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startsAt;
  DateTime? _endsAt;
  bool _isActive = true;
  bool _loaded = false;

  bool get _isEditing => widget.competitionId != null;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _bind(Competition competition) {
    if (_loaded) {
      return;
    }
    _titleController.text = competition.title;
    _descriptionController.text = competition.description ?? '';
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_startsAt == null || _endsAt == null) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final ok = await ref.read(adminCompetitionSaveProvider.notifier).save(
          CompetitionEditorInput(
            id: widget.competitionId,
            title: _titleController.text,
            description: _descriptionController.text,
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

    if (_isEditing) {
      final listAsync = ref.watch(adminCompetitionListProvider);
      return listAsync.when(
        loading: () => Scaffold(
          appBar: AppBar(title: Text(l10n.adminCompetitionEditTitle)),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (_, _) => Scaffold(
          appBar: AppBar(title: Text(l10n.adminCompetitionEditTitle)),
          body: Center(child: Text(l10n.adminCompetitionsLoadError)),
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
            return Scaffold(
              appBar: AppBar(title: Text(l10n.adminCompetitionEditTitle)),
              body: Center(child: Text(l10n.competitionNotFound)),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing
              ? l10n.adminCompetitionEditTitle
              : l10n.adminCompetitionNewTitle,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            TextFormField(
              controller: _titleController,
              enabled: !isSaving,
              decoration: InputDecoration(labelText: l10n.adminContentTitleLabel),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? l10n.adminContentTitleRequired : null,
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _descriptionController,
              enabled: !isSaving,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: l10n.adminContentDescriptionLabel,
              ),
            ),
            SizedBox(height: 16.h),
            ListTile(
              title: Text(l10n.adminCompetitionStartsAt),
              subtitle: Text(
                _startsAt == null
                    ? '—'
                    : MaterialLocalizations.of(context)
                        .formatMediumDate(_startsAt!),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: isSaving ? null : () => _pickDate(isStart: true),
              ),
            ),
            ListTile(
              title: Text(l10n.adminCompetitionEndsAt),
              subtitle: Text(
                _endsAt == null
                    ? '—'
                    : MaterialLocalizations.of(context)
                        .formatMediumDate(_endsAt!),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: isSaving ? null : () => _pickDate(isStart: false),
              ),
            ),
            SwitchListTile(
              title: Text(l10n.adminCompetitionActive),
              value: _isActive,
              onChanged: isSaving
                  ? null
                  : (value) => setState(() => _isActive = value),
            ),
            SizedBox(height: 24.h),
            FilledButton(
              onPressed: isSaving ? null : _submit,
              child: isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.adminContentSave),
            ),
          ],
        ),
      ),
    );
  }
}
