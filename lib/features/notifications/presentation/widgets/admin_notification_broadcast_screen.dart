import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_audience.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminNotificationBroadcastScreen extends ConsumerStatefulWidget {
  const AdminNotificationBroadcastScreen({super.key});

  @override
  ConsumerState<AdminNotificationBroadcastScreen> createState() =>
      _AdminNotificationBroadcastScreenState();
}

class _AdminNotificationBroadcastScreenState
    extends ConsumerState<AdminNotificationBroadcastScreen> {
  late final FormGroup _form;

  NotificationAudience _audience = NotificationAudience.allPilgrims;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'titleAr': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'titleEn': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'bodyAr': FormControl<String>(value: ''),
      'bodyEn': FormControl<String>(value: ''),
      'groupId': FormControl<String>(
        validators: [Validators.delegate(_validateGroup)],
      ),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Map<String, dynamic>? _validateGroup(AbstractControl<dynamic> control) {
    final value = control.value as String?;
    if (_audience == NotificationAudience.groupPilgrims &&
        (value == null || value.isEmpty)) {
      return {'groupRequired': true};
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }

    if (_audience == NotificationAudience.groupPilgrims &&
        _form.control('groupId').value == null) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final count = await ref
        .read(adminNotificationBroadcastProvider.notifier)
        .send(
          NotificationBroadcastInput(
            audience: _audience,
            titleAr: (_form.control('titleAr').value as String).trim(),
            titleEn: (_form.control('titleEn').value as String).trim(),
            bodyAr: _optionalText(_form.control('bodyAr').value as String),
            bodyEn: _optionalText(_form.control('bodyEn').value as String),
            groupId: _form.control('groupId').value as String?,
            payload: const {'route': 'home'},
          ),
        );

    if (!mounted) {
      return;
    }

    if (count == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminNotificationSendError)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.adminNotificationSendSuccess(count)),
      ),
    );

    _form.control('titleAr').reset(value: '');
    _form.control('titleEn').reset(value: '');
    _form.control('bodyAr').reset(value: '');
    _form.control('bodyEn').reset(value: '');
  }

  String? _optionalText(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Widget _buildForm(AppLocalizations l10n, bool isSending) {
    final groupsAsync = ref.watch(notificationGroupsProvider);

    return ReactiveForm(
      formGroup: _form,
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
                  selected: {_audience},
                  onSelectionChanged: (selection) {
                    if (isSending) {
                      return;
                    }
                    setState(() {
                      _audience = selection.first;
                      if (_audience != NotificationAudience.groupPilgrims) {
                        _form.control('groupId').updateValue(null);
                      } else {
                        _form.control('groupId').updateValueAndValidity();
                      }
                    });
                  },
                ),
                if (_audience == NotificationAudience.groupPilgrims) ...[
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
              child: StaffFormActionButtons(
                primaryLabel: l10n.adminNotificationSendButton,
                onPrimary: _submit,
                isLoading: isSending,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isSending = ref.watch(adminNotificationBroadcastProvider).isLoading;

    ref.listen(
      adminNotificationBroadcastProvider.select((state) => state.isLoading),
      (previous, isLoading) {
        if (isLoading) {
          _form.markAsDisabled();
        } else {
          _form.markAsEnabled();
        }
      },
    );

    final form = _buildForm(l10n, isSending);

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.adminNotificationSendTitle,
        subtitle: l10n.adminNotificationSendSubtitle,
        actions: [
          IconButton(
            tooltip: l10n.adminPushFailuresTitle,
            onPressed: () => context.go(AppRoutes.adminPushFailures),
            icon: const Icon(Icons.monitor_heart_outlined),
          ),
        ],
        body: form,
        bottomBar: StaffFormActionsBar(
          primaryLabel: l10n.adminNotificationSendButton,
          onPrimary: _submit,
          isLoading: isSending,
        ),
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.adminNotificationSendTitle),
          actions: [
            IconButton(
              tooltip: l10n.adminPushFailuresTitle,
              onPressed: () => context.go(AppRoutes.adminPushFailures),
              icon: const Icon(Icons.monitor_heart_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: form,
        ),
      ),
    );
  }
}
