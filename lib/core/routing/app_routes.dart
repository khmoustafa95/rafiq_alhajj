/// Central route path constants for [GoRouter].
abstract final class AppRoutes {
  static const String home = '/';
  static const String services = '/services';
  static const String notifications = '/notifications';
  static const String hajjJourney = '/journey';
  static const String hajjRitualDetail = '/journey/:ritualKey';
  static const String adminHajjJourney = '/admin/hajj-journey';
  static const String adminHajjJourneyEdit = '/admin/hajj-journey/:ritualKey/edit';
  static const String login = '/login';
  static const String contentVideosList = '/content/videos';
  static const String contentTopicsList = '/content/topics';
  static const String contentTopicDetail = '/content/topics/:id';
  static const String contentNewsList = '/content/news';
  static const String contentAnnouncementsList = '/content/announcements';
  static const String contentDetail = '/content/:id';
  static const String tools = '/tools';
  static const String supportContacts = '/support-contacts';
  static const String sos = '/sos';
  static const String prayerTimes = '/tools/prayer-times';
  static const String qibla = '/tools/qibla';
  static const String quran = '/tools/quran';
  static const String quranSurah = '/tools/quran/:surahNumber';
  static const String adhkar = '/tools/adhkar';
  static const String virtualTour = '/tools/virtual-tour';
  static const String competitions = '/competitions';
  static const String competitionDetail = '/competitions/:id';
  static const String competitionQuiz = '/competitions/:id/quiz';
  static const String adminCompetitions = '/admin/competitions';
  static const String adminCompetitionNew = '/admin/competitions/new';
  static const String adminCompetitionEdit = '/admin/competitions/:id/edit';

  static String competitionDetailPath(String id) => '/competitions/$id';

  static String competitionQuizPath(String id) => '/competitions/$id/quiz';

  static String adminCompetitionEditPath(String id) =>
      '/admin/competitions/$id/edit';
  static const String pilgrimDashboard = '/pilgrim';
  static const String profile = '/profile';
  static const String operatorLogin = '/operator/login';
  static const String operatorIntake = '/operator/intake';
  static const String operatorPilgrims = '/operator/pilgrims';
  static const String operatorPilgrimsImport = '/operator/pilgrims/import';
  static const String operatorPilgrimDetail = '/operator/pilgrims/:pilgrimId';

  static String operatorPilgrimDetailPath(String pilgrimId) =>
      '/operator/pilgrims/$pilgrimId';
  static const String fieldOperatorLogin = '/operator/field/login';
  static const String fieldOperatorHome = '/operator/field';
  static const String fieldOperatorPilgrims = '/operator/field/pilgrims';
  static const String fieldOperatorPilgrim = '/operator/field/:profileId';
  static const String adminLogin = '/admin/login';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminNotificationSend = '/admin/notifications/send';
  static const String adminPushFailures = '/admin/notifications/failures';
  static const String adminContent = '/admin/content';
  static const String adminContentTopics = '/admin/content/topics';
  static const String adminContentTopicNew = '/admin/content/topics/new';
  static const String adminContentTopicEdit = '/admin/content/topics/:id/edit';
  static const String adminContentNew = '/admin/content/new';
  static const String adminContentEdit = '/admin/content/:id/edit';
  static const String adminOperators = '/admin/operators';
  static const String adminOperatorNew = '/admin/operators/new';
  static const String adminOperatorEdit = '/admin/operators/:id/edit';
  static const String adminGroups = '/admin/groups';
  static const String adminGroupNew = '/admin/groups/new';
  static const String adminGroupEdit = '/admin/groups/:id/edit';
  static const String adminTrips = '/admin/trips';
  static const String adminTripOffices = '/admin/trips/:id/offices';
  static const String adminSettings = '/admin/settings';
  static const String adminAppVersions = '/admin/settings/app-versions';
  static const String adminSupportContacts = '/admin/support-contacts';
  static const String adminSupportContactNew = '/admin/support-contacts/new';
  static const String adminSupportContactEdit =
      '/admin/support-contacts/:id/edit';
  static const String adminSos = '/admin/sos';
  static const String fieldOperatorSos = '/operator/field/sos';

  static String adminContentEditPath(String id) => '/admin/content/$id/edit';

  /// Admin "new content" scoped to a feed type (announcement | news).
  static String adminContentNewTypedPath(String type) =>
      '/admin/content/new?type=$type';

  static String adminSupportContactEditPath(String id) =>
      '/admin/support-contacts/$id/edit';

  static String adminOperatorEditPath(String id) => '/admin/operators/$id/edit';

  static String adminGroupEditPath(String id) => '/admin/groups/$id/edit';

  static String adminTripOfficesPath(String id) => '/admin/trips/$id/offices';

  static String contentDetailPath(String id) => '/content/$id';

  static String contentTopicDetailPath(String id) => '/content/topics/$id';

  static String adminContentTopicEditPath(String id) =>
      '/admin/content/topics/$id/edit';

  static String fieldOperatorPilgrimPath(String profileId) =>
      '/operator/field/$profileId';

  static String quranSurahPath(int surahNumber) => '/tools/quran/$surahNumber';

  static String hajjRitualDetailPath(String ritualKey) => '/journey/$ritualKey';

  static String adminHajjJourneyEditPath(String ritualKey) =>
      '/admin/hajj-journey/$ritualKey/edit';
}
