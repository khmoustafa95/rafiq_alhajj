import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/utils/staff_error_message.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_bell_button.dart';
import 'package:rafiq_alhajj/features/operator_intake/application/utils/credential_generator.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_intake_form.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_intake_providers.dart';
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
  DateTime? _travelDate;
  String? _generatedPassword;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'fullName': FormControl<String>(value: '', validators: [Validators.required]),
      'email': FormControl<String>(
        value: '',
        validators: [Validators.delegate(_validateEmail)],
      ),
      'passport': FormControl<String>(value: ''),
      'permit': FormControl<String>(value: ''),
      'medical': FormControl<String>(value: ''),
      'hotel': FormControl<String>(value: ''),
      'hotelUrl': FormControl<String>(value: ''),
      'transport': FormControl<String>(value: ''),
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

  Future<void> _pickTravelDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: _travelDate ?? DateTime.now(),
    );
    if (picked != null) {
      setState(() => _travelDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }

    final l10n = AppLocalizations.of(context);
    final form = PilgrimIntakeForm(
      fullName: _form.control('fullName').value as String,
      email: _form.control('email').value as String,
      passportNumber: _emptyToNull(_form.control('passport').value as String? ?? ''),
      travelPermitNumber: _emptyToNull(_form.control('permit').value as String? ?? ''),
      medicalTestStatus: _emptyToNull(_form.control('medical').value as String? ?? ''),
      travelDate: _travelDate,
      hotelName: _emptyToNull(_form.control('hotel').value as String? ?? ''),
      hotelLocationUrl: _emptyToNull(_form.control('hotelUrl').value as String? ?? ''),
      transportationDetails:
          _emptyToNull(_form.control('transport').value as String? ?? ''),
    );

    final created =
        await ref.read(operatorIntakeControllerProvider.notifier).submit(form);

    if (!mounted) {
      return;
    }

    if (created != null) {
      _showCredentialsDialog(created.email, created.password);
      _clearForm();
    } else if (ref.read(operatorIntakeControllerProvider).hasError) {
      final error = ref.read(operatorIntakeControllerProvider).error!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(staffErrorMessage(l10n, error))),
      );
    }
  }

  String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  void _clearForm() {
    _form.reset();
    setState(() {
      _travelDate = null;
      _generatedPassword = null;
    });
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
              _CredentialRow(label: l10n.loginEmailLabel, value: email),
              SizedBox(height: 12.h),
              _CredentialRow(label: l10n.loginPasswordLabel, value: password),
            ],
          ),
          actions: [
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

    final formContent = ReactiveForm(
      formGroup: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaffFormSection(
            icon: Icons.person_outline,
            title: l10n.operatorSectionPersonalInfo,
            subtitle: l10n.operatorSectionPersonalInfoHint,
            child: ResponsiveFormGrid(
              children: [
                ReactiveTextField<String>(
                  formControlName: 'fullName',
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.operatorFullName,
                    prefixIcon: const Icon(Icons.badge_outlined),
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) => l10n.operatorRequired,
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.smartphone_outlined,
            title: l10n.operatorSectionAccount,
            subtitle: l10n.operatorSectionAccountHint,
            trailing: OutlinedButton.icon(
              onPressed: isSubmitting ? null : _generateCredentials,
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
                  ],
                ),
                if (_generatedPassword != null) ...[
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
                        const Icon(Icons.info_outline, color: AppColors.success, size: 18),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            l10n.operatorGeneratedPasswordPreview(_generatedPassword!),
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
            child: OutlinedButton.icon(
              onPressed: isSubmitting ? null : _pickFiles,
              style: OutlinedButton.styleFrom(
                minimumSize: Size.fromHeight(48.h),
                alignment: Alignment.center,
              ),
              icon: const Icon(Icons.upload_file_outlined),
              label: Text(l10n.operatorPickDocuments(pickedCount)),
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.flight_takeoff_outlined,
            title: l10n.pilgrimLogisticsTitle,
            subtitle: l10n.operatorSectionLogisticsHint,
            child: ResponsiveFormGrid(
              maxColumns: 3,
              children: [
                ReactiveTextField<String>(
                  formControlName: 'passport',
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.operatorPassport,
                    prefixIcon: const Icon(Icons.credit_card_outlined),
                  ),
                ),
                ReactiveTextField<String>(
                  formControlName: 'permit',
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.operatorTravelPermit,
                    prefixIcon: const Icon(Icons.assignment_outlined),
                  ),
                ),
                ReactiveTextField<String>(
                  formControlName: 'medical',
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.pilgrimMedicalStatus,
                    prefixIcon: const Icon(Icons.medical_services_outlined),
                  ),
                ),
                StaffDateFormField(
                  label: l10n.pilgrimTravelDate,
                  value: _travelDate,
                  unsetLabel: l10n.operatorPickDate,
                  onPick: _pickTravelDate,
                  enabled: !isSubmitting,
                ),
                ReactiveTextField<String>(
                  formControlName: 'hotel',
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.pilgrimHotel,
                    prefixIcon: const Icon(Icons.hotel_outlined),
                  ),
                ),
                ReactiveTextField<String>(
                  formControlName: 'hotelUrl',
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.operatorHotelMapUrl,
                    prefixIcon: const Icon(Icons.map_outlined),
                  ),
                ),
                ReactiveTextField<String>(
                  formControlName: 'transport',
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: l10n.pilgrimTransport,
                    prefixIcon: const Icon(Icons.directions_bus_outlined),
                  ),
                ),
              ],
            ),
          ),
          if (!AppPlatform.isWeb) ...[
            SizedBox(height: 24.h),
            Align(
              alignment: Alignment.centerLeft,
              child: StaffFormActionButtons(
                primaryLabel: l10n.operatorSubmitPilgrim,
                onPrimary: _submit,
                secondaryLabel: l10n.operatorClearForm,
                onSecondary: isSubmitting ? null : _clearForm,
                isLoading: isSubmitting,
              ),
            ),
          ],
        ],
      ),
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

class _CredentialRow extends StatelessWidget {
  const _CredentialRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        SizedBox(height: 4.h),
        SelectableText(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
