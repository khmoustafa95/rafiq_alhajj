/// Central route path constants for [GoRouter].
abstract final class AppRoutes {
  static const String home = '/';
  static const String notifications = '/notifications';
  static const String login = '/login';
  static const String contentVideosList = '/content/videos';
  static const String contentNewsList = '/content/news';
  static const String contentDetail = '/content/:id';
  static const String tools = '/tools';
  static const String prayerTimes = '/tools/prayer-times';
  static const String qibla = '/tools/qibla';
  static const String quran = '/tools/quran';
  static const String quranSurah = '/tools/quran/:surahNumber';
  static const String adhkar = '/tools/adhkar';
  static const String competitions = '/competitions';
  static const String competitionDetail = '/competitions/:id';
  static const String adminCompetitions = '/admin/competitions';
  static const String adminCompetitionNew = '/admin/competitions/new';
  static const String adminCompetitionEdit = '/admin/competitions/:id/edit';

  static String competitionDetailPath(String id) => '/competitions/$id';

  static String adminCompetitionEditPath(String id) =>
      '/admin/competitions/$id/edit';
  static const String pilgrimDashboard = '/pilgrim';
  static const String profile = '/profile';
  static const String operatorLogin = '/operator/login';
  static const String operatorIntake = '/operator/intake';
  static const String operatorPilgrims = '/operator/pilgrims';
  static const String operatorPilgrimDetail = '/operator/pilgrims/:profileId';

  static String operatorPilgrimDetailPath(String profileId) =>
      '/operator/pilgrims/$profileId';
  static const String fieldOperatorLogin = '/operator/field/login';
  static const String fieldOperatorHome = '/operator/field';
  static const String fieldOperatorPilgrim = '/operator/field/:profileId';
  static const String adminLogin = '/admin/login';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminNotificationSend = '/admin/notifications/send';
  static const String adminContent = '/admin/content';
  static const String adminContentNew = '/admin/content/new';
  static const String adminContentEdit = '/admin/content/:id/edit';

  static String adminContentEditPath(String id) => '/admin/content/$id/edit';

  static String contentDetailPath(String id) => '/content/$id';

  static String fieldOperatorPilgrimPath(String profileId) =>
      '/operator/field/$profileId';

  static String quranSurahPath(int surahNumber) => '/tools/quran/$surahNumber';
}
