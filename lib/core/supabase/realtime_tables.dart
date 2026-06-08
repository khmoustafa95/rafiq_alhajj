/// Tables published to [supabase_realtime] for live client refresh.
abstract final class RealtimeTables {
  static const pilgrimRegistry = ['profiles', 'pilgrim_details'];

  static const pilgrimDashboard = ['pilgrim_details', 'ritual_logs'];

  static const contentFeed = ['content_library'];

  static const adminAnalytics = [
    'profiles',
    'pilgrim_details',
    'ritual_logs',
    'pilgrim_documents',
    'groups',
    'group_administration_members',
  ];

  static const competitions = ['competitions', 'competition_entries'];
}
