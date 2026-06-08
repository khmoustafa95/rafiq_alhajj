import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_button_styles.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_permissions.dart';
import 'package:rafiq_alhajj/features/admin_operators/presentation/providers/admin_operators_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminOperatorEditScreen extends ConsumerStatefulWidget {
  const AdminOperatorEditScreen({this.operatorId, super.key});

  final String? operatorId;

  @override
  ConsumerState<AdminOperatorEditScreen> createState() =>
      _AdminOperatorEditScreenState();
}

class _AdminOperatorEditScreenState extends ConsumerState<AdminOperatorEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  OperatorPermissions _permissions = const OperatorPermissions();
  bool _isActive = true;
  bool _loaded = false;

  bool get _isEditing => widget.operatorId != null;

  String _pageTitle(AppLocalizations l10n) =>
      _isEditing ? l10n.adminOperatorEditTitle : l10n.adminOperatorNewTitle;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _bindOperator(OperatorAccount operator) {
    if (_loaded) {
      return;
    }
    _fullNameController.text = operator.fullName;
    _emailController.text = operator.email;
    _isActive = operator.isActive;
    _permissions = operator.permissions;
    _loaded = true;
  }

  String _generatePassword() {
    const chars =
        'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#\$%';
    final random = Random.secure();
    return List.generate(12, (_) => chars[random.nextInt(chars.length)]).join();
  }

  void _generateAndSetPassword() {
    setState(() {
      _passwordController.text = _generatePassword();
    });
  }

  Future<void> _showCreatedDialog(String email, String password) async {
    final l10n = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminOperatorCreateSuccess),
        content: SelectableText(
          '${l10n.operatorSectionAccount}\n$email\n${l10n.adminOperatorPasswordLabel}: $password',
        ),
        actions: [
          TextButton(
            onPressed: () {
              unawaited(Clipboard.setData(ClipboardData(text: password)));
              Navigator.pop(ctx);
            },
            child: Text(l10n.adminOperatorCopyPassword),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.operatorCloseDialog),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final input = OperatorEditorInput(
      id: widget.operatorId,
      fullName: _fullNameController.text,
      email: _emailController.text,
      password: _passwordController.text.trim().isEmpty
          ? null
          : _passwordController.text.trim(),
      isActive: _isActive,
      permissions: _permissions,
    );

    if (_isEditing) {
      final ok =
          await ref.read(adminOperatorSaveProvider.notifier).saveExisting(input);

      if (!mounted) {
        return;
      }

      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.adminOperatorSaveSuccess)),
        );
        context.go(AppRoutes.adminOperators);
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminOperatorSaveError)),
      );
      return;
    }

    final created =
        await ref.read(adminOperatorSaveProvider.notifier).create(input);

    if (!mounted) {
      return;
    }

    if (created != null) {
      await _showCreatedDialog(created.email, created.password);
      if (!mounted) {
        return;
      }
      context.go(AppRoutes.adminOperators);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.adminOperatorSaveError)),
    );
  }

  Widget _permissionSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool enabled,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: enabled ? onChanged : null,
    );
  }

  Widget _buildForm(AppLocalizations l10n, bool isSaving) {
    final form = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaffFormSection(
            icon: Icons.person_outline_rounded,
            title: l10n.operatorSectionPersonalInfo,
            subtitle: l10n.operatorSectionPersonalInfoHint,
            child: ResponsiveFormGrid(
              children: [
                TextFormField(
                  controller: _fullNameController,
                  enabled: !isSaving,
                  decoration: InputDecoration(
                    labelText: l10n.adminOperatorFullName,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.adminOperatorFullNameRequired;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  enabled: !isSaving,
                  decoration: InputDecoration(
                    labelText: l10n.adminOperatorEmail,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.adminOperatorEmailRequired;
                    }
                    if (!value.contains('@')) {
                      return l10n.adminOperatorEmailInvalid;
                    }
                    return null;
                  },
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.adminOperatorActive),
                  value: _isActive,
                  onChanged: isSaving
                      ? null
                      : (value) => setState(() => _isActive = value),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.lock_outline_rounded,
            title: l10n.operatorSectionAccount,
            subtitle: l10n.operatorSectionAccountHint,
            trailing: OutlinedButton(
              onPressed: isSaving ? null : _generateAndSetPassword,
              style: staffRowOutlinedButtonStyle(context),
              child: Text(l10n.adminOperatorGeneratePassword),
            ),
            child: TextFormField(
              controller: _passwordController,
              enabled: !isSaving,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.adminOperatorPasswordLabel,
                helperText: _isEditing
                    ? l10n.adminOperatorPasswordEditHint
                    : l10n.adminOperatorPasswordCreateHint,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.admin_panel_settings_outlined,
            title: l10n.adminOperatorPermissionsSection,
            child: Column(
              children: [
                _permissionSwitch(
                  title: l10n.adminOperatorPermRegister,
                  subtitle: l10n.adminOperatorPermRegisterHint,
                  value: _permissions.canRegisterPilgrims,
                  enabled: !isSaving,
                  onChanged: (value) => setState(
                    () => _permissions = _permissions.copyWith(
                      canRegisterPilgrims: value,
                    ),
                  ),
                ),
                _permissionSwitch(
                  title: l10n.adminOperatorPermRegistry,
                  subtitle: l10n.adminOperatorPermRegistryHint,
                  value: _permissions.canManagePilgrimRegistry,
                  enabled: !isSaving,
                  onChanged: (value) => setState(
                    () => _permissions = _permissions.copyWith(
                      canManagePilgrimRegistry: value,
                    ),
                  ),
                ),
                _permissionSwitch(
                  title: l10n.adminOperatorPermField,
                  subtitle: l10n.adminOperatorPermFieldHint,
                  value: _permissions.canUseFieldTools,
                  enabled: !isSaving,
                  onChanged: (value) => setState(
                    () => _permissions = _permissions.copyWith(
                      canUseFieldTools: value,
                    ),
                  ),
                ),
                _permissionSwitch(
                  title: l10n.adminOperatorPermUpload,
                  subtitle: l10n.adminOperatorPermUploadHint,
                  value: _permissions.canUploadDocuments,
                  enabled: !isSaving,
                  onChanged: (value) => setState(
                    () => _permissions = _permissions.copyWith(
                      canUploadDocuments: value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: _pageTitle(l10n),
        body: form,
        bottomBar: StaffFormActionsBar(
          primaryLabel: l10n.adminContentSave,
          onPrimary: _submit,
          secondaryLabel: l10n.dialogCancel,
          onSecondary: isSaving ? null : () => context.go(AppRoutes.adminOperators),
          isLoading: isSaving,
        ),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(_pageTitle(l10n)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: isSaving ? null : () => context.pop(),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: form,
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: FilledButton(
              onPressed: isSaving ? null : _submit,
              child: isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.adminContentSave),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isSaving = ref.watch(
      adminOperatorSaveProvider.select((state) => state.isLoading),
    );

    if (_isEditing) {
      final detailAsync =
          ref.watch(adminOperatorDetailProvider(widget.operatorId!));

      return detailAsync.when(
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
            body: StaffEmptyState(message: l10n.adminOperatorLoadError),
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(title: Text(_pageTitle(l10n))),
            body: Center(child: Text(l10n.adminOperatorLoadError)),
          ),
        ),
        data: (operator) {
          _bindOperator(operator);
          return _buildForm(l10n, isSaving);
        },
      );
    }

    return _buildForm(l10n, isSaving);
  }
}
