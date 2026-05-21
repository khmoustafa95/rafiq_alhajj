// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Rafiq Al-Hajj';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeWelcome => 'Welcome to your Hajj companion';

  @override
  String get routeNotFoundTitle => 'Page not found';

  @override
  String get routeNotFoundMessage =>
      'The page you requested could not be found.';

  @override
  String get goHome => 'Go home';

  @override
  String get bootstrapErrorTitle => 'Unable to start the app';

  @override
  String get bootstrapErrorMessage =>
      'Something went wrong while starting Rafiq Al-Hajj. Please try again.';

  @override
  String get retry => 'Try again';

  @override
  String get homeSignInAsPilgrim => 'Sign in as pilgrim';

  @override
  String get homePilgrimWelcome =>
      'You are signed in. Browse public and exclusive content below.';

  @override
  String get contentVideosSection => 'Awareness videos';

  @override
  String get contentNewsSection => 'News & announcements';

  @override
  String get contentVideosEmpty => 'No public videos available yet.';

  @override
  String get contentNewsEmpty => 'No news or announcements yet.';

  @override
  String get contentLoadError => 'Could not load content. Pull to refresh.';

  @override
  String get contentSupabaseRequired =>
      'Connect Supabase to load videos and news from the server.';

  @override
  String get contentDetailTitle => 'Content';

  @override
  String get contentNotFound => 'This content is no longer available.';

  @override
  String get contentOpenMedia => 'Open video or link';

  @override
  String get contentOpenMediaFailed => 'Could not open the link.';

  @override
  String homePilgrimGreeting(String name) {
    return 'Welcome, $name';
  }

  @override
  String get signOut => 'Sign out';

  @override
  String get loginTitle => 'Pilgrim sign in';

  @override
  String get loginSubtitle =>
      'Use the account credentials provided by your center';

  @override
  String get loginEmailLabel => 'Account email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginEmailRequired => 'Enter your account email';

  @override
  String get loginEmailInvalid => 'Enter a valid email address';

  @override
  String get loginPasswordRequired => 'Enter your password';

  @override
  String get loginSubmit => 'Sign in';

  @override
  String get authErrorInvalidCredentials => 'Email or password is incorrect';

  @override
  String get authErrorEmailNotConfirmed =>
      'Confirm your email before signing in';

  @override
  String get authErrorNotPilgrimRole =>
      'This account is not a pilgrim account. Use the web dashboard instead.';

  @override
  String get authErrorProfileNotFound =>
      'Your profile was not found. Contact your center.';

  @override
  String get authErrorSupabaseUnavailable =>
      'Sign-in requires Supabase. Run with local dart-defines or contact support.';

  @override
  String get authErrorUnknown => 'Sign-in failed. Please try again.';

  @override
  String get homeIslamicTools => 'Islamic tools';

  @override
  String get toolsHubTitle => 'Islamic tools';

  @override
  String get toolsPrayerTimesTitle => 'Prayer times';

  @override
  String get toolsPrayerTimesSubtitle =>
      'Calculated from your GPS — works offline after first load';

  @override
  String get toolsQiblaTitle => 'Qibla';

  @override
  String get toolsQiblaSubtitle => 'Compass direction to the Kaaba';

  @override
  String get toolsQuranTitle => 'Quran';

  @override
  String get toolsQuranSubtitle => 'Full mushaf offline in the app';

  @override
  String get toolsAdhkarTitle => 'Adhkar';

  @override
  String get toolsAdhkarSubtitle => 'Morning and evening remembrances';

  @override
  String get toolsRefreshLocation => 'Refresh location';

  @override
  String get toolsUsingCachedLocation =>
      'Using last known location (offline). Tap refresh for GPS.';

  @override
  String toolsCoordinates(String lat, String lng) {
    return 'Location: $lat, $lng';
  }

  @override
  String get prayerFajr => 'Fajr';

  @override
  String get prayerSunrise => 'Sunrise';

  @override
  String get prayerDhuhr => 'Dhuhr';

  @override
  String get prayerAsr => 'Asr';

  @override
  String get prayerMaghrib => 'Maghrib';

  @override
  String get prayerIsha => 'Isha';

  @override
  String toolsQiblaBearing(String degrees) {
    return 'Qibla bearing: $degrees°';
  }

  @override
  String toolsCompassHeading(String degrees) {
    return 'Device heading: $degrees°';
  }

  @override
  String get toolsQiblaHint =>
      'Rotate your device until the arrow points up for Qibla.';

  @override
  String get toolsQiblaCompassUnavailable =>
      'Compass sensor unavailable on this device.';

  @override
  String get toolsQuranAyahs => 'ayahs';

  @override
  String toolsQuranSurahMeta(int count) {
    return '$count ayahs';
  }

  @override
  String get toolsQuranOfflineNote =>
      'Text loaded from offline package — no internet required.';

  @override
  String get toolsAdhkarMorning => 'Morning';

  @override
  String get toolsAdhkarEvening => 'Evening';

  @override
  String get toolsAdhkarRepeat => 'Repeat';

  @override
  String get locationErrorServiceDisabled =>
      'Turn on location services to calculate prayer times and Qibla.';

  @override
  String get locationErrorPermissionDenied =>
      'Location permission is required for accurate prayer times and Qibla.';

  @override
  String get locationErrorPermissionDeniedForever =>
      'Enable location permission in system settings.';

  @override
  String get locationErrorUnavailable => 'Could not determine your location.';

  @override
  String get homeMyHajjJourney => 'My Hajj journey';

  @override
  String get pilgrimDashboardTitle => 'My Hajj journey';

  @override
  String pilgrimRitualsProgress(int completed, int total) {
    return '$completed of $total rituals completed';
  }

  @override
  String get pilgrimRitualPendingSync => 'Pending sync when online';

  @override
  String pilgrimRitualCompletedAt(String date) {
    return 'Completed on $date';
  }

  @override
  String get pilgrimSyncPending =>
      'Some ritual updates will sync when you are back online.';

  @override
  String get pilgrimLogisticsTitle => 'Travel & accommodation';

  @override
  String get pilgrimLogisticsEmpty =>
      'Your center has not published logistics details yet.';

  @override
  String get pilgrimMedicalStatus => 'Medical test';

  @override
  String get pilgrimTravelDate => 'Travel date';

  @override
  String get pilgrimHotel => 'Hotel';

  @override
  String get pilgrimOpenHotelMap => 'Open hotel on map';

  @override
  String get pilgrimTransport => 'Transportation';

  @override
  String get pilgrimSignInRequired =>
      'Sign in as a pilgrim to track rituals and view your file.';

  @override
  String get pilgrimLoadError =>
      'Could not load your Hajj dashboard. Pull to refresh.';

  @override
  String get authErrorNotStaffRole =>
      'This account is not authorized for the operator dashboard.';

  @override
  String get authErrorNotAdminRole =>
      'This account is not authorized for the admin dashboard.';

  @override
  String get operatorLoginTitle => 'Operator sign in';

  @override
  String get operatorLoginSubtitle =>
      'Center technician — pilgrim registration (US-05)';

  @override
  String get operatorIntakeTitle => 'Register pilgrim';

  @override
  String get operatorIntakeSubtitle =>
      'Enter pilgrim data, upload documents, and create a mobile account.';

  @override
  String get operatorGenerateCredentials => 'Generate email & password';

  @override
  String operatorGeneratedPasswordPreview(String password) {
    return 'Preview password (final password is set on submit): $password';
  }

  @override
  String get operatorDocumentsSection => 'Documents';

  @override
  String operatorPickDocuments(int count) {
    return 'Pick files ($count)';
  }

  @override
  String get operatorFullName => 'Full name';

  @override
  String get operatorRequired => 'Required';

  @override
  String get operatorPassport => 'Passport number';

  @override
  String get operatorTravelPermit => 'Travel permit';

  @override
  String get operatorHotelMapUrl => 'Hotel map URL';

  @override
  String get operatorPickDate => 'Select date';

  @override
  String get operatorSubmitPilgrim => 'Create pilgrim account';

  @override
  String get operatorAccountCreatedTitle => 'Pilgrim account created';

  @override
  String get operatorCloseDialog => 'Close';

  @override
  String get homeFieldOperatorSignIn => 'Field operator sign in';

  @override
  String get fieldOperatorLoginTitle => 'Field operator';

  @override
  String get fieldOperatorLoginSubtitle =>
      'Search pilgrims and update logistics in the field (US-06)';

  @override
  String get fieldOperatorHomeTitle => 'Pilgrims in the field';

  @override
  String get fieldOperatorSearchHint =>
      'Search by name, passport, or permit number';

  @override
  String get fieldOperatorLoadError =>
      'Could not load pilgrims. Pull to refresh.';

  @override
  String get fieldOperatorNoResults => 'No pilgrims match your search.';

  @override
  String get fieldOperatorPilgrimTitle => 'Update pilgrim';

  @override
  String get fieldOperatorStatusSection => 'Field status';

  @override
  String get fieldOperatorMedicalLabel => 'Medical test status';

  @override
  String get fieldOperatorHotelLabel => 'Hotel';

  @override
  String get fieldOperatorTransportLabel => 'Transportation';

  @override
  String get fieldOperatorSave => 'Save updates';

  @override
  String get fieldOperatorSaveSuccess => 'Pilgrim record updated.';

  @override
  String get fieldOperatorSaveError => 'Could not save changes.';

  @override
  String get fieldOperatorShare => 'Copy summary to share';

  @override
  String get fieldOperatorCopied => 'Summary copied to clipboard.';

  @override
  String get fieldOperatorNotFound => 'Pilgrim not found.';

  @override
  String fieldOperatorShareSummary(
    String name,
    String status,
    String medical,
    String hotel,
  ) {
    return '$name\nStatus: $status\nMedical: $medical\nHotel: $hotel';
  }

  @override
  String get fieldStatusNotSet => 'Not set';

  @override
  String get fieldStatusPending => 'Pending';

  @override
  String get fieldStatusMedicalDone => 'Medical check completed';

  @override
  String get fieldStatusArrivedHotel => 'Arrived at hotel';

  @override
  String get fieldStatusInTransit => 'In transit';

  @override
  String get fieldStatusCompleted => 'Completed';

  @override
  String get operatorGoAdminLogin => 'Admin analytics sign in';

  @override
  String get adminLoginTitle => 'Admin sign in';

  @override
  String get adminLoginSubtitle => 'Consortium analytics and reporting (US-07)';

  @override
  String get adminDashboardTitle => 'Analytics dashboard';

  @override
  String get adminDashboardSubtitle =>
      'Live metrics from Supabase — pilgrims, groups, and field status.';

  @override
  String get adminDashboardLoadError => 'Could not load dashboard metrics.';

  @override
  String get adminStatPilgrims => 'Pilgrims';

  @override
  String get adminStatOperators => 'Field operators';

  @override
  String get adminStatRitualProgress => 'Ritual completion';

  @override
  String get adminChartPilgrimsByGroup => 'Pilgrims by group';

  @override
  String get adminChartFieldStatus => 'Field status distribution';

  @override
  String get adminChartOperatorUploads => 'Documents uploaded by operator';

  @override
  String get adminChartEmpty => 'No data yet.';

  @override
  String get adminUnassignedGroup => 'Unassigned';

  @override
  String get adminUnknownOperator => 'Unknown operator';
}
