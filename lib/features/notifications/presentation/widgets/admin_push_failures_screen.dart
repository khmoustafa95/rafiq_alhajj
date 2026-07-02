import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/push_dispatch_failure.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_preferences_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Admin observability for FCM sends that failed after retries.
class AdminPushFailuresScreen extends ConsumerWidget {
  const AdminPushFailuresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final failuresAsync = ref.watch(adminPushDispatchFailuresProvider);

    final body = failuresAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          Center(child: Text(l10n.adminPushFailuresLoadError)),
      data: (failures) {
        if (failures.isEmpty) {
          return Center(child: Text(l10n.adminPushFailuresEmpty));
        }
        return ListView.separated(
          padding: EdgeInsets.all(sw(16)),
          itemCount: failures.length,
          separatorBuilder: (context, index) => SizedBox(height: sh(8)),
          itemBuilder: (context, index) {
            return _FailureTile(failure: failures[index]);
          },
        );
      },
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.adminPushFailuresTitle,
        subtitle: l10n.adminPushFailuresSubtitle,
        actions: [
          IconButton(
            tooltip: l10n.notificationsRefresh,
            onPressed: () =>
                ref.invalidate(adminPushDispatchFailuresProvider),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
        body: body,
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.adminPushFailuresTitle),
          actions: [
            IconButton(
              tooltip: l10n.notificationsRefresh,
              onPressed: () =>
                  ref.invalidate(adminPushDispatchFailuresProvider),
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
        body: body,
      ),
    );
  }
}

class _FailureTile extends StatelessWidget {
  const _FailureTile({required this.failure});

  final PushDispatchFailure failure;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final time = DateFormat.yMMMd().add_Hm().format(failure.createdAt.toLocal());

    return Card(
      child: Padding(
        padding: EdgeInsets.all(sw(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            SizedBox(height: sh(4)),
            Text(
              l10n.adminPushFailuresAttempts(failure.attempts),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: sh(6)),
            SelectableText(
              failure.error,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: sh(6)),
            Text(
              '${l10n.adminPushFailuresToken}: ${failure.deviceTokenPreview}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
