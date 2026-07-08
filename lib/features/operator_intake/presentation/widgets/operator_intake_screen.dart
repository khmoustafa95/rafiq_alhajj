import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/utils/staff_error_message.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_bell_button.dart';
import 'package:rafiq_alhajj/features/operator_intake/application/utils/credential_generator.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_intake_form.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/forms/pilgrim_field_catalog.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_intake_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/pilgrim_shared_defaults_provider.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_intake_credential_row.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_intake_form.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OperatorIntakeScreen extends ConsumerStatefulWidget {
  const OperatorIntakeScreen({super.key});

  @override
  ConsumerState<OperatorIntakeScreen> createState() =>
      _OperatorIntakeScreenState();
}

class _OperatorIntakeScreenState extends ConsumerState<OperatorIntakeScreen> {
  late final FormGroup _form;
  String? _generatedPassword;
  bool _defaultsApplied = false;

  @override
  void initState() {
    super.initState();
    _form = PilgrimFormCatalog.buildFormGroup()
      ..addAll({
        'email': FormControl<String>(
          value: '',
          validators: [Validators.delegate(_validateEmail)],
        ),
        'groupId': FormControl<String?>(),
      });
  }

  Map<String, dynamic>? _validateEmail(AbstractControl<dynamic> control) {
    final value = control.value as String?;
    return (value == null || !value.contains('@'))
        ? {'emailInvalid': true}
        : null;
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _generateCredentials() {
    _form.control('email').updateValue(CredentialGenerator.generateDemoEmail());
    setState(() {
      _generatedPassword = CredentialGenerator.generatePassword();
    });
  }

  Future<void> _pickFiles() async {
    await ref.read(operatorIntakeControllerProvider.notifier).pickDocuments();
    setState(() {});
  }

  Future<void> _submit() async {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }

    final l10n = AppLocalizations.of(context);
    final person = PilgrimFormCatalog.payload(_form, PilgrimFieldTable.person);
    final enrollment =
        PilgrimFormCatalog.payload(_form, PilgrimFieldTable.enrollment);

    final form = PilgrimIntakeForm(
      fullName: (person['full_name_ar'] as String?) ?? '',
      email: _form.control('email').value as String,
      groupId: _form.control('groupId').value as String?,
      person: person,
      enrollment: enrollment,
    );

    await ref
        .read(pilgrimSharedDefaultsProvider.notifier)
        .setAll(PilgrimFormCatalog.sharedValues(_form));

    final created =
        await ref.read(operatorIntakeControllerProvider.notifier).submit(form);

    if (!mounted) {
      return;
    }

    if (created != null) {
      final uploadError =
          ref.read(operatorIntakeControllerProvider.notifier).lastUploadError;
      if (uploadError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.operatorDocumentsUploadFailed)),
        );
      }
      _showCredentialsDialog(created.email, created.password);
      _clearForm();
    } else if (ref.read(operatorIntakeControllerProvider).hasError) {
      final error = ref.read(operatorIntakeControllerProvider).error!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(staffErrorMessage(l10n, error))),
      );
    }
  }

  void _clearForm() {
    final defaults = ref.read(pilgrimSharedDefaultsProvider);
    _form.reset();
    PilgrimFormCatalog.applyShared(_form, defaults);
    setState(() {
      _generatedPassword = null;
    });
  }

  Future<void> _clearSharedDefaults() async {
    await ref.read(pilgrimSharedDefaultsProvider.notifier).clear();
    for (final key in PilgrimFormCatalog.sharedKeys) {
      _form.control(key).reset();
    }
  }

  void _showCredentialsDialog(String email, String password) {
    final l10n = AppLocalizations.of(context);
    unawaited(
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.check_circle_outline, color: AppColors.success),
          title: Text(l10n.operatorAccountCreatedTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OperatorIntakeCredentialRow(
                label: l10n.loginEmailLabel,
                value: email,
              ),
              SizedBox(height: 12.h),
              OperatorIntakeCredentialRow(
                label: l10n.loginPasswordLabel,
                value: password,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.dialogCancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.operatorCloseDialog),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isSubmitting = ref.watch(
      operatorIntakeControllerProvider.select((state) => state.isLoading),
    );
    final controller = ref.read(operatorIntakeControllerProvider.notifier);
    final pickedCount = controller.pickedFiles.length;
    final groupsAsync = ref.watch(pilgrimGroupFilterOptionsProvider);
    final groups = groupsAsync.value ?? const <PilgrimGroupOption>[];

    ref.listen(pilgrimSharedDefaultsProvider, (previous, next) {
      if (!_defaultsApplied && next.isNotEmpty) {
        PilgrimFormCatalog.applyShared(_form, next);
        _defaultsApplied = true;
      }
    });

    final formContent = OperatorIntakeForm(
      form: _form,
      isSubmitting: isSubmitting,
      generatedPassword: _generatedPassword,
      pickedCount: pickedCount,
      groups: groups,
      onClearSharedDefaults: _clearSharedDefaults,
      onGenerateCredentials: _generateCredentials,
      onPickFiles: _pickFiles,
      onSubmit: _submit,
      onClearForm: _clearForm,
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.operatorIntakeTitle,
        subtitle: l10n.operatorIntakeSubtitle,
        body: formContent,
        bottomBar: StaffFormActionsBar(
          primaryLabel: l10n.operatorSubmitPilgrim,
          onPrimary: _submit,
          secondaryLabel: l10n.operatorClearForm,
          onSecondary: isSubmitting ? null : _clearForm,
          isLoading: isSubmitting,
        ),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.operatorIntakeTitle),
          actions: [
            const NotificationBellButton(),
            IconButton(
              onPressed: () =>
                  ref.read(signOutControllerProvider.notifier).signOut(),
              icon: const Icon(Icons.logout),
              tooltip: l10n.signOut,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: formContent,
        ),
      ),
    );
  }
}
