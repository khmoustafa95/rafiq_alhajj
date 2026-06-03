import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class CompetitionDetailScreen extends ConsumerWidget {
  const CompetitionDetailScreen({required this.competitionId, super.key});

  final String competitionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final detailAsync =
        ref.watch(competitionDetailProvider(competitionId));
    final isPilgrim = ref.watch(authSessionProvider).value?.accessMode ==
        AppAccessMode.pilgrim;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.competitionDetailTitle)),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.competitionsLoadError)),
        data: (data) {
          if (data == null) {
            return Center(child: Text(l10n.competitionNotFound));
          }

          final comp = data.competition;
          final myEntry = data.myEntry;

          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              Text(
                comp.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (comp.description != null) ...[
                SizedBox(height: 8.h),
                Text(comp.description!),
              ],
              SizedBox(height: 16.h),
              if (!isPilgrim)
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text(l10n.competitionSignInRequired),
                  ),
                )
              else if (!comp.isOpen)
                Text(l10n.competitionClosed)
              else if (myEntry == null)
                FilledButton(
                  onPressed: () => _join(context, ref, l10n),
                  child: Text(l10n.competitionJoin),
                )
              else ...[
                Text(
                  l10n.competitionYourScore(myEntry.score),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 8.h),
                OutlinedButton(
                  onPressed: () => _recordProgress(context, ref, l10n),
                  child: Text(l10n.competitionRecordProgress),
                ),
              ],
              SizedBox(height: 24.h),
              Text(
                l10n.competitionLeaderboard,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.h),
              if (data.entries.isEmpty)
                Text(l10n.competitionLeaderboardEmpty)
              else
                ...data.entries.asMap().entries.map((entry) {
                  final rank = entry.key + 1;
                  final row = entry.value;
                  return ListTile(
                    leading: CircleAvatar(child: Text('$rank')),
                    title: Text(
                      row.participantName.isEmpty
                          ? l10n.competitionAnonymous
                          : row.participantName,
                    ),
                    trailing: Text(l10n.competitionPoints(row.score)),
                  );
                }),
            ],
          );
        },
      ),
    );
  }

  Future<void> _join(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final ok = await ref
        .read(competitionDetailProvider(competitionId).notifier)
        .join();

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.competitionJoinSuccess : l10n.competitionJoinError,
        ),
      ),
    );
  }

  Future<void> _recordProgress(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final ok = await ref
        .read(competitionDetailProvider(competitionId).notifier)
        .recordProgress();

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? l10n.competitionProgressRecorded
              : l10n.competitionProgressError,
        ),
      ),
    );
  }
}
