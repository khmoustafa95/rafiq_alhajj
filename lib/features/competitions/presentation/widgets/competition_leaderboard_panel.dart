import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class CompetitionLeaderboardPanel extends StatelessWidget {
  const CompetitionLeaderboardPanel({
    required this.entries,
    this.highlightProfileId,
    super.key,
  });

  final List<CompetitionEntry> entries;
  final String? highlightProfileId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DecoratedBox(
      decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.leaderboard_rounded,
                  color: AppColors.secondary,
                  size: 22.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  l10n.competitionLeaderboard,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            if (entries.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  l10n.competitionLeaderboardEmpty,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
              )
            else
              ...entries.asMap().entries.map((entry) {
                final rank = entry.key + 1;
                final row = entry.value;
                final isMe = row.profileId == highlightProfileId;
                final name = row.participantName.isEmpty
                    ? l10n.competitionAnonymous
                    : row.participantName;

                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: _LeaderboardRow(
                    rank: rank,
                    name: name,
                    score: row.score,
                    scoreLabel: l10n.competitionPoints(row.score),
                    isHighlighted: isMe,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  const _LeaderboardRow({
    required this.rank,
    required this.name,
    required this.score,
    required this.scoreLabel,
    required this.isHighlighted,
  });

  final int rank;
  final String name;
  final int score;
  final String scoreLabel;
  final bool isHighlighted;

  Color? _medalColor() {
    return switch (rank) {
      1 => AppColors.secondary,
      2 => AppColors.textSecondary,
      3 => const Color(0xFFB45309),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final medal = _medalColor();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        border: isHighlighted
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 36.w,
            child: medal != null
                ? Icon(Icons.emoji_events_rounded, color: medal, size: 22.sp)
                : Text(
                    '$rank',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
          ),
          Expanded(
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight:
                        isHighlighted ? FontWeight.w700 : FontWeight.w500,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              scoreLabel,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.onSecondary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
