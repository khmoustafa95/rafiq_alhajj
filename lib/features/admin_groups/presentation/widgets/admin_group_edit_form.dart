import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_button_styles.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/admin_groups/presentation/forms/group_member_form_row.dart';
import 'package:rafiq_alhajj/features/admin_groups/presentation/widgets/admin_group_logo_preview.dart';
import 'package:rafiq_alhajj/features/admin_groups/presentation/widgets/admin_group_member_card.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminGroupEditForm extends StatelessWidget {
  const AdminGroupEditForm({
    required this.form,
    required this.logoBytes,
    required this.logoUrl,
    required this.memberRows,
    required this.isSaving,
    required this.onPickLogo,
    required this.onAddMember,
    required this.onPickMemberPhoto,
    required this.onRemoveMember,
    super.key,
  });

  final FormGroup form;
  final Uint8List? logoBytes;
  final String? logoUrl;
  final List<GroupMemberFormRow> memberRows;
  final bool isSaving;
  final VoidCallback onPickLogo;
  final VoidCallback onAddMember;
  final ValueChanged<GroupMemberFormRow> onPickMemberPhoto;
  final ValueChanged<GroupMemberFormRow> onRemoveMember;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ReactiveForm(
      formGroup: form,
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
                    AdminGroupLogoPreview(
                      logoBytes: logoBytes,
                      logoUrl: logoUrl,
                    ),
                    SizedBox(width: sw(16)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Semantics(
                            button: true,
                            label: l10n.adminGroupUploadLogo,
                            enabled: !isSaving,
                            child: OutlinedButton.icon(
                              onPressed: isSaving ? null : onPickLogo,
                              style: staffRowOutlinedButtonStyle(context),
                              icon: const Icon(Icons.upload_outlined, size: 18),
                              label: Text(l10n.adminGroupUploadLogo),
                            ),
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
            trailing: Semantics(
              button: true,
              label: l10n.adminGroupAddMember,
              enabled: !isSaving,
              child: OutlinedButton.icon(
                onPressed: isSaving ? null : onAddMember,
                style: staffRowOutlinedButtonStyle(context),
                icon: const Icon(Icons.person_add_alt_1_outlined, size: 18),
                label: Text(l10n.adminGroupAddMember),
              ),
            ),
            child: memberRows.isEmpty
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
                      for (final row in memberRows) ...[
                        AdminGroupMemberCard(
                          row: row,
                          l10n: l10n,
                          isSaving: isSaving,
                          photoPreview: AdminGroupMemberPhotoPreview(
                            photoBytes: row.photoBytes,
                            photoUrl: row.photoUrl,
                          ),
                          onPickPhoto: () => onPickMemberPhoto(row),
                          onRemove: () => onRemoveMember(row),
                        ),
                        SizedBox(height: sh(12)),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
