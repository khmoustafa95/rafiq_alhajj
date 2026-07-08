import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_button_styles.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/admin_groups/presentation/forms/group_member_form_row.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminGroupMemberCard extends StatelessWidget {
  const AdminGroupMemberCard({
    required this.row,
    required this.l10n,
    required this.isSaving,
    required this.photoPreview,
    required this.onPickPhoto,
    required this.onRemove,
    super.key,
  });

  final GroupMemberFormRow row;
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
                  child: Semantics(
                    button: true,
                    label: l10n.adminGroupUploadPhoto,
                    enabled: !isSaving,
                    child: OutlinedButton.icon(
                      onPressed: isSaving ? null : onPickPhoto,
                      style: staffRowOutlinedButtonStyle(context),
                      icon: const Icon(Icons.photo_camera_outlined, size: 18),
                      label: Text(l10n.adminGroupUploadPhoto),
                    ),
                  ),
                ),
                Semantics(
                  button: true,
                  label: l10n.adminGroupRemoveMember,
                  enabled: !isSaving,
                  child: IconButton(
                    onPressed: isSaving ? null : onRemove,
                    icon: const Icon(Icons.delete_outline),
                    tooltip: l10n.adminGroupRemoveMember,
                  ),
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
