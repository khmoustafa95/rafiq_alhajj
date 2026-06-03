class Competition {
  const Competition({
    required this.id,
    required this.title,
    required this.description,
    required this.startsAt,
    required this.endsAt,
    required this.isActive,
  });

  final String id;
  final String title;
  final String? description;
  final DateTime startsAt;
  final DateTime endsAt;
  final bool isActive;

  bool get isOpen {
    final now = DateTime.now().toUtc();
    return isActive && !now.isBefore(startsAt) && !now.isAfter(endsAt);
  }
}

class CompetitionEntry {
  const CompetitionEntry({
    required this.id,
    required this.competitionId,
    required this.profileId,
    required this.participantName,
    required this.score,
    required this.joinedAt,
  });

  final String id;
  final String competitionId;
  final String profileId;
  final String participantName;
  final int score;
  final DateTime joinedAt;
}

class CompetitionWithEntries {
  const CompetitionWithEntries({
    required this.competition,
    required this.entries,
    this.myEntry,
  });

  final Competition competition;
  final List<CompetitionEntry> entries;
  final CompetitionEntry? myEntry;
}
