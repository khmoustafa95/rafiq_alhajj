import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_audience.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/admin_notification_broadcast_form.dart';
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

  String? _optionalText(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  void _cancel() {
    staffNavigateBack(context, fallbackRoute: AppRoutes.adminDashboard);
  }

  void _onAudienceChanged(NotificationAudience audience) {
    setState(() {
      _audience = audience;
      if (_audience != NotificationAudience.groupPilgrims) {
        _form.control('groupId').updateValue(null);
      } else {
        _form.control('groupId').updateValueAndValidity();
      }
    });
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

    final form = AdminNotificationBroadcastForm(
      form: _form,
      audience: _audience,
      isSending: isSending,
      onAudienceChanged: _onAudienceChanged,
      onSubmit: _submit,
    );

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
        bottomBar: Semantics(
          button: true,
          label: l10n.adminNotificationSendButton,
          enabled: !isSending,
          child: StaffFormActionsBar(
            primaryLabel: l10n.adminNotificationSendButton,
            onPrimary: _submit,
            secondaryLabel: l10n.dialogCancel,
            onSecondary: isSending ? null : _cancel,
            isLoading: isSending,
          ),
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
        bottomNavigationBar: Semantics(
          button: true,
          label: l10n.adminNotificationSendButton,
          enabled: !isSending,
          child: StaffFormMobileActionsBar(
            primaryLabel: l10n.adminNotificationSendButton,
            onPrimary: _submit,
            secondaryLabel: l10n.dialogCancel,
            onSecondary: isSending ? null : _cancel,
            isLoading: isSending,
          ),
        ),
      ),
    );
  }
}
