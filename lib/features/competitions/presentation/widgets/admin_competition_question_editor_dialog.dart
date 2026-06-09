import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question_editor_input.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

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
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _promptController;
  late final TextEditingController _explanationController;
  late final TextEditingController _pointsController;
  late CompetitionQuestionType _questionType;
  late List<_OptionField> _optionFields;

  bool get _isEditing => widget.question != null;

  @override
  void initState() {
    super.initState();
    final question = widget.question;
    _promptController = TextEditingController(text: question?.prompt ?? '');
    _explanationController =
        TextEditingController(text: question?.explanation ?? '');
    _pointsController = TextEditingController(
      text: '${question?.points ?? 10}',
    );
    _questionType =
        question?.questionType ?? CompetitionQuestionType.multipleChoice;
    _optionFields = _buildOptionFields(question);
  }

  @override
  void dispose() {
    _promptController.dispose();
    _explanationController.dispose();
    _pointsController.dispose();
    for (final field in _optionFields) {
      field.controller.dispose();
    }
    super.dispose();
  }

  void _reorderOption(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
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
      _optionFields.add(
        _OptionField(controller: TextEditingController(), isCorrect: false),
      );
    });
  }

  void _removeOrderingStep(int index) {
    if (_optionFields.length <= 3) {
      return;
    }
    setState(() {
      _optionFields.removeAt(index).controller.dispose();
    });
  }

  List<_OptionField> _buildOptionFields(CompetitionQuestion? question) {
    if (question != null) {
      final sorted = [...question.options]
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      return sorted
          .map(
            (option) => _OptionField(
              controller: TextEditingController(text: option.label),
              isCorrect: option.isCorrect,
            ),
          )
          .toList();
    }

    return CompetitionQuestionEditorInput.defaultMultipleChoiceOptions()
        .map(
          (option) => _OptionField(
            controller: TextEditingController(text: option.label),
            isCorrect: option.isCorrect,
          ),
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
        field.controller.dispose();
      }
      _optionFields = switch (value) {
        CompetitionQuestionType.trueFalse => [
            _OptionField(
              controller: TextEditingController(text: 'true'),
              isCorrect: true,
            ),
            _OptionField(
              controller: TextEditingController(text: 'false'),
              isCorrect: false,
            ),
          ],
        CompetitionQuestionType.ordering =>
          CompetitionQuestionEditorInput.defaultOrderingOptions()
              .map(
                (option) => _OptionField(
                  controller: TextEditingController(),
                  isCorrect: false,
                ),
              )
              .toList(),
        CompetitionQuestionType.multipleChoice =>
          CompetitionQuestionEditorInput.defaultMultipleChoiceOptions()
              .map(
                (option) => _OptionField(
                  controller: TextEditingController(),
                  isCorrect: option.isCorrect,
                ),
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final points = int.tryParse(_pointsController.text.trim());
    if (points == null || points <= 0) {
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
              : field.controller.text,
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
            prompt: _promptController.text,
            explanation: _explanationController.text,
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

    return AlertDialog(
      title: Text(
        _isEditing
            ? l10n.adminCompetitionQuestionEditTitle
            : l10n.adminCompetitionQuestionNewTitle,
      ),
      content: SizedBox(
        width: 520.w,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<CompetitionQuestionType>(
                  key: ValueKey(_questionType),
                  initialValue: _questionType,
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
                  onChanged: isSaving ? null : _onTypeChanged,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _promptController,
                  enabled: !isSaving,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.adminCompetitionQuestionPromptLabel,
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? l10n.adminCompetitionQuestionPromptRequired
                      : null,
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _explanationController,
                  enabled: !isSaving,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10n.adminCompetitionQuestionExplanationLabel,
                  ),
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _pointsController,
                  enabled: !isSaving,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.adminCompetitionQuestionPointsLabel,
                  ),
                  validator: (value) {
                    final points = int.tryParse(value?.trim() ?? '');
                    if (points == null || points <= 0) {
                      return l10n.adminCompetitionQuestionPointsInvalid;
                    }
                    return null;
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
                              child: TextFormField(
                                controller: field.controller,
                                enabled: !isSaving,
                                decoration: InputDecoration(
                                  labelText: l10n.adminCompetitionQuestionStepLabel(
                                    index + 1,
                                  ),
                                ),
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                        ? l10n.adminCompetitionQuestionOptionRequired
                                        : null,
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
                                  child: TextFormField(
                                    controller: _optionFields[index].controller,
                                    enabled: !isSaving,
                                    decoration: InputDecoration(
                                      labelText:
                                          l10n.adminCompetitionQuestionOptionLabel(
                                        index + 1,
                                      ),
                                    ),
                                    validator: (value) =>
                                        value == null || value.trim().isEmpty
                                            ? l10n
                                                .adminCompetitionQuestionOptionRequired
                                            : null,
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
    required this.controller,
    required this.isCorrect,
  });

  final TextEditingController controller;
  bool isCorrect;
}
