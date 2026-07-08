import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_group_grant.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_permissions.dart';
import 'package:rafiq_alhajj/features/admin_operators/presentation/providers/admin_operators_providers.dart';
import 'package:rafiq_alhajj/features/admin_operators/presentation/widgets/admin_operator_edit_form.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminOperatorEditScreen extends ConsumerStatefulWidget {
  const AdminOperatorEditScreen({this.operatorId, super.key});

  final String? operatorId;

  @override
  ConsumerState<AdminOperatorEditScreen> createState() =>
      _AdminOperatorEditScreenState();
}

class _AdminOperatorEditScreenState extends ConsumerState<AdminOperatorEditScreen> {
  late final FormGroup _form;

  OperatorPermissions _permissions = const OperatorPermissions();
  final Set<String> _accessGroupIds = {};
  final Set<String> _writeGroupIds = {};
  bool _groupInit = false;
  bool _isActive = true;
  bool _loaded = false;

  bool get _isEditing => widget.operatorId != null;

  String _pageTitle(AppLocalizations l10n) =>
      _isEditing ? l10n.adminOperatorEditTitle : l10n.adminOperatorNewTitle;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'fullName': FormControl<String>(value: '', validators: [Validators.required]),
      'email': FormControl<String>(
        value: '',
        validators: [Validators.required, Validators.delegate(_validateEmailAt)],
      ),
      'password': FormControl<String>(value: ''),
    });
  }

  Map<String, dynamic>? _validateEmailAt(AbstractControl<dynamic> control) {
    final value = control.value as String?;
    if (value != null && value.contains('@')) {
      return null;
    }
    return {'emailInvalid': true};
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _bindOperator(OperatorAccount operator) {
    if (_loaded) {
      return;
    }
    _form.control('fullName').updateValue(operator.fullName);
    _form.control('email').updateValue(operator.email);
    _isActive = operator.isActive;
    _permissions = operator.permissions;
    _accessGroupIds
      ..clear()
      ..addAll(operator.groupAccess.map((g) => g.groupId));
    _writeGroupIds
      ..clear()
      ..addAll(
        operator.groupAccess.where((g) => g.canWrite).map((g) => g.groupId),
      );
    _groupInit = true;
    _loaded = true;
  }

  void _initGroupsForCreate(List<OperatorGroupOption> groups) {
    if (_groupInit) {
      return;
    }
    _groupInit = true;
    for (final group in groups) {
      _accessGroupIds.add(group.id);
      _writeGroupIds.add(group.id);
    }
  }

  String _generatePassword() {
    const chars =
        'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789!@#\$%';
    final random = Random.secure();
    return List.generate(12, (_) => chars[random.nextInt(chars.length)]).join();
  }

  void _generateAndSetPassword() {
    _form.control('password').updateValue(_generatePassword());
  }

  void _cancel() {
    staffNavigateBack(context, fallbackRoute: AppRoutes.adminOperators);
  }

  void _onAccessChanged(String groupId, bool hasAccess) {
    setState(() {
      if (hasAccess) {
        _accessGroupIds.add(groupId);
      } else {
        _accessGroupIds.remove(groupId);
        _writeGroupIds.remove(groupId);
      }
    });
  }

  void _onWriteChanged(String groupId, bool canWrite) {
    setState(() {
      if (canWrite) {
        _writeGroupIds.add(groupId);
      } else {
        _writeGroupIds.remove(groupId);
      }
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
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.dialogCancel),
          ),
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
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }

    final l10n = AppLocalizations.of(context);
    final password = (_form.control('password').value as String? ?? '').trim();
    final input = OperatorEditorInput(
      id: widget.operatorId,
      fullName: _form.control('fullName').value as String,
      email: _form.control('email').value as String,
      password: password.isEmpty ? null : password,
      isActive: _isActive,
      permissions: _permissions,
      groupAccess: [
        for (final id in _accessGroupIds)
          OperatorGroupGrant(groupId: id, canWrite: _writeGroupIds.contains(id)),
      ],
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

  Widget _buildScaffold(
    AppLocalizations l10n,
    bool isSaving,
    AsyncValue<List<OperatorGroupOption>> groupsAsync,
  ) {
    if (!_isEditing) {
      groupsAsync.whenData(_initGroupsForCreate);
    }

    final form = AdminOperatorEditForm(
      form: _form,
      isEditing: _isEditing,
      isActive: _isActive,
      permissions: _permissions,
      accessGroupIds: _accessGroupIds,
      writeGroupIds: _writeGroupIds,
      groups: groupsAsync.asData?.value ?? const [],
      isSaving: isSaving,
      onActiveChanged: (value) => setState(() => _isActive = value),
      onPermissionsChanged: (value) => setState(() => _permissions = value),
      onAccessChanged: _onAccessChanged,
      onWriteChanged: _onWriteChanged,
      onGeneratePassword: _generateAndSetPassword,
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: _pageTitle(l10n),
        body: form,
        bottomBar: StaffFormActionsBar(
          primaryLabel: l10n.adminContentSave,
          onPrimary: _submit,
          secondaryLabel: l10n.dialogCancel,
          onSecondary: isSaving ? null : _cancel,
          isLoading: isSaving,
        ),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(_pageTitle(l10n)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: isSaving ? null : _cancel,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: form,
        ),
        bottomNavigationBar: StaffFormMobileActionsBar(
          primaryLabel: l10n.adminContentSave,
          onPrimary: _submit,
          secondaryLabel: l10n.dialogCancel,
          onSecondary: isSaving ? null : _cancel,
          isLoading: isSaving,
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
    if (isSaving && _form.enabled) {
      _form.markAsDisabled();
    } else if (!isSaving && _form.disabled) {
      _form.markAsEnabled();
    }
    final groupsAsync = ref.watch(adminOperatorGroupOptionsProvider);

    if (_isEditing) {
      final detailAsync =
          ref.watch(adminOperatorDetailProvider(widget.operatorId!));

      return detailAsync.when(
        skipLoadingOnReload: true,
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
        error: (error, _) => StaffAdaptivePage(
          web: StaffWebPage(
            title: _pageTitle(l10n),
            body: StaffErrorView.fromError(
              l10n,
              error: error,
              onRetry: () => ref.invalidate(
                adminOperatorDetailProvider(widget.operatorId!),
              ),
            ),
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(title: Text(_pageTitle(l10n))),
            body: StaffErrorView.fromError(
              l10n,
              error: error,
              onRetry: () => ref.invalidate(
                adminOperatorDetailProvider(widget.operatorId!),
              ),
            ),
          ),
        ),
        data: (operator) {
          _bindOperator(operator);
          return _buildScaffold(l10n, isSaving, groupsAsync);
        },
      );
    }

    return _buildScaffold(l10n, isSaving, groupsAsync);
  }
}
