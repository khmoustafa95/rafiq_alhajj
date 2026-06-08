import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_bell_button.dart';
import 'package:rafiq_alhajj/features/operator_intake/application/utils/credential_generator.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_intake_form.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_intake_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class OperatorIntakeScreen extends ConsumerStatefulWidget {
  const OperatorIntakeScreen({super.key});

  @override
  ConsumerState<OperatorIntakeScreen> createState() =>
      _OperatorIntakeScreenState();
}

class _OperatorIntakeScreenState extends ConsumerState<OperatorIntakeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passportController = TextEditingController();
  final _permitController = TextEditingController();
  final _medicalController = TextEditingController();
  final _hotelController = TextEditingController();
  final _hotelUrlController = TextEditingController();
  final _transportController = TextEditingController();
  DateTime? _travelDate;
  String? _generatedPassword;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passportController.dispose();
    _permitController.dispose();
    _medicalController.dispose();
    _hotelController.dispose();
    _hotelUrlController.dispose();
    _transportController.dispose();
    super.dispose();
  }

  void _generateCredentials() {
    setState(() {
      _emailController.text = CredentialGenerator.generateDemoEmail();
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final form = PilgrimIntakeForm(
      fullName: _fullNameController.text,
      email: _emailController.text,
      passportNumber: _emptyToNull(_passportController.text),
      travelPermitNumber: _emptyToNull(_permitController.text),
      medicalTestStatus: _emptyToNull(_medicalController.text),
      travelDate: _travelDate,
      hotelName: _emptyToNull(_hotelController.text),
      hotelLocationUrl: _emptyToNull(_hotelUrlController.text),
      transportationDetails: _emptyToNull(_transportController.text),
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
      final error = ref.read(operatorIntakeControllerProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _fullNameController.clear();
    _emailController.clear();
    _passportController.clear();
    _permitController.clear();
    _medicalController.clear();
    _hotelController.clear();
    _hotelUrlController.clear();
    _transportController.clear();
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

    final formContent = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaffFormSection(
            icon: Icons.person_outline,
            title: l10n.operatorSectionPersonalInfo,
            subtitle: l10n.operatorSectionPersonalInfoHint,
            child: ResponsiveFormGrid(
              children: [
                TextFormField(
                  controller: _fullNameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.operatorFullName,
                    prefixIcon: const Icon(Icons.badge_outlined),
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? l10n.operatorRequired
                      : null,
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
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.username],
                      decoration: InputDecoration(
                        labelText: l10n.loginEmailLabel,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      validator: (v) =>
                          v == null || !v.contains('@') ? l10n.loginEmailInvalid : null,
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
                TextFormField(
                  controller: _passportController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.operatorPassport,
                    prefixIcon: const Icon(Icons.credit_card_outlined),
                  ),
                ),
                TextFormField(
                  controller: _permitController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.operatorTravelPermit,
                    prefixIcon: const Icon(Icons.assignment_outlined),
                  ),
                ),
                TextFormField(
                  controller: _medicalController,
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
                TextFormField(
                  controller: _hotelController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.pilgrimHotel,
                    prefixIcon: const Icon(Icons.hotel_outlined),
                  ),
                ),
                TextFormField(
                  controller: _hotelUrlController,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: l10n.operatorHotelMapUrl,
                    prefixIcon: const Icon(Icons.map_outlined),
                  ),
                ),
                TextFormField(
                  controller: _transportController,
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
            FilledButton(
              onPressed: isSubmitting ? null : _submit,
              style: FilledButton.styleFrom(minimumSize: Size.fromHeight(48.h)),
              child: isSubmitting
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.operatorSubmitPilgrim),
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
