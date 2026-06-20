import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_button_styles.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/admin_groups/domain/models/group_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_groups/domain/models/hajj_group.dart';
import 'package:rafiq_alhajj/features/admin_groups/presentation/providers/admin_groups_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class _MemberFormRow {
  _MemberFormRow({
    this.id,
    String? name,
    String? position,
    String? contact,
    this.photoUrl,
  }) {
    form = FormGroup({
      'name': FormControl<String>(value: name),
      'position': FormControl<String>(value: position),
      'contact': FormControl<String>(value: contact),
    });
    nameControl.setValidators([Validators.delegate(_validateName)]);
  }

  final String? id;
  late final FormGroup form;
  String? photoUrl;
  Uint8List? photoBytes;
  String? photoFileName;

  FormControl<String> get nameControl =>
      form.control('name') as FormControl<String>;
  FormControl<String> get positionControl =>
      form.control('position') as FormControl<String>;
  FormControl<String> get contactControl =>
      form.control('contact') as FormControl<String>;

  String get name => nameControl.value ?? '';
  String get position => positionControl.value ?? '';
  String get contact => contactControl.value ?? '';

  Map<String, dynamic>? _validateName(AbstractControl<dynamic> control) {
    final hasContent = position.trim().isNotEmpty ||
        contact.trim().isNotEmpty ||
        photoBytes != null ||
        (photoUrl?.isNotEmpty ?? false);
    if (!hasContent) {
      return null;
    }
    final value = control.value as String?;
    if (value == null || value.trim().isEmpty) {
      return {'memberNameRequired': true};
    }
    return null;
  }

  void dispose() {
    form.dispose();
  }
}

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
  final _memberRows = <_MemberFormRow>[];
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
        (member) => _MemberFormRow(
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

  Future<void> _pickMemberPhoto(_MemberFormRow row) async {
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
    setState(() => _memberRows.add(_MemberFormRow()));
  }

  void _removeMember(_MemberFormRow row) {
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

  Widget _logoPreview() {
    if (_logoBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: Image.memory(_logoBytes!, width: sw(96), height: sh(96), fit: BoxFit.cover),
      );
    }
    if (_logoUrl != null && _logoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: Image.network(
          _logoUrl!,
          width: sw(96),
          height: sh(96),
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _logoPlaceholder(),
        ),
      );
    }
    return _logoPlaceholder();
  }

  Widget _logoPlaceholder() {
    return Container(
      width: sw(96),
      height: sh(96),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(Icons.image_outlined, color: AppColors.textSecondary, size: ss(32)),
    );
  }

  Widget _memberPhotoPreview(_MemberFormRow row) {
    if (row.photoBytes != null) {
      return ClipOval(
        child: Image.memory(row.photoBytes!, width: sw(56), height: sh(56), fit: BoxFit.cover),
      );
    }
    if (row.photoUrl != null && row.photoUrl!.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          row.photoUrl!,
          width: sw(56),
          height: sh(56),
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _memberPhotoPlaceholder(),
        ),
      );
    }
    return _memberPhotoPlaceholder();
  }

  Widget _memberPhotoPlaceholder() {
    return CircleAvatar(
      radius: sr(28),
      backgroundColor: AppColors.primary.withValues(alpha: 0.12),
      child: const Icon(Icons.person_outline, color: AppColors.primary),
    );
  }

  Widget _buildForm(AppLocalizations l10n, bool isSaving) {
    final form = ReactiveForm(
      formGroup: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaffFormSection(
            icon: Icons.groups_outlined,
            title: l10n.adminGroupDetailsSection,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _logoPreview(),
                    SizedBox(width: sw(16)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OutlinedButton.icon(
                            onPressed: isSaving ? null : _pickLogo,
                            style: staffRowOutlinedButtonStyle(context),
                            icon: const Icon(Icons.upload_outlined, size: 18),
                            label: Text(l10n.adminGroupUploadLogo),
                          ),
                          SizedBox(height: sh(12)),
                          ReactiveTextField<String>(
                            formControlName: 'name',
                            decoration: InputDecoration(
                              labelText: l10n.adminGroupName,
                            ),
                            validationMessages: {
                              ValidationMessage.required: (_) =>
                                  l10n.adminGroupNameRequired,
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ResponsiveFormGrid(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'presidentName',
                      decoration: InputDecoration(
                        labelText: l10n.adminGroupPresidentName,
                      ),
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'presidentPhone',
                      decoration: InputDecoration(
                        labelText: l10n.adminGroupPresidentPhone,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.admin_panel_settings_outlined,
            title: l10n.adminGroupMembersSection,
            subtitle: l10n.adminGroupMembersSectionHint,
            trailing: OutlinedButton.icon(
              onPressed: isSaving ? null : _addMember,
              style: staffRowOutlinedButtonStyle(context),
              icon: const Icon(Icons.person_add_alt_1_outlined, size: 18),
              label: Text(l10n.adminGroupAddMember),
            ),
            child: _memberRows.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: sh(8)),
                    child: Text(
                      l10n.adminGroupMembersEmpty,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  )
                : Column(
                    children: [
                      for (final row in _memberRows) ...[
                        _MemberCard(
                          row: row,
                          l10n: l10n,
                          isSaving: isSaving,
                          photoPreview: _memberPhotoPreview(row),
                          onPickPhoto: () => _pickMemberPhoto(row),
                          onRemove: () => _removeMember(row),
                        ),
                        SizedBox(height: sh(12)),
                      ],
                    ],
                  ),
          ),
        ],
      ),
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
          return _buildForm(l10n, isSaving);
        },
      );
    }

    return _buildForm(l10n, isSaving);
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({
    required this.row,
    required this.l10n,
    required this.isSaving,
    required this.photoPreview,
    required this.onPickPhoto,
    required this.onRemove,
  });

  final _MemberFormRow row;
  final AppLocalizations l10n;
  final bool isSaving;
  final Widget photoPreview;
  final VoidCallback onPickPhoto;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppDecorations.card(),
      child: Padding(
        padding: EdgeInsets.all(sw(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                photoPreview,
                SizedBox(width: sw(12)),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isSaving ? null : onPickPhoto,
                    style: staffRowOutlinedButtonStyle(context),
                    icon: const Icon(Icons.photo_camera_outlined, size: 18),
                    label: Text(l10n.adminGroupUploadPhoto),
                  ),
                ),
                IconButton(
                  onPressed: isSaving ? null : onRemove,
                  icon: const Icon(Icons.delete_outline),
                  tooltip: l10n.adminGroupRemoveMember,
                ),
              ],
            ),
            SizedBox(height: sh(12)),
            ReactiveForm(
              formGroup: row.form,
              child: ResponsiveFormGrid(
                children: [
                  ReactiveTextField<String>(
                    formControlName: 'name',
                    decoration: InputDecoration(
                      labelText: l10n.adminGroupMemberName,
                    ),
                    validationMessages: {
                      'memberNameRequired': (_) =>
                          l10n.adminGroupMemberNameRequired,
                    },
                  ),
                  ReactiveTextField<String>(
                    formControlName: 'position',
                    decoration: InputDecoration(
                      labelText: l10n.adminGroupMemberPosition,
                    ),
                  ),
                  ReactiveTextField<String>(
                    formControlName: 'contact',
                    decoration: InputDecoration(
                      labelText: l10n.adminGroupMemberContact,
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
