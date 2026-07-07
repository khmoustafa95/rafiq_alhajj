import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminSupportContactEditForm extends ConsumerWidget {
  const AdminSupportContactEditForm({
    required this.form,
    required this.scope,
    required this.groupId,
    required this.isActive,
    required this.isSaving,
    required this.onScopeChanged,
    required this.onGroupChanged,
    required this.onActiveChanged,
    super.key,
  });

  final FormGroup form;
  final SupportContactScope scope;
  final String? groupId;
  final bool isActive;
  final bool isSaving;
  final ValueChanged<SupportContactScope> onScopeChanged;
  final ValueChanged<String?> onGroupChanged;
  final ValueChanged<bool> onActiveChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final groupsAsync = ref.watch(notificationGroupsProvider);

    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaffFormSection(
            icon: Icons.contact_phone_outlined,
            title: l10n.adminSupportContactDetailsSection,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ResponsiveFormGrid(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'labelAr',
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactLabelAr,
                      ),
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            l10n.adminSupportContactLabelRequired,
                      },
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'labelEn',
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactLabelEn,
                      ),
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            l10n.adminSupportContactLabelRequired,
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ResponsiveFormGrid(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'descriptionAr',
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactDescriptionAr,
                      ),
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'descriptionEn',
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactDescriptionEn,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ResponsiveFormGrid(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'phoneNumber',
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactPhone,
                      ),
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'whatsappNumber',
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactWhatsapp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.tune_rounded,
            title: l10n.adminSupportContactScopeSection,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<SupportContactScope>(
                  initialValue: scope,
                  decoration: InputDecoration(
                    labelText: l10n.adminSupportContactScope,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: SupportContactScope.global,
                      child: Text(l10n.adminSupportContactScopeGlobal),
                    ),
                    DropdownMenuItem(
                      value: SupportContactScope.group,
                      child: Text(l10n.adminSupportContactScopeGroup),
                    ),
                  ],
                  onChanged: isSaving
                      ? null
                      : (value) => onScopeChanged(
                            value ?? SupportContactScope.global,
                          ),
                ),
                if (scope == SupportContactScope.group) ...[
                  SizedBox(height: 16.h),
                  groupsAsync.when(
                    loading: () => const LinearProgressIndicator(),
                    error: (_, _) => Text(
                      l10n.adminNotificationGroupsEmpty,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    data: (groups) {
                      if (groups.isEmpty) {
                        return Text(l10n.adminNotificationGroupsEmpty);
                      }
                      final hasValue =
                          groups.any((group) => group.id == groupId);
                      return DropdownButtonFormField<String>(
                        initialValue: hasValue ? groupId : null,
                        decoration: InputDecoration(
                          labelText: l10n.adminSupportContactGroup,
                        ),
                        items: [
                          for (final group in groups)
                            DropdownMenuItem(
                              value: group.id,
                              child: Text(group.name),
                            ),
                        ],
                        onChanged: isSaving ? null : onGroupChanged,
                      );
                    },
                  ),
                ],
                SizedBox(height: 8.h),
                ResponsiveFormGrid(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'sortOrder',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: l10n.adminSupportContactSortOrder,
                      ),
                    ),
                  ],
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: isActive,
                  onChanged: isSaving ? null : onActiveChanged,
                  title: Text(l10n.adminSupportContactActive),
                  subtitle: Text(
                    l10n.adminSupportContactActiveHint,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
