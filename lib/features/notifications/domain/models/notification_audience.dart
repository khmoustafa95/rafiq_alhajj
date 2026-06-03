enum NotificationAudience {
  allPilgrims,
  groupPilgrims,
  allOperators;

  String get rpcValue => switch (this) {
        NotificationAudience.allPilgrims => 'all_pilgrims',
        NotificationAudience.groupPilgrims => 'group_pilgrims',
        NotificationAudience.allOperators => 'all_operators',
      };
}

class NotificationGroupOption {
  const NotificationGroupOption({required this.id, required this.name});

  final String id;
  final String name;
}

class NotificationBroadcastInput {
  const NotificationBroadcastInput({
    required this.audience,
    required this.titleAr,
    required this.titleEn,
    this.bodyAr,
    this.bodyEn,
    this.groupId,
    this.payload = const {},
  });

  final NotificationAudience audience;
  final String titleAr;
  final String titleEn;
  final String? bodyAr;
  final String? bodyEn;
  final String? groupId;
  final Map<String, dynamic> payload;
}
