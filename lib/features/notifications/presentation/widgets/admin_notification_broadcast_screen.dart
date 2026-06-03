import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_audience.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminNotificationBroadcastScreen extends ConsumerStatefulWidget {
  const AdminNotificationBroadcastScreen({super.key});

  @override
  ConsumerState<AdminNotificationBroadcastScreen> createState() =>
      _AdminNotificationBroadcastScreenState();
}

class _AdminNotificationBroadcastScreenState
    extends ConsumerState<AdminNotificationBroadcastScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleArController = TextEditingController();
  final _titleEnController = TextEditingController();
  final _bodyArController = TextEditingController();
  final _bodyEnController = TextEditingController();

  NotificationAudience _audience = NotificationAudience.allPilgrims;
  String? _groupId;

  @override
  void dispose() {
    _titleArController.dispose();
    _titleEnController.dispose();
    _bodyArController.dispose();
    _bodyEnController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_audience == NotificationAudience.groupPilgrims && _groupId == null) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final count = await ref
        .read(adminNotificationBroadcastProvider.notifier)
        .send(
          NotificationBroadcastInput(
            audience: _audience,
            titleAr: _titleArController.text.trim(),
            titleEn: _titleEnController.text.trim(),
            bodyAr: _optionalText(_bodyArController.text),
            bodyEn: _optionalText(_bodyEnController.text),
            groupId: _groupId,
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

    _titleArController.clear();
    _titleEnController.clear();
    _bodyArController.clear();
    _bodyEnController.clear();
  }

  String? _optionalText(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final groupsAsync = ref.watch(notificationGroupsProvider);
    final isSending = ref.watch(adminNotificationBroadcastProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminNotificationSendTitle),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            Text(
              l10n.adminNotificationAudienceLabel,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 8.h),
            SegmentedButton<NotificationAudience>(
              segments: [
                ButtonSegment(
                  value: NotificationAudience.allPilgrims,
                  label: Text(l10n.adminNotificationAudienceAllPilgrims),
                ),
                ButtonSegment(
                  value: NotificationAudience.groupPilgrims,
                  label: Text(l10n.adminNotificationAudienceGroup),
                ),
                ButtonSegment(
                  value: NotificationAudience.allOperators,
                  label: Text(l10n.adminNotificationAudienceOperators),
                ),
              ],
              selected: {_audience},
              onSelectionChanged: (selection) {
                setState(() {
                  _audience = selection.first;
                  if (_audience != NotificationAudience.groupPilgrims) {
                    _groupId = null;
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
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: l10n.adminNotificationGroupLabel,
                      border: const OutlineInputBorder(),
                    ),
                    initialValue: _groupId,
                    items: [
                      for (final group in groups)
                        DropdownMenuItem(
                          value: group.id,
                          child: Text(group.name),
                        ),
                    ],
                    onChanged: (value) => setState(() => _groupId = value),
                    validator: (value) {
                      if (_audience == NotificationAudience.groupPilgrims &&
                          (value == null || value.isEmpty)) {
                        return l10n.adminNotificationGroupRequired;
                      }
                      return null;
                    },
                  );
                },
              ),
            ],
            SizedBox(height: 16.h),
            TextFormField(
              controller: _titleArController,
              decoration: InputDecoration(
                labelText: l10n.adminNotificationTitleAr,
                border: const OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? l10n.adminNotificationTitleRequired
                  : null,
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _titleEnController,
              decoration: InputDecoration(
                labelText: l10n.adminNotificationTitleEn,
                border: const OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? l10n.adminNotificationTitleRequired
                  : null,
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _bodyArController,
              decoration: InputDecoration(
                labelText: l10n.adminNotificationBodyAr,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _bodyEnController,
              decoration: InputDecoration(
                labelText: l10n.adminNotificationBodyEn,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 24.h),
            FilledButton.icon(
              onPressed: isSending ? null : _submit,
              icon: isSending
                  ? SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send_outlined),
              label: Text(l10n.adminNotificationSendButton),
            ),
          ],
        ),
      ),
    );
  }
}
