/// Tables published to [supabase_realtime] for live client refresh.
abstract final class RealtimeTables {
  static const pilgrimRegistry = ['profiles', 'pilgrims', 'trip_enrollments'];

  static const pilgrimDashboard = ['trip_enrollments', 'ritual_logs'];

  static const contentFeed = [
    'content_library',
    'content_topics',
    'content_topic_media',
  ];

  static const adminAnalytics = [
    'profiles',
    'pilgrims',
    'trip_enrollments',
    'ritual_logs',
    'pilgrim_documents',
    'groups',
    'group_administration_members',
  ];

  static const competitions = ['competitions', 'competition_entries'];
}
