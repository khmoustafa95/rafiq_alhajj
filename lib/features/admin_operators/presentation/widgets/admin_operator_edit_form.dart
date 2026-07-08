import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_group_grant.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_permissions.dart';
import 'package:rafiq_alhajj/features/admin_operators/presentation/widgets/admin_operator_group_access_section.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminOperatorEditForm extends StatelessWidget {
  const AdminOperatorEditForm({
    required this.form,
    required this.isEditing,
    required this.isActive,
    required this.permissions,
    required this.accessGroupIds,
    required this.writeGroupIds,
    required this.groups,
    required this.isSaving,
    required this.onActiveChanged,
    required this.onPermissionsChanged,
    required this.onAccessChanged,
    required this.onWriteChanged,
    required this.onGeneratePassword,
    super.key,
  });

  final FormGroup form;
  final bool isEditing;
  final bool isActive;
  final OperatorPermissions permissions;
  final Set<String> accessGroupIds;
  final Set<String> writeGroupIds;
  final List<OperatorGroupOption> groups;
  final bool isSaving;
  final ValueChanged<bool> onActiveChanged;
  final ValueChanged<OperatorPermissions> onPermissionsChanged;
  final void Function(String groupId, bool hasAccess) onAccessChanged;
  final void Function(String groupId, bool canWrite) onWriteChanged;
  final VoidCallback onGeneratePassword;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaffFormSection(
            icon: Icons.person_outline_rounded,
            title: l10n.operatorSectionPersonalInfo,
            subtitle: l10n.operatorSectionPersonalInfoHint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ResponsiveFormGrid(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'fullName',
                      decoration: InputDecoration(
                        labelText: l10n.adminOperatorFullName,
                      ),
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            l10n.adminOperatorFullNameRequired,
                      },
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'email',
                      decoration: InputDecoration(
                        labelText: l10n.adminOperatorEmail,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            l10n.adminOperatorEmailRequired,
                        'emailInvalid': (_) => l10n.adminOperatorEmailInvalid,
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: SwitchListTile(
                    title: Text(l10n.adminOperatorActive),
                    value: isActive,
                    onChanged: isSaving ? null : onActiveChanged,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.lock_outline_rounded,
            title: l10n.operatorSectionAccount,
            subtitle: l10n.operatorSectionAccountHint,
            child: ReactiveTextField<String>(
              formControlName: 'password',
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.adminOperatorPasswordLabel,
                helperText: isEditing
                    ? l10n.adminOperatorPasswordEditHint
                    : l10n.adminOperatorPasswordCreateHint,
                suffixIcon: Semantics(
                  button: true,
                  label: l10n.adminOperatorGeneratePassword,
                  enabled: !isSaving,
                  child: IconButton(
                    onPressed: isSaving ? null : onGeneratePassword,
                    tooltip: l10n.adminOperatorGeneratePassword,
                    icon: const Icon(Icons.autorenew_rounded),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.admin_panel_settings_outlined,
            title: l10n.adminOperatorPermissionsSection,
            child: ResponsiveFormGrid(
              children: [
                _permissionSwitch(
                  title: l10n.adminOperatorPermRegister,
                  subtitle: l10n.adminOperatorPermRegisterHint,
                  value: permissions.canRegisterPilgrims,
                  enabled: !isSaving,
                  onChanged: (value) => onPermissionsChanged(
                    permissions.copyWith(canRegisterPilgrims: value),
                  ),
                ),
                _permissionSwitch(
                  title: l10n.adminOperatorPermRegistry,
                  subtitle: l10n.adminOperatorPermRegistryHint,
                  value: permissions.canManagePilgrimRegistry,
                  enabled: !isSaving,
                  onChanged: (value) => onPermissionsChanged(
                    permissions.copyWith(canManagePilgrimRegistry: value),
                  ),
                ),
                _permissionSwitch(
                  title: l10n.adminOperatorPermField,
                  subtitle: l10n.adminOperatorPermFieldHint,
                  value: permissions.canUseFieldTools,
                  enabled: !isSaving,
                  onChanged: (value) => onPermissionsChanged(
                    permissions.copyWith(canUseFieldTools: value),
                  ),
                ),
                _permissionSwitch(
                  title: l10n.adminOperatorPermUpload,
                  subtitle: l10n.adminOperatorPermUploadHint,
                  value: permissions.canUploadDocuments,
                  enabled: !isSaving,
                  onChanged: (value) => onPermissionsChanged(
                    permissions.copyWith(canUploadDocuments: value),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.groups_2_outlined,
            title: l10n.adminOperatorGroupsSection,
            subtitle: l10n.adminOperatorGroupsHint,
            child: AdminOperatorGroupAccessSection(
              groups: groups,
              accessGroupIds: accessGroupIds,
              writeGroupIds: writeGroupIds,
              isSaving: isSaving,
              onAccessChanged: onAccessChanged,
              onWriteChanged: onWriteChanged,
            ),
          ),
        ],
      ),
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
}
