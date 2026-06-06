import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
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

    return Scaffold(
      appBar: RafiqAppBar(title: Text(l10n.competitionDetailTitle)),
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
              _CompetitionActions(
                competitionId: competitionId,
                isOpen: comp.isOpen,
                myEntry: myEntry,
                l10n: l10n,
              ),
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
}

class _CompetitionActions extends ConsumerWidget {
  const _CompetitionActions({
    required this.competitionId,
    required this.isOpen,
    required this.myEntry,
    required this.l10n,
  });

  final String competitionId;
  final bool isOpen;
  final CompetitionEntry? myEntry;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPilgrim =
        ref.watch(authAccessModeProvider) == AppAccessMode.pilgrim;

    if (!isOpen) {
      return Text(l10n.competitionClosed);
    }

    if (!isPilgrim) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(l10n.competitionSignInRequired),
        ),
      );
    }

    if (myEntry == null) {
      return FilledButton(
        onPressed: () => _join(context, ref),
        child: Text(l10n.competitionJoin),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.competitionYourScore(myEntry!.score),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8.h),
        OutlinedButton(
          onPressed: () => _recordProgress(context, ref),
          child: Text(l10n.competitionRecordProgress),
        ),
      ],
    );
  }

  Future<void> _join(BuildContext context, WidgetRef ref) async {
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

  Future<void> _recordProgress(BuildContext context, WidgetRef ref) async {
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
