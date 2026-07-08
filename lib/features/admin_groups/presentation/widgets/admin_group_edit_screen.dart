import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/admin_groups/domain/models/group_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_groups/domain/models/hajj_group.dart';
import 'package:rafiq_alhajj/features/admin_groups/presentation/forms/group_member_form_row.dart';
import 'package:rafiq_alhajj/features/admin_groups/presentation/providers/admin_groups_providers.dart';
import 'package:rafiq_alhajj/features/admin_groups/presentation/widgets/admin_group_edit_form.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminGroupEditScreen extends ConsumerStatefulWidget {
  const AdminGroupEditScreen({this.groupId, super.key});

  final String? groupId;

  @override
  ConsumerState<AdminGroupEditScreen> createState() =>
      _AdminGroupEditScreenState();
}

class _AdminGroupEditScreenState extends ConsumerState<AdminGroupEditScreen> {
  late final FormGroup _form;

  String? _logoUrl;
  Uint8List? _logoBytes;
  String? _logoFileName;
  final _memberRows = <GroupMemberFormRow>[];
  bool _loaded = false;

  bool get _isEditing => widget.groupId != null;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'name': FormControl<String>(value: '', validators: [Validators.required]),
      'presidentName': FormControl<String>(value: ''),
      'presidentPhone': FormControl<String>(value: ''),
    });
  }

  void _syncEnabled(bool isSaving) {
    if (isSaving) {
      if (_form.enabled) {
        _form.markAsDisabled();
      }
      for (final row in _memberRows) {
        if (row.form.enabled) {
          row.form.markAsDisabled();
        }
      }
    } else {
      if (_form.disabled) {
        _form.markAsEnabled();
      }
      for (final row in _memberRows) {
        if (row.form.disabled) {
          row.form.markAsEnabled();
        }
      }
    }
  }

  @override
  void dispose() {
    _form.dispose();
    for (final row in _memberRows) {
      row.dispose();
    }
    super.dispose();
  }

  void _bindGroup(HajjGroup group) {
    if (_loaded) {
      return;
    }
    _form.control('name').updateValue(group.name);
    _form.control('presidentName').updateValue(group.presidentName ?? '');
    _form.control('presidentPhone').updateValue(group.presidentPhone ?? '');
    _logoUrl = group.logoUrl;
    _memberRows.addAll(
      group.members.map(
        (member) => GroupMemberFormRow(
          id: member.id,
          name: member.name,
          position: member.position,
          contact: member.contact,
          photoUrl: member.photoUrl,
        ),
      ),
    );
    _loaded = true;
  }

  Future<void> _pickLogo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    final file = result?.files.firstOrNull;
    if (file?.bytes == null) {
      return;
    }
    setState(() {
      _logoBytes = file!.bytes;
      _logoFileName = file.name;
    });
  }

  Future<void> _pickMemberPhoto(GroupMemberFormRow row) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    final file = result?.files.firstOrNull;
    if (file?.bytes == null) {
      return;
    }
    setState(() {
      row.photoBytes = file!.bytes;
      row.photoFileName = file.name;
      row.photoUrl = null;
    });
  }

  void _addMember() {
    setState(() => _memberRows.add(GroupMemberFormRow()));
  }

  void _removeMember(GroupMemberFormRow row) {
    setState(() {
      row.dispose();
      _memberRows.remove(row);
    });
  }

  void _cancel() {
    staffNavigateBack(context, fallbackRoute: AppRoutes.adminGroups);
  }

  Future<void> _submit() async {
    for (final row in _memberRows) {
      row.nameControl.updateValueAndValidity();
    }
    final membersValid = _memberRows.every((row) => row.form.valid);
    if (!_form.valid || !membersValid) {
      _form.markAllAsTouched();
      for (final row in _memberRows) {
        row.form.markAllAsTouched();
      }
      return;
    }

    final l10n = AppLocalizations.of(context);
    final input = GroupEditorInput(
      id: widget.groupId,
      name: _form.control('name').value as String,
      logoUrl: _logoUrl,
      logoBytes: _logoBytes,
      logoFileName: _logoFileName,
      presidentName: _form.control('presidentName').value as String? ?? '',
      presidentPhone: _form.control('presidentPhone').value as String? ?? '',
      members: [
        for (var i = 0; i < _memberRows.length; i++)
          GroupMemberEditorInput(
            id: _memberRows[i].id,
            name: _memberRows[i].name,
            position: _memberRows[i].position,
            contact: _memberRows[i].contact,
            photoUrl: _memberRows[i].photoUrl,
            photoBytes: _memberRows[i].photoBytes,
            photoFileName: _memberRows[i].photoFileName,
            sortOrder: i,
          ),
      ],
    );

    final ok = await ref.read(adminGroupSaveProvider.notifier).save(input);

    if (!mounted) {
      return;
    }

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? l10n.adminGroupSaveSuccess
                : l10n.adminGroupCreateSuccess,
          ),
        ),
      );
      context.go(AppRoutes.adminGroups);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.adminGroupSaveError)),
    );
  }

  Widget _buildScaffold(AppLocalizations l10n, bool isSaving) {
    final form = AdminGroupEditForm(
      form: _form,
      logoBytes: _logoBytes,
      logoUrl: _logoUrl,
      memberRows: _memberRows,
      isSaving: isSaving,
      onPickLogo: _pickLogo,
      onAddMember: _addMember,
      onPickMemberPhoto: _pickMemberPhoto,
      onRemoveMember: _removeMember,
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: _isEditing ? l10n.adminGroupEditTitle : l10n.adminGroupNewTitle,
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
          title: Text(
            _isEditing ? l10n.adminGroupEditTitle : l10n.adminGroupNewTitle,
          ),
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
      adminGroupSaveProvider.select((state) => state.isLoading),
    );
    _syncEnabled(isSaving);

    if (_isEditing) {
      final detailAsync = ref.watch(adminGroupDetailProvider(widget.groupId!));
      return detailAsync.when(
        skipLoadingOnReload: true,
        loading: () => StaffAdaptivePage(
          web: StaffWebPage(
            title: l10n.adminGroupEditTitle,
            body: const Center(child: CircularProgressIndicator()),
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(title: Text(l10n.adminGroupEditTitle)),
            body: const Center(child: CircularProgressIndicator()),
          ),
        ),
        error: (error, _) => StaffAdaptivePage(
          web: StaffWebPage(
            title: l10n.adminGroupEditTitle,
            body: StaffErrorView.fromError(
              l10n,
              error: error,
              onRetry: () =>
                  ref.invalidate(adminGroupDetailProvider(widget.groupId!)),
            ),
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(title: Text(l10n.adminGroupEditTitle)),
            body: StaffErrorView.fromError(
              l10n,
              error: error,
              onRetry: () =>
                  ref.invalidate(adminGroupDetailProvider(widget.groupId!)),
            ),
          ),
        ),
        data: (group) {
          _bindGroup(group);
          return _buildScaffold(l10n, isSaving);
        },
      );
    }

    return _buildScaffold(l10n, isSaving);
  }
}
