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
  String get authErrorNetworkConnection =>
      'Cannot reach Supabase. Check that local Supabase is running and your network (try without VPN).';

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
  String get toolsVirtualTourTitle => 'Haram guide';

  @override
  String get toolsVirtualTourSubtitle =>
      'Real map, ritual guide, and Makkah panorama';

  @override
  String get toolsVirtualTourLoadError => 'Could not load the panorama.';

  @override
  String get toolsVirtualTourTabGuide => 'Guide';

  @override
  String get toolsVirtualTourTabMap => 'Map';

  @override
  String get toolsVirtualTourTabPanorama => 'Panorama';

  @override
  String get toolsVirtualTourDisclaimer =>
      'For guidance only — not a substitute for performing Hajj on site.';

  @override
  String get toolsVirtualTourGuideHeading => 'Haram landmarks & rituals';

  @override
  String get toolsVirtualTourStepsLabel => 'Steps';

  @override
  String get toolsVirtualTourTipsLabel => 'Practical tips';

  @override
  String get toolsVirtualTourRitualLabel => 'Rite';

  @override
  String get toolsVirtualTourMapHint =>
      'OpenStreetMap — tap a marker for details. Internet required for first load.';

  @override
  String get toolsVirtualTourCenterKaaba => 'Center on Kaaba';

  @override
  String get toolsVirtualTourPanoramaHint =>
      'Aerial Makkah panorama from Abraj Al-Bait — drag and pinch to explore.';

  @override
  String get toolsVirtualTourPanoramaGestures =>
      'Drag with one finger or pinch to zoom';

  @override
  String get toolsVirtualTourPanoramaCredit =>
      'Panorama: Wurzelgnohm / Wikimedia Commons (CC0)';

  @override
  String get toolsVirtualTourPhotoCredit =>
      'Kaaba photo: GusJuned / Wikimedia Commons';

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
  String get fieldOperatorDashboardTitle => 'Field dashboard';

  @override
  String get fieldOperatorPilgrimsTitle => 'Pilgrims';

  @override
  String get fieldOperatorNavHome => 'Home';

  @override
  String get fieldOperatorNavPilgrims => 'Pilgrims';

  @override
  String get fieldOperatorStatsHint =>
      'Tap a card to open the filtered pilgrim list.';

  @override
  String fieldOperatorWelcome(String name) {
    return 'Welcome, $name';
  }

  @override
  String fieldOperatorWelcomeSubtitle(int total) {
    return '$total pilgrims registered in your groups.';
  }

  @override
  String get fieldOperatorProgressTitle => 'Completion overview';

  @override
  String fieldOperatorProgressSummary(
    int completed,
    int inProgress,
    int total,
  ) {
    return '$completed completed · $inProgress in progress · $total total';
  }

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
  String get fieldOperatorStatsTitle => 'Field overview';

  @override
  String get fieldOperatorStatsTotal => 'Total pilgrims';

  @override
  String get fieldOperatorStatsWheelchair => 'Wheelchair';

  @override
  String get fieldOperatorFilterAll => 'All';

  @override
  String get fieldOperatorSearchHintExtended =>
      'Search by name, passport, visa, sticker, or phone';

  @override
  String get pilgrimProfileTitle => 'My registration profile';

  @override
  String get pilgrimProfileEmpty =>
      'Your registration details are not available yet.';

  @override
  String get pilgrimYes => 'Yes';

  @override
  String get pilgrimNo => 'No';

  @override
  String get pilgrimNotProvided => 'Not provided';

  @override
  String get pilgrimSectionIdentity => 'Identity & registration';

  @override
  String get pilgrimSectionTravelDocs => 'Travel documents';

  @override
  String get pilgrimSectionPersonal => 'Personal information';

  @override
  String get pilgrimSectionHousing => 'Request & housing';

  @override
  String get pilgrimSectionHealth => 'Health';

  @override
  String get pilgrimSectionMakkah => 'Makkah accommodation';

  @override
  String get pilgrimSectionMadinah => 'Madinah accommodation';

  @override
  String get pilgrimSectionDepartureFlight => 'Outbound flight';

  @override
  String get pilgrimSectionReturnFlight => 'Return flight';

  @override
  String get pilgrimSectionHolySites => 'Holy sites (Mina & Arafat)';

  @override
  String get pilgrimSectionContact => 'Contact';

  @override
  String get pilgrimSectionNotes => 'Notes';

  @override
  String get pilgrimLabelSequence => 'Sequence';

  @override
  String get pilgrimLabelCluster => 'Cluster';

  @override
  String get pilgrimLabelCoordinator => 'Coordinator';

  @override
  String get pilgrimLabelSticker => 'Sticker no.';

  @override
  String get pilgrimLabelVisa => 'Visa no.';

  @override
  String get pilgrimLabelBarcode => 'Barcode';

  @override
  String get pilgrimLabelFullNameAr => 'Full name (Arabic)';

  @override
  String get pilgrimLabelMotherAr => 'Mother\'s name (Arabic)';

  @override
  String get pilgrimLabelBirthDate => 'Date of birth';

  @override
  String get pilgrimLabelFirstNameEn => 'First name (English)';

  @override
  String get pilgrimLabelLastNameEn => 'Last name (English)';

  @override
  String get pilgrimLabelFatherEn => 'Father\'s name (English)';

  @override
  String get pilgrimLabelMotherEn => 'Mother\'s name (English)';

  @override
  String get pilgrimLabelPassportIssue => 'Passport issue date';

  @override
  String get pilgrimLabelPassportExpiry => 'Passport expiry date';

  @override
  String get pilgrimLabelGender => 'Gender';

  @override
  String get pilgrimLabelBodySize => 'Body size';

  @override
  String get pilgrimLabelGroup => 'Group';

  @override
  String get pilgrimLabelCompanion => 'Companion';

  @override
  String get pilgrimLabelRelation => 'Relation';

  @override
  String get pilgrimLabelRequestType => 'Request type';

  @override
  String get pilgrimLabelHousingType => 'Housing type';

  @override
  String get pilgrimLabelHadyStatus => 'Hady status';

  @override
  String get pilgrimLabelResidence => 'Residence';

  @override
  String get pilgrimLabelHealthStatus => 'Health status';

  @override
  String get pilgrimLabelWheelchair => 'Wheelchair needed';

  @override
  String get pilgrimLabelSmoking => 'Smoking';

  @override
  String get pilgrimLabelHealthCard => 'Health card';

  @override
  String get pilgrimLabelVaccinated => 'Vaccinated';

  @override
  String get pilgrimLabelMakkahHotel => 'Makkah hotel';

  @override
  String get pilgrimLabelMakkahFloor => 'Makkah floor';

  @override
  String get pilgrimLabelMakkahRoom => 'Makkah room';

  @override
  String get pilgrimLabelMadinahTravel => 'Travel date to Madinah';

  @override
  String get pilgrimLabelMadinahHotel => 'Madinah hotel';

  @override
  String get pilgrimLabelMadinahFloor => 'Madinah floor';

  @override
  String get pilgrimLabelMadinahRoom => 'Madinah room';

  @override
  String get pilgrimLabelDepartureAirport => 'Departure airport';

  @override
  String get pilgrimLabelDepartureAirline => 'Departure airline';

  @override
  String get pilgrimLabelDepartureFlight => 'Departure flight no.';

  @override
  String get pilgrimLabelDepartureDate => 'Departure date';

  @override
  String get pilgrimLabelDepartureTime => 'Departure time';

  @override
  String get pilgrimLabelReturnAirport => 'Return airport';

  @override
  String get pilgrimLabelReturnAirline => 'Return airline';

  @override
  String get pilgrimLabelReturnFlight => 'Return flight no.';

  @override
  String get pilgrimLabelReturnDate => 'Return date';

  @override
  String get pilgrimLabelReturnTime => 'Return time';

  @override
  String get pilgrimLabelServiceCenter => 'Service center';

  @override
  String get pilgrimLabelCenterArafat => 'Arafat service center';

  @override
  String get pilgrimLabelCenterMina => 'Mina service center';

  @override
  String get pilgrimLabelBusArafat => 'Arafat bus';

  @override
  String get pilgrimLabelBusMina => 'Mina bus';

  @override
  String get pilgrimLabelTentArafat => 'Arafat tent';

  @override
  String get pilgrimLabelTentMina => 'Mina tent';

  @override
  String get pilgrimLabelPhone => 'Phone';

  @override
  String get pilgrimLabelWhatsapp => 'WhatsApp';

  @override
  String get pilgrimLabelSyrianPhone => 'Syrian phone';

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

  @override
  String get adminManageContent => 'Manage content library';

  @override
  String get adminContentListTitle => 'Content library';

  @override
  String get adminContentAdd => 'Add content';

  @override
  String get adminContentEdit => 'Edit';

  @override
  String get adminContentNewTitle => 'New content';

  @override
  String get adminContentEditTitle => 'Edit content';

  @override
  String get adminContentLoadError => 'Could not load content.';

  @override
  String get adminContentEmpty => 'No content yet. Add your first item.';

  @override
  String get adminContentNotFound => 'Content item not found.';

  @override
  String get adminContentTitleLabel => 'Title';

  @override
  String get adminContentTitleRequired => 'Enter a title';

  @override
  String get adminContentDescriptionLabel => 'Description';

  @override
  String get adminContentMediaUrlLabel => 'Media URL (optional)';

  @override
  String get adminContentTypeLabel => 'Type';

  @override
  String get adminContentVisibilityLabel => 'Visibility';

  @override
  String get adminContentTypeVideo => 'Video';

  @override
  String get adminContentTypeNews => 'News';

  @override
  String get adminContentTypeAnnouncement => 'Announcement';

  @override
  String get adminContentVisibilityPublic => 'Public (everyone)';

  @override
  String get adminContentVisibilityPilgrimOnly => 'Pilgrims only';

  @override
  String get adminContentSave => 'Save';

  @override
  String get adminContentSaveSuccess => 'Content updated.';

  @override
  String get adminContentCreateSuccess => 'Content published.';

  @override
  String get adminContentSaveError => 'Could not save content.';

  @override
  String get adminContentDeleteTitle => 'Delete content?';

  @override
  String adminContentDeleteMessage(String title) {
    return 'Delete \"$title\"? This cannot be undone.';
  }

  @override
  String get adminContentDeleteConfirm => 'Delete';

  @override
  String get adminContentDeleteSuccess => 'Content deleted.';

  @override
  String get adminContentDeleteError => 'Could not delete content.';

  @override
  String get dialogCancel => 'Cancel';

  @override
  String get operatorPilgrimListTitle => 'Registered pilgrims';

  @override
  String get operatorPilgrimSearchHint =>
      'Search by name, passport, or permit number';

  @override
  String get operatorPilgrimListLoadError => 'Could not load pilgrim list.';

  @override
  String get operatorPilgrimListEmpty => 'No pilgrims registered yet.';

  @override
  String get operatorPilgrimNoLogisticsYet => 'No logistics on file';

  @override
  String get operatorPilgrimDetailTitle => 'Pilgrim record';

  @override
  String get operatorPilgrimDetailSubtitle =>
      'Update travel and accommodation details (desk operator).';

  @override
  String get operatorPilgrimNotFound => 'Pilgrim not found.';

  @override
  String get operatorPilgrimTravelDateUnset => 'Not set';

  @override
  String get operatorPilgrimSave => 'Save changes';

  @override
  String get operatorPilgrimSaveSuccess => 'Pilgrim record updated.';

  @override
  String get operatorPilgrimSaveError => 'Could not save changes.';

  @override
  String get homeCompetitions => 'Competitions';

  @override
  String get competitionsTitle => 'Competitions';

  @override
  String get competitionsLoadError => 'Could not load competitions.';

  @override
  String get competitionsEmpty => 'No active competitions right now.';

  @override
  String get competitionsNoDescription => 'No description';

  @override
  String get competitionDetailTitle => 'Competition';

  @override
  String get competitionNotFound => 'Competition not found.';

  @override
  String get competitionSignInRequired =>
      'Sign in as a pilgrim to join and earn points.';

  @override
  String get competitionClosed => 'This competition is not open for entries.';

  @override
  String get competitionJoin => 'Join competition';

  @override
  String get competitionJoinSuccess => 'You joined the competition.';

  @override
  String get competitionJoinError =>
      'Could not join. Sign in as a pilgrim or try again.';

  @override
  String competitionYourScore(int score) {
    return 'Your score: $score points';
  }

  @override
  String get competitionRecordProgress => 'Record progress (+10)';

  @override
  String get competitionProgressRecorded => 'Progress recorded.';

  @override
  String get competitionProgressError => 'Could not update score.';

  @override
  String get competitionLeaderboard => 'Leaderboard';

  @override
  String get competitionLeaderboardEmpty => 'No participants yet.';

  @override
  String get competitionAnonymous => 'Pilgrim';

  @override
  String competitionPoints(int score) {
    return '$score pts';
  }

  @override
  String get adminManageCompetitions => 'Manage competitions';

  @override
  String get adminCompetitionsTitle => 'Competitions';

  @override
  String get adminCompetitionAdd => 'Add competition';

  @override
  String get adminCompetitionsLoadError => 'Could not load competitions.';

  @override
  String get adminCompetitionsEmpty => 'No competitions yet.';

  @override
  String get adminCompetitionNewTitle => 'New competition';

  @override
  String get adminCompetitionEditTitle => 'Edit competition';

  @override
  String get adminCompetitionStartsAt => 'Starts';

  @override
  String get adminCompetitionEndsAt => 'Ends';

  @override
  String get adminCompetitionActiveLabel => 'Active';

  @override
  String get adminCompetitionInactive => 'Inactive';

  @override
  String get adminCompetitionActive => 'Published';

  @override
  String get adminCompetitionSaveSuccess => 'Competition saved.';

  @override
  String get adminCompetitionSaveError => 'Could not save competition.';

  @override
  String get adminCompetitionDeleteTitle => 'Delete competition?';

  @override
  String adminCompetitionDeleteMessage(String title) {
    return 'Delete \"$title\"?';
  }

  @override
  String get adminCompetitionDeleteConfirm => 'Delete';

  @override
  String get adminCompetitionDeleteSuccess => 'Competition deleted.';

  @override
  String get adminCompetitionDeleteError => 'Could not delete competition.';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsOpenInbox => 'Notifications';

  @override
  String get notificationsEmpty => 'No notifications yet.';

  @override
  String get notificationsLoadError => 'Could not load notifications.';

  @override
  String get notificationsMarkAllRead => 'Mark all read';

  @override
  String get adminSendNotification => 'Send notification';

  @override
  String get adminNotificationSendTitle => 'Broadcast notification';

  @override
  String get adminNotificationAudienceLabel => 'Audience';

  @override
  String get adminNotificationAudienceAllPilgrims => 'All pilgrims';

  @override
  String get adminNotificationAudienceGroup => 'Group';

  @override
  String get adminNotificationAudienceOperators => 'All operators';

  @override
  String get adminNotificationGroupLabel => 'Group';

  @override
  String get adminNotificationGroupRequired => 'Select a group.';

  @override
  String get adminNotificationGroupsLoadError => 'Could not load groups.';

  @override
  String get adminNotificationGroupsEmpty => 'No groups defined yet.';

  @override
  String get adminNotificationTitleAr => 'Title (Arabic)';

  @override
  String get adminNotificationTitleEn => 'Title (English)';

  @override
  String get adminNotificationTitleRequired => 'Title is required.';

  @override
  String get adminNotificationBodyAr => 'Message (Arabic, optional)';

  @override
  String get adminNotificationBodyEn => 'Message (English, optional)';

  @override
  String get adminNotificationSendButton => 'Send';

  @override
  String adminNotificationSendSuccess(int count) {
    return 'Sent to $count recipients.';
  }

  @override
  String get adminNotificationSendError => 'Could not send notification.';

  @override
  String get languageSwitcherTitle => 'Choose language';

  @override
  String get languageSwitcherSubtitle => 'Your choice is saved for next time';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageArabicSubtitle => 'Arabic';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageEnglishSubtitle => 'الإنجليزية';

  @override
  String get languageArabicShort => 'عربي';

  @override
  String get languageEnglishShort => 'EN';

  @override
  String toolsQuranSurahSubtitle(String name, int count, String ayahsLabel) {
    return '$name · $count $ayahsLabel';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navGuidance => 'Guidance';

  @override
  String get navServices => 'Services';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeNextPrayer => 'Next Prayer';

  @override
  String get homePrayerLocation => 'Makkah, KSA';

  @override
  String get homeQuickActionsTitle => 'Quick tools';

  @override
  String get homeSeeAll => 'See All →';

  @override
  String get homeJourneyTitle => 'Begin Your Sacred Journey';

  @override
  String get homeJourneyBody =>
      'Contact us to inquire about registration. If the technical team provided your account credentials, enter them to sign in.';

  @override
  String get homeContactUs => 'Contact us';

  @override
  String get homeEnterRegistration => 'Enter registration details';

  @override
  String get homeRegisterNow => 'Register Now';

  @override
  String get homeNewsSeeAll => 'See All →';

  @override
  String get contentImportantTag => 'Important';

  @override
  String contentHoursAgo(int hours) {
    return '$hours Hours Ago';
  }

  @override
  String get profileGuestTitle => 'Guest';

  @override
  String get profileGuestBody =>
      'Sign in to access your Hajj journey, rituals, and personalized content.';

  @override
  String get notificationsLatestUpdates => 'Latest Updates';

  @override
  String get notificationsFilterAll => 'All';

  @override
  String get notificationsFilterGeneral => 'General News';

  @override
  String get notificationsFilterUrgent => 'Urgent Alerts';

  @override
  String get notificationsUrgentBadge => 'Urgent Alert!';

  @override
  String notificationsMinutesAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String get staffNavHome => 'Home';

  @override
  String get staffNavPilgrims => 'Pilgrims';

  @override
  String get staffNavContent => 'Content Management';

  @override
  String get staffNavCompetitions => 'Competitions';

  @override
  String get staffNavNotifications => 'Notifications';

  @override
  String get staffPortalSubtitle => 'Admin Portal';

  @override
  String get staffDefaultUser => 'Administrator';

  @override
  String get staffAdminRole => 'Chief Coordinator';

  @override
  String get staffConnectedStatus => 'Connected';

  @override
  String get staffActiveNow => 'Active now';

  @override
  String get staffStable => 'Stable';
}
