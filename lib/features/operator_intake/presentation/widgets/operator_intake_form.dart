import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_fields_form.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/trip_selector.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OperatorIntakeForm extends StatelessWidget {
  const OperatorIntakeForm({
    required this.form,
    required this.isSubmitting,
    required this.generatedPassword,
    required this.pickedCount,
    required this.groups,
    required this.onClearSharedDefaults,
    required this.onGenerateCredentials,
    required this.onPickFiles,
    required this.onSubmit,
    required this.onClearForm,
    super.key,
  });

  final FormGroup form;
  final bool isSubmitting;
  final String? generatedPassword;
  final int pickedCount;
  final List<PilgrimGroupOption> groups;
  final VoidCallback onClearSharedDefaults;
  final VoidCallback onGenerateCredentials;
  final VoidCallback onPickFiles;
  final VoidCallback onSubmit;
  final VoidCallback onClearForm;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaffFormSection(
            icon: Icons.bookmarks_outlined,
            title: l10n.operatorSharedDefaultsTitle,
            subtitle: l10n.operatorSharedDefaultsHint,
            trailing: OutlinedButton.icon(
              onPressed: isSubmitting ? null : onClearSharedDefaults,
              icon: const Icon(Icons.layers_clear_outlined, size: 18),
              label: Text(l10n.operatorClearSharedDefaults),
            ),
            child: const Align(
              alignment: AlignmentDirectional.centerStart,
              child: TripSelector(),
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.smartphone_outlined,
            title: l10n.operatorSectionAccount,
            subtitle: l10n.operatorSectionAccountHint,
            trailing: OutlinedButton.icon(
              onPressed: isSubmitting ? null : onGenerateCredentials,
              icon: const Icon(Icons.vpn_key_outlined, size: 18),
              label: Text(l10n.operatorGenerateCredentials),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ResponsiveFormGrid(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.username],
                      decoration: InputDecoration(
                        labelText: l10n.loginEmailLabel,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      validationMessages: {
                        'emailInvalid': (_) => l10n.loginEmailInvalid,
                      },
                    ),
                    ReactiveDropdownField<String?>(
                      formControlName: 'groupId',
                      decoration: InputDecoration(
                        labelText: l10n.staffTableFilterGroup,
                        prefixIcon: const Icon(Icons.groups_outlined),
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text(l10n.staffTableFilterAll),
                        ),
                        ...groups.map(
                          (group) => DropdownMenuItem(
                            value: group.id,
                            child: Text(group.name),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (generatedPassword != null) ...[
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.success.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.success,
                          size: 18,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            l10n.operatorGeneratedPasswordPreview(
                              generatedPassword!,
                            ),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.folder_open_outlined,
            title: l10n.operatorDocumentsSection,
            subtitle: l10n.operatorSectionDocumentsHint,
            child: Semantics(
              button: true,
              label: l10n.operatorPickDocuments(pickedCount),
              enabled: !isSubmitting,
              child: OutlinedButton.icon(
                onPressed: isSubmitting ? null : onPickFiles,
                style: OutlinedButton.styleFrom(
                  minimumSize: Size.fromHeight(48.h),
                  alignment: Alignment.center,
                ),
                icon: const Icon(Icons.upload_file_outlined),
                label: Text(l10n.operatorPickDocuments(pickedCount)),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          PilgrimFieldsForm(enabled: !isSubmitting),
          if (!AppPlatform.isWeb) ...[
            SizedBox(height: 24.h),
            Align(
              alignment: Alignment.centerLeft,
              child: StaffFormActionButtons(
                primaryLabel: l10n.operatorSubmitPilgrim,
                onPrimary: onSubmit,
                secondaryLabel: l10n.operatorClearForm,
                onSecondary: isSubmitting ? null : onClearForm,
                isLoading: isSubmitting,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
