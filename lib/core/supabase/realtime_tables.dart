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
    'pilgrim_documents',
    'groups',
    'group_administration_members',
    'sos_alerts',
    'push_dispatch_failures',
    'competitions',
    'competition_entries',
    'content_library',
    'content_topics',
    'device_tokens',
  ];

  static const competitions = ['competitions', 'competition_entries'];

  static const supportContacts = ['support_contacts'];

  static const sosAlerts = ['sos_alerts', 'sos_location_pings'];
}
