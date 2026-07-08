import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/admin_competition_question_options_editor.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Core fields for the admin competition question editor dialog.
class AdminCompetitionQuestionEditorForm extends StatelessWidget {
  const AdminCompetitionQuestionEditorForm({
    required this.form,
    required this.questionType,
    required this.optionFields,
    required this.isSaving,
    required this.onTypeChanged,
    required this.onReorder,
    required this.onAddOrderingStep,
    required this.onRemoveOrderingStep,
    required this.onSetCorrectIndex,
    super.key,
  });

  final FormGroup form;
  final CompetitionQuestionType questionType;
  final List<CompetitionQuestionOptionField> optionFields;
  final bool isSaving;
  final ValueChanged<CompetitionQuestionType?> onTypeChanged;
  final void Function(int oldIndex, int newIndex) onReorder;
  final VoidCallback onAddOrderingStep;
  final ValueChanged<int> onRemoveOrderingStep;
  final ValueChanged<int> onSetCorrectIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ReactiveForm(
      formGroup: form,
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
            onChanged: (control) => onTypeChanged(control.value),
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
              'pointsInvalid': (_) => l10n.adminCompetitionQuestionPointsInvalid,
            },
          ),
          SizedBox(height: 16.h),
          AdminCompetitionQuestionOptionsEditor(
            questionType: questionType,
            optionFields: optionFields,
            isSaving: isSaving,
            onReorder: onReorder,
            onAddOrderingStep: onAddOrderingStep,
            onRemoveOrderingStep: onRemoveOrderingStep,
            onSetCorrectIndex: onSetCorrectIndex,
          ),
        ],
      ),
    );
  }
}
