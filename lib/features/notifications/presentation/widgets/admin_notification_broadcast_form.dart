import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_audience.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Audience + bilingual content fields for the admin notification broadcast screen.
class AdminNotificationBroadcastForm extends ConsumerWidget {
  const AdminNotificationBroadcastForm({
    required this.form,
    required this.audience,
    required this.isSending,
    required this.onAudienceChanged,
    required this.onSubmit,
    super.key,
  });

  final FormGroup form;
  final NotificationAudience audience;
  final bool isSending;
  final ValueChanged<NotificationAudience> onAudienceChanged;
  final VoidCallback onSubmit;

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
            icon: Icons.groups_outlined,
            title: l10n.adminNotificationAudienceLabel,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedButton<NotificationAudience>(
                  segments: [
                    ButtonSegment(
                      value: NotificationAudience.allPilgrims,
                      label: Text(l10n.adminNotificationAudienceAllPilgrims),
                      icon: const Icon(Icons.people_outline),
                    ),
                    ButtonSegment(
                      value: NotificationAudience.groupPilgrims,
                      label: Text(l10n.adminNotificationAudienceGroup),
                      icon: const Icon(Icons.group_outlined),
                    ),
                    ButtonSegment(
                      value: NotificationAudience.allOperators,
                      label: Text(l10n.adminNotificationAudienceOperators),
                      icon: const Icon(Icons.engineering_outlined),
                    ),
                  ],
                  selected: {audience},
                  onSelectionChanged: (selection) {
                    if (isSending) {
                      return;
                    }
                    onAudienceChanged(selection.first);
                  },
                ),
                if (audience == NotificationAudience.groupPilgrims) ...[
                  SizedBox(height: 16.h),
                  groupsAsync.when(
                    loading: () => const LinearProgressIndicator(),
                    error: (_, _) => Text(l10n.adminNotificationGroupsLoadError),
                    data: (groups) {
                      if (groups.isEmpty) {
                        return Text(l10n.adminNotificationGroupsEmpty);
                      }
                      return ReactiveDropdownField<String>(
                        formControlName: 'groupId',
                        decoration: InputDecoration(
                          labelText: l10n.adminNotificationGroupLabel,
                        ),
                        items: [
                          for (final group in groups)
                            DropdownMenuItem(
                              value: group.id,
                              child: Text(group.name),
                            ),
                        ],
                        validationMessages: {
                          'groupRequired': (_) =>
                              l10n.adminNotificationGroupRequired,
                        },
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 16.h),
          StaffFormSection(
            icon: Icons.translate_outlined,
            title: l10n.adminNotificationContentSection,
            child: ResponsiveFormGrid(
              children: [
                ReactiveTextField<String>(
                  formControlName: 'titleAr',
                  decoration: InputDecoration(
                    labelText: l10n.adminNotificationTitleAr,
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        l10n.adminNotificationTitleRequired,
                  },
                ),
                ReactiveTextField<String>(
                  formControlName: 'titleEn',
                  decoration: InputDecoration(
                    labelText: l10n.adminNotificationTitleEn,
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        l10n.adminNotificationTitleRequired,
                  },
                ),
                ReactiveTextField<String>(
                  formControlName: 'bodyAr',
                  decoration: InputDecoration(
                    labelText: l10n.adminNotificationBodyAr,
                  ),
                  maxLines: 4,
                ),
                ReactiveTextField<String>(
                  formControlName: 'bodyEn',
                  decoration: InputDecoration(
                    labelText: l10n.adminNotificationBodyEn,
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ),
          if (!AppPlatform.isWeb) ...[
            SizedBox(height: 24.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Semantics(
                button: true,
                label: l10n.adminNotificationSendButton,
                enabled: !isSending,
                child: StaffFormActionButtons(
                  primaryLabel: l10n.adminNotificationSendButton,
                  onPrimary: onSubmit,
                  isLoading: isSending,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
