import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question_editor_input.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminCompetitionQuestionEditorDialog extends ConsumerStatefulWidget {
  const AdminCompetitionQuestionEditorDialog({
    required this.competitionId,
    this.question,
    this.sortOrder = 0,
    super.key,
  });

  final String competitionId;
  final CompetitionQuestion? question;
  final int sortOrder;

  @override
  ConsumerState<AdminCompetitionQuestionEditorDialog> createState() =>
      _AdminCompetitionQuestionEditorDialogState();
}

class _AdminCompetitionQuestionEditorDialogState
    extends ConsumerState<AdminCompetitionQuestionEditorDialog> {
  late final FormGroup _form;
  late CompetitionQuestionType _questionType;
  late List<_OptionField> _optionFields;

  bool get _isEditing => widget.question != null;

  @override
  void initState() {
    super.initState();
    final question = widget.question;
    _questionType =
        question?.questionType ?? CompetitionQuestionType.multipleChoice;
    _optionFields = _buildOptionFields(question);
    _form = FormGroup({
      'prompt': FormControl<String>(
        value: question?.prompt ?? '',
        validators: [Validators.required],
      ),
      'explanation': FormControl<String>(value: question?.explanation ?? ''),
      'points': FormControl<int>(
        value: question?.points ?? 10,
        validators: [Validators.delegate(_validatePoints)],
      ),
      'questionType': FormControl<CompetitionQuestionType>(value: _questionType),
    });
  }

  Map<String, dynamic>? _validatePoints(AbstractControl<dynamic> control) {
    final value = control.value as int?;
    return (value == null || value <= 0) ? {'pointsInvalid': true} : null;
  }

  Map<String, dynamic>? _validateOption(AbstractControl<dynamic> control) {
    final value = control.value as String?;
    return (value == null || value.trim().isEmpty)
        ? {'optionRequired': true}
        : null;
  }

  _OptionField _optionField(String text, {required bool isCorrect}) {
    return _OptionField(
      control: FormControl<String>(
        value: text,
        validators: [Validators.delegate(_validateOption)],
      ),
      isCorrect: isCorrect,
    );
  }

  void _syncEnabled(bool isSaving) {
    if (isSaving) {
      if (_form.enabled) {
        _form.markAsDisabled();
      }
      for (final field in _optionFields) {
        if (field.control.enabled) {
          field.control.markAsDisabled();
        }
      }
    } else {
      if (_form.disabled) {
        _form.markAsEnabled();
      }
      for (final field in _optionFields) {
        if (field.control.disabled) {
          field.control.markAsEnabled();
        }
      }
    }
  }

  @override
  void dispose() {
    _form.dispose();
    for (final field in _optionFields) {
      field.control.dispose();
    }
    super.dispose();
  }

  void _reorderOption(int oldIndex, int newIndex) {
    setState(() {
      final field = _optionFields.removeAt(oldIndex);
      _optionFields.insert(newIndex, field);
    });
  }

  void _addOrderingStep() {
    if (_optionFields.length >= 8) {
      return;
    }
    setState(() {
      _optionFields.add(_optionField('', isCorrect: false));
    });
  }

  void _removeOrderingStep(int index) {
    if (_optionFields.length <= 3) {
      return;
    }
    setState(() {
      _optionFields.removeAt(index).control.dispose();
    });
  }

  List<_OptionField> _buildOptionFields(CompetitionQuestion? question) {
    if (question != null) {
      final sorted = [...question.options]
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      return sorted
          .map(
            (option) =>
                _optionField(option.label, isCorrect: option.isCorrect),
          )
          .toList();
    }

    return CompetitionQuestionEditorInput.defaultMultipleChoiceOptions()
        .map(
          (option) => _optionField(option.label, isCorrect: option.isCorrect),
        )
        .toList();
  }

  void _onTypeChanged(CompetitionQuestionType? value) {
    if (value == null || value == _questionType) {
      return;
    }

    setState(() {
      _questionType = value;
      for (final field in _optionFields) {
        field.control.dispose();
      }
      _optionFields = switch (value) {
        CompetitionQuestionType.trueFalse => [
            _optionField('true', isCorrect: true),
            _optionField('false', isCorrect: false),
          ],
        CompetitionQuestionType.ordering =>
          CompetitionQuestionEditorInput.defaultOrderingOptions()
              .map((option) => _optionField('', isCorrect: false))
              .toList(),
        CompetitionQuestionType.multipleChoice =>
          CompetitionQuestionEditorInput.defaultMultipleChoiceOptions()
              .map(
                (option) => _optionField('', isCorrect: option.isCorrect),
              )
              .toList(),
      };
    });
  }

  void _setCorrectIndex(int index) {
    setState(() {
      for (var i = 0; i < _optionFields.length; i++) {
        _optionFields[i].isCorrect = i == index;
      }
    });
  }

  Future<void> _submit() async {
    final optionsValid = _optionFields.every((field) => field.control.valid);
    if (!_form.valid || !optionsValid) {
      _form.markAllAsTouched();
      for (final field in _optionFields) {
        field.control.markAllAsTouched();
      }
      return;
    }

    final points = _form.control('points').value as int;
    if (points <= 0) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final options = <CompetitionQuestionOptionInput>[];
    for (var i = 0; i < _optionFields.length; i++) {
      final field = _optionFields[i];
      options.add(
        CompetitionQuestionOptionInput(
          label: _questionType == CompetitionQuestionType.trueFalse
              ? (i == 0 ? 'true' : 'false')
              : field.control.value ?? '',
          isCorrect: _questionType == CompetitionQuestionType.ordering
              ? false
              : field.isCorrect,
          sortOrder: i,
        ),
      );
    }

    final ok = await ref.read(adminCompetitionQuestionSaveProvider.notifier).save(
          CompetitionQuestionEditorInput(
            id: widget.question?.id,
            competitionId: widget.competitionId,
            questionType: _questionType,
            prompt: _form.control('prompt').value as String,
            explanation: _form.control('explanation').value as String? ?? '',
            points: points,
            options: options,
            sortOrder: widget.question?.sortOrder ?? widget.sortOrder,
          ),
        );

    if (!mounted) {
      return;
    }

    if (ok) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminCompetitionQuestionSaveError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isSaving = ref.watch(
      adminCompetitionQuestionSaveProvider.select((state) => state.isLoading),
    );
    _syncEnabled(isSaving);

    return AlertDialog(
      title: Text(
        _isEditing
            ? l10n.adminCompetitionQuestionEditTitle
            : l10n.adminCompetitionQuestionNewTitle,
      ),
      content: SizedBox(
        width: 520.w,
        child: ReactiveForm(
          formGroup: _form,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ReactiveDropdownField<CompetitionQuestionType>(
                  formControlName: 'questionType',
                  decoration: InputDecoration(
                    labelText: l10n.adminCompetitionQuestionTypeLabel,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: CompetitionQuestionType.multipleChoice,
                      child: Text(l10n.adminCompetitionQuestionTypeMultipleChoice),
                    ),
                    DropdownMenuItem(
                      value: CompetitionQuestionType.trueFalse,
                      child: Text(l10n.adminCompetitionQuestionTypeTrueFalse),
                    ),
                    DropdownMenuItem(
                      value: CompetitionQuestionType.ordering,
                      child: Text(l10n.adminCompetitionQuestionTypeOrdering),
                    ),
                  ],
                  onChanged: (control) => _onTypeChanged(control.value),
                ),
                SizedBox(height: 12.h),
                ReactiveTextField<String>(
                  formControlName: 'prompt',
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.adminCompetitionQuestionPromptLabel,
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        l10n.adminCompetitionQuestionPromptRequired,
                  },
                ),
                SizedBox(height: 12.h),
                ReactiveTextField<String>(
                  formControlName: 'explanation',
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.adminCompetitionQuestionExplanationLabel,
                  ),
                ),
                SizedBox(height: 12.h),
                ReactiveTextField<int>(
                  formControlName: 'points',
                  valueAccessor: IntValueAccessor(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.adminCompetitionQuestionPointsLabel,
                  ),
                  validationMessages: {
                    'pointsInvalid': (_) =>
                        l10n.adminCompetitionQuestionPointsInvalid,
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  _questionType == CompetitionQuestionType.ordering
                      ? l10n.adminCompetitionQuestionOrderingStepsLabel
                      : l10n.adminCompetitionQuestionOptionsLabel,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                if (_questionType == CompetitionQuestionType.ordering) ...[
                  SizedBox(height: 4.h),
                  Text(
                    l10n.adminCompetitionQuestionOrderingStepsHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                SizedBox(height: 8.h),
                if (_questionType == CompetitionQuestionType.ordering)
                  ReorderableListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    onReorder: isSaving ? (_, _) {} : _reorderOption,
                    buildDefaultDragHandles: !isSaving,
                    itemCount: _optionFields.length,
                    itemBuilder: (context, index) {
                      final field = _optionFields[index];
                      return Padding(
                        key: ValueKey('ordering-step-$index'),
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ReactiveTextField<String>(
                                formControl: field.control,
                                decoration: InputDecoration(
                                  labelText: l10n.adminCompetitionQuestionStepLabel(
                                    index + 1,
                                  ),
                                ),
                                validationMessages: {
                                  'optionRequired': (_) => l10n
                                      .adminCompetitionQuestionOptionRequired,
                                },
                              ),
                            ),
                            if (_optionFields.length > 3)
                              IconButton(
                                onPressed: isSaving
                                    ? null
                                    : () => _removeOrderingStep(index),
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                          ],
                        ),
                      );
                    },
                  )
                else if (_questionType == CompetitionQuestionType.trueFalse)
                  RadioGroup<int>(
                    groupValue: _optionFields.indexWhere((o) => o.isCorrect),
                    onChanged: (value) {
                      if (isSaving || value == null) {
                        return;
                      }
                      _setCorrectIndex(value);
                    },
                    child: Column(
                      children: [
                        RadioListTile<int>(
                          value: 0,
                          enabled: !isSaving,
                          title: Text(l10n.competitionAnswerTrue),
                        ),
                        RadioListTile<int>(
                          value: 1,
                          enabled: !isSaving,
                          title: Text(l10n.competitionAnswerFalse),
                        ),
                      ],
                    ),
                  )
                else
                  RadioGroup<int>(
                    groupValue: _optionFields.indexWhere((o) => o.isCorrect),
                    onChanged: (value) {
                      if (isSaving || value == null) {
                        return;
                      }
                      _setCorrectIndex(value);
                    },
                    child: Column(
                      children: [
                        for (var index = 0; index < _optionFields.length; index++)
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Row(
                              children: [
                                Radio<int>(
                                  value: index,
                                  enabled: !isSaving,
                                ),
                                Expanded(
                                  child: ReactiveTextField<String>(
                                    formControl: _optionFields[index].control,
                                    decoration: InputDecoration(
                                      labelText:
                                          l10n.adminCompetitionQuestionOptionLabel(
                                        index + 1,
                                      ),
                                    ),
                                    validationMessages: {
                                      'optionRequired': (_) => l10n
                                          .adminCompetitionQuestionOptionRequired,
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                if (_questionType == CompetitionQuestionType.ordering &&
                    _optionFields.length < 8)
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton.icon(
                      onPressed: isSaving ? null : _addOrderingStep,
                      icon: const Icon(Icons.add_rounded),
                      label: Text(l10n.adminCompetitionQuestionAddStep),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: isSaving ? null : () => Navigator.pop(context),
          child: Text(l10n.dialogCancel),
        ),
        FilledButton(
          onPressed: isSaving ? null : _submit,
          child: isSaving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.adminContentSave),
        ),
      ],
    );
  }
}

class _OptionField {
  _OptionField({
    required this.control,
    required this.isCorrect,
  });

  final FormControl<String> control;
  bool isCorrect;
}
