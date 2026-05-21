/// Central route path constants for [GoRouter].
abstract final class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String contentDetail = '/content/:id';
  static const String tools = '/tools';
  static const String prayerTimes = '/tools/prayer-times';
  static const String qibla = '/tools/qibla';
  static const String quran = '/tools/quran';
  static const String quranSurah = '/tools/quran/:surahNumber';
  static const String adhkar = '/tools/adhkar';
  static const String pilgrimDashboard = '/pilgrim';
  static const String operatorLogin = '/operator/login';
  static const String operatorIntake = '/operator/intake';
  static const String fieldOperatorLogin = '/operator/field/login';
  static const String fieldOperatorHome = '/operator/field';
  static const String fieldOperatorPilgrim = '/operator/field/:profileId';
  static const String adminLogin = '/admin/login';
  static const String adminDashboard = '/admin/dashboard';

  static String contentDetailPath(String id) => '/content/$id';

  static String fieldOperatorPilgrimPath(String profileId) =>
      '/operator/field/$profileId';

  static String quranSurahPath(int surahNumber) => '/tools/quran/$surahNumber';
}
