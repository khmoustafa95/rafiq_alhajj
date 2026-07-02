import 'package:freezed_annotation/freezed_annotation.dart';

part 'competition.freezed.dart';

@freezed
abstract class Competition with _$Competition {
  const factory Competition({
    required String id,
    required String title,
    String? description,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isActive,
  }) = _Competition;

  const Competition._();

  bool get isOpen {
    final now = DateTime.now().toUtc();
    return isActive && !now.isBefore(startsAt) && !now.isAfter(endsAt);
  }
}

@freezed
abstract class CompetitionEntry with _$CompetitionEntry {
  const factory CompetitionEntry({
    required String id,
    required String competitionId,
    required String profileId,
    required String participantName,
    required int score,
    required DateTime joinedAt,
  }) = _CompetitionEntry;
}

@freezed
abstract class CompetitionWithEntries with _$CompetitionWithEntries {
  const factory CompetitionWithEntries({
    required Competition competition,
    required List<CompetitionEntry> entries,
    CompetitionEntry? myEntry,
  }) = _CompetitionWithEntries;
}
