import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
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
          title: Text(l10n.operatorAccountCreatedTitle),
          content: SelectableText(
            '${l10n.loginEmailLabel}: $email\n${l10n.loginPasswordLabel}: $password',
          ),
          actions: [
            TextButton(
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
    final intakeState = ref.watch(operatorIntakeControllerProvider);
    final controller = ref.read(operatorIntakeControllerProvider.notifier);
    final pickedCount = controller.pickedFiles.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.operatorIntakeTitle),
        actions: [
          const NotificationBellButton(),
          IconButton(
            onPressed: () => unawaited(context.push(AppRoutes.operatorPilgrims)),
            icon: const Icon(Icons.groups_outlined),
            tooltip: l10n.operatorPilgrimListTitle,
          ),
          IconButton(
            onPressed: () =>
                ref.read(signOutControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
            tooltip: l10n.signOut,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(24.w),
          children: [
            Text(
              l10n.operatorIntakeSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 24.h),
            Wrap(
              spacing: 16.w,
              runSpacing: 16.h,
              children: [
                SizedBox(
                  width: 320.w,
                  child: TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(labelText: l10n.operatorFullName),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? l10n.operatorRequired : null,
                  ),
                ),
                SizedBox(
                  width: 320.w,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: l10n.loginEmailLabel),
                    validator: (v) =>
                        v == null || !v.contains('@') ? l10n.loginEmailInvalid : null,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: _generateCredentials,
                  icon: const Icon(Icons.vpn_key_outlined),
                  label: Text(l10n.operatorGenerateCredentials),
                ),
              ],
            ),
            if (_generatedPassword != null) ...[
              SizedBox(height: 8.h),
              Text(
                l10n.operatorGeneratedPasswordPreview(_generatedPassword!),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            SizedBox(height: 24.h),
            Text(l10n.operatorDocumentsSection, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8.h),
            OutlinedButton.icon(
              onPressed: _pickFiles,
              icon: const Icon(Icons.upload_file),
              label: Text(l10n.operatorPickDocuments(pickedCount)),
            ),
            SizedBox(height: 24.h),
            Text(l10n.pilgrimLogisticsTitle, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 16.w,
              runSpacing: 16.h,
              children: [
                _field(_passportController, l10n.operatorPassport, 280.w),
                _field(_permitController, l10n.operatorTravelPermit, 280.w),
                _field(_medicalController, l10n.pilgrimMedicalStatus, 280.w),
                SizedBox(
                  width: 280.w,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.pilgrimTravelDate),
                    subtitle: Text(
                      _travelDate == null
                          ? l10n.operatorPickDate
                          : MaterialLocalizations.of(context)
                              .formatMediumDate(_travelDate!),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2030),
                          initialDate: _travelDate ?? DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() => _travelDate = picked);
                        }
                      },
                    ),
                  ),
                ),
                _field(_hotelController, l10n.pilgrimHotel, 280.w),
                _field(_hotelUrlController, l10n.operatorHotelMapUrl, 280.w),
                SizedBox(
                  width: 600.w,
                  child: _field(_transportController, l10n.pilgrimTransport, 600.w),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            FilledButton(
              onPressed: intakeState.isLoading ? null : _submit,
              child: intakeState.isLoading
                  ? const CircularProgressIndicator()
                  : Text(l10n.operatorSubmitPilgrim),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController controller, String label, double width) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
