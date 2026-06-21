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
  String get contentTopicsSection => 'Educational topics';

  @override
  String get contentNewsSection => 'News & announcements';

  @override
  String get contentVideosEmpty => 'No public videos available yet.';

  @override
  String get contentTopicsEmpty => 'No educational topics available yet.';

  @override
  String get contentTopicNotFound => 'This topic was not found.';

  @override
  String get contentTopicMediaTitle => 'Media series';

  @override
  String get contentTopicNoMedia => 'No media yet.';

  @override
  String contentTopicVideoCount(int count) {
    return '$count videos';
  }

  @override
  String contentTopicAudioCount(int count) {
    return '$count audio';
  }

  @override
  String contentTopicImageCount(int count) {
    return '$count images';
  }

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
      'Center technician — pilgrim registration and documents';

  @override
  String get staffLoginHighlightRegistration =>
      'Register pilgrims and upload documents';

  @override
  String get staffLoginHighlightDocuments =>
      'Secure document storage per pilgrim';

  @override
  String get staffLoginHighlightRegistry =>
      'Manage pilgrim registry in real time';

  @override
  String get staffLoginHighlightAnalytics =>
      'Live dashboards and field status charts';

  @override
  String get staffLoginHighlightContent =>
      'Publish videos, news, and announcements';

  @override
  String get staffLoginHighlightNotifications =>
      'Broadcast alerts to pilgrims and staff';

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
  String get operatorDocumentsUploadFailed =>
      'Account created, but some documents failed to upload. You can re-upload them later.';

  @override
  String get operatorSharedDefaultsTitle => 'Shared defaults';

  @override
  String get operatorSharedDefaultsHint =>
      'Shared fields (hotel, trip, dates, mashaer…) are saved automatically and pre-filled for the next pilgrim to speed up entry.';

  @override
  String get operatorClearSharedDefaults => 'Clear shared defaults';

  @override
  String get operatorSendCredentialsWhatsapp => 'Send login info via WhatsApp';

  @override
  String get operatorResetSendConfirmTitle => 'Send login info';

  @override
  String operatorResetSendConfirmBody(String name) {
    return 'A new password will be generated for $name and sent over WhatsApp. Continue?';
  }

  @override
  String get operatorResetSendConfirm => 'Reset & send';

  @override
  String get operatorResetFailed => 'Could not reset the password.';

  @override
  String get operatorWhatsappOpenFailed => 'Could not open WhatsApp.';

  @override
  String get operatorWhatsappNoNumber => 'No WhatsApp number on file.';

  @override
  String operatorCredentialsWhatsappMessage(String email, String password) {
    return 'Hello, your Rafiq Al-Hajj login details:\nEmail: $email\nPassword: $password';
  }

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
      'Search pilgrims and update logistics in the field';

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
  String get adminLoginSubtitle => 'Consortium analytics and reporting';

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
  String get competitionAnswerTrue => 'True';

  @override
  String get competitionAnswerFalse => 'False';

  @override
  String get competitionQuizTitle => 'Quiz';

  @override
  String get competitionQuizLoadError => 'Could not load quiz questions.';

  @override
  String get competitionQuizNoQuestions =>
      'No questions have been added to this competition yet.';

  @override
  String competitionQuizProgress(int answered, int total) {
    return '$answered of $total questions answered';
  }

  @override
  String get competitionQuizStart => 'Start quiz';

  @override
  String get competitionQuizContinue => 'Continue quiz';

  @override
  String get competitionQuizReview => 'Review answers';

  @override
  String get competitionQuizSubmit => 'Check answer';

  @override
  String get competitionQuizSubmitError =>
      'Could not submit your answer. Try again.';

  @override
  String competitionQuizCorrect(int points) {
    return 'Correct! +$points points';
  }

  @override
  String get competitionQuizIncorrect =>
      'Not quite — review the explanation below.';

  @override
  String get competitionQuizComplete => 'Lesson complete!';

  @override
  String competitionQuizCompleteSummary(int count) {
    return 'You answered $count questions in this competition.';
  }

  @override
  String get competitionQuizDone => 'Back to competition';

  @override
  String competitionQuizQuestionBadge(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get competitionPathTitle => 'Learning path';

  @override
  String get competitionPathSubtitle =>
      'Complete each lesson in order to earn points.';

  @override
  String get competitionLessonLocked => 'Complete the previous lesson first.';

  @override
  String get competitionLearnBadge => 'Interactive learning';

  @override
  String get competitionLearnHeroTitle => 'Learn Hajj rituals playfully';

  @override
  String get competitionLearnHeroSubtitle =>
      'Answer questions, track your progress, and climb the leaderboard.';

  @override
  String get competitionStatusOpen => 'Open now';

  @override
  String get competitionStatusUpcoming => 'Coming soon';

  @override
  String get competitionJoinPrompt =>
      'Join this competition to start earning points.';

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
  String get adminCompetitionQuestionsTitle => 'Questions';

  @override
  String get adminCompetitionQuestionAdd => 'Add question';

  @override
  String get adminCompetitionQuestionsEmpty =>
      'No questions yet. Add multiple-choice or true/false questions.';

  @override
  String get adminCompetitionQuestionsLoadError => 'Could not load questions.';

  @override
  String get adminCompetitionQuestionNewTitle => 'New question';

  @override
  String get adminCompetitionQuestionEditTitle => 'Edit question';

  @override
  String get adminCompetitionQuestionTypeLabel => 'Question type';

  @override
  String get adminCompetitionQuestionTypeMultipleChoice => 'Multiple choice';

  @override
  String get adminCompetitionQuestionTypeTrueFalse => 'True or false';

  @override
  String get adminCompetitionQuestionTypeOrdering => 'Order the steps';

  @override
  String get adminCompetitionQuestionOrderingStepsLabel =>
      'Steps (top = first)';

  @override
  String get adminCompetitionQuestionOrderingStepsHint =>
      'Drag to set the correct order pilgrims should follow.';

  @override
  String adminCompetitionQuestionStepLabel(int number) {
    return 'Step $number';
  }

  @override
  String get adminCompetitionQuestionAddStep => 'Add step';

  @override
  String get competitionOrderingHint =>
      'Drag the cards into the correct order.';

  @override
  String competitionQuizOrderingBadge(int current, int total) {
    return 'Order · $current/$total';
  }

  @override
  String get adminCompetitionQuestionPromptLabel => 'Question';

  @override
  String get adminCompetitionQuestionPromptRequired =>
      'Question text is required.';

  @override
  String get adminCompetitionQuestionExplanationLabel =>
      'Explanation (shown after answering)';

  @override
  String get adminCompetitionQuestionPointsLabel => 'Points for correct answer';

  @override
  String get adminCompetitionQuestionPointsInvalid =>
      'Enter a positive number of points.';

  @override
  String adminCompetitionQuestionPoints(int points) {
    return '$points pts';
  }

  @override
  String get adminCompetitionQuestionOptionsLabel => 'Answer options';

  @override
  String adminCompetitionQuestionOptionLabel(int number) {
    return 'Option $number';
  }

  @override
  String get adminCompetitionQuestionOptionRequired =>
      'Option text is required.';

  @override
  String get adminCompetitionQuestionSaveError => 'Could not save question.';

  @override
  String get adminCompetitionQuestionDeleteTitle => 'Delete question?';

  @override
  String get adminCompetitionQuestionDeleteMessage =>
      'This question and its answers will be removed.';

  @override
  String get adminCompetitionQuestionDeleteConfirm => 'Delete';

  @override
  String get adminCompetitionQuestionDeleteSuccess => 'Question deleted.';

  @override
  String get adminCompetitionQuestionDeleteError =>
      'Could not delete question.';

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
  String get staffNavOperators => 'Operators';

  @override
  String get staffNavGroups => 'Groups';

  @override
  String get staffNavContent => 'Content Management';

  @override
  String get staffNavCompetitions => 'Competitions';

  @override
  String get staffNavNotifications => 'Notifications';

  @override
  String get staffNavSettings => 'Settings';

  @override
  String get staffPortalSubtitle => 'Admin Portal';

  @override
  String get staffDefaultUser => 'Administrator';

  @override
  String get staffAdminRole => 'Chief Coordinator';

  @override
  String get staffConnectedStatus => 'Connected';

  @override
  String get staffOfflineStatus => 'Offline';

  @override
  String get staffOfflineBanner =>
      'You appear to be offline. Some actions may not work until connectivity is restored.';

  @override
  String get staffErrorNetwork =>
      'Could not reach the server. Check your internet connection and try again.';

  @override
  String get staffErrorPermission =>
      'You do not have permission to perform this action.';

  @override
  String get staffErrorGeneric => 'Something went wrong. Please try again.';

  @override
  String get staffActiveNow => 'Active now';

  @override
  String get staffStable => 'Stable';

  @override
  String get staffNavRegister => 'Register pilgrim';

  @override
  String get staffOperatorPortalSubtitle => 'Operator Portal';

  @override
  String get staffOperatorRole => 'Center technician';

  @override
  String get operatorSectionPersonalInfo => 'Personal information';

  @override
  String get operatorSectionPersonalInfoHint =>
      'Full legal name as shown on passport.';

  @override
  String get operatorSectionAccount => 'Mobile account';

  @override
  String get operatorSectionAccountHint =>
      'Credentials for the pilgrim mobile app.';

  @override
  String get operatorSectionDocumentsHint =>
      'Upload passport, permit, or medical files (PDF or images).';

  @override
  String get operatorSectionLogisticsHint =>
      'Travel and accommodation details (optional at registration).';

  @override
  String get operatorClearForm => 'Clear form';

  @override
  String get operatorPilgrimListSubtitle =>
      'Search and manage registered pilgrims.';

  @override
  String get adminNotificationSendSubtitle =>
      'Compose and broadcast a bilingual notification.';

  @override
  String get adminNotificationContentSection => 'Message content';

  @override
  String get adminOperatorsTitle => 'Operator management';

  @override
  String get adminOperatorsSubtitle =>
      'Add operators and control their roles and permissions.';

  @override
  String get adminOperatorAdd => 'Add operator';

  @override
  String get adminOperatorNewTitle => 'New operator';

  @override
  String get adminOperatorEditTitle => 'Edit operator';

  @override
  String get adminOperatorFullName => 'Full name';

  @override
  String get adminOperatorFullNameRequired => 'Full name is required';

  @override
  String get adminOperatorEmail => 'Email';

  @override
  String get adminOperatorEmailRequired => 'Email is required';

  @override
  String get adminOperatorEmailInvalid => 'Enter a valid email address';

  @override
  String get adminOperatorActive => 'Account active';

  @override
  String get adminOperatorActiveLabel => 'Active';

  @override
  String get adminOperatorInactive => 'Inactive';

  @override
  String get adminOperatorPermissionsSection => 'Roles & permissions';

  @override
  String get adminOperatorPermRegister => 'Register pilgrims';

  @override
  String get adminOperatorPermRegisterHint =>
      'Allow pilgrim intake and mobile account creation.';

  @override
  String get adminOperatorPermRegistry => 'Manage pilgrim registry';

  @override
  String get adminOperatorPermRegistryHint =>
      'View and edit registered pilgrims.';

  @override
  String get adminOperatorPermField => 'Field operator tools';

  @override
  String get adminOperatorPermFieldHint =>
      'Access the field operator portal and on-site workflows.';

  @override
  String get adminOperatorPermUpload => 'Upload documents';

  @override
  String get adminOperatorPermUploadHint =>
      'Upload pilgrim documents during registration.';

  @override
  String get adminOperatorGroupsSection => 'Group access';

  @override
  String get adminOperatorGroupsHint =>
      'Choose which travel offices (groups) this operator can read and write.';

  @override
  String get adminOperatorGroupsEmpty => 'No groups available yet.';

  @override
  String get adminOperatorGroupRead => 'Read';

  @override
  String get adminOperatorGroupWrite => 'Read & write';

  @override
  String get adminOperatorGeneratePassword => 'Generate password';

  @override
  String get adminOperatorPasswordLabel => 'Password';

  @override
  String get adminOperatorPasswordCreateHint =>
      'Leave blank to auto-generate a secure password.';

  @override
  String get adminOperatorPasswordEditHint =>
      'Leave blank to keep the current password.';

  @override
  String get adminOperatorCopyPassword => 'Copy password';

  @override
  String get adminOperatorCreateSuccess => 'Operator account created';

  @override
  String get adminOperatorSaveSuccess => 'Operator updated';

  @override
  String get adminOperatorSaveError => 'Could not save operator. Try again.';

  @override
  String get adminOperatorLoadError => 'Could not load operators.';

  @override
  String get adminOperatorEmpty =>
      'No operators yet. Add your first center technician.';

  @override
  String get staffTableEmpty => 'No results found';

  @override
  String get staffTableRowsPerPage => 'Rows per page';

  @override
  String get staffTablePreviousPage => 'Previous page';

  @override
  String get staffTableNextPage => 'Next page';

  @override
  String staffTableShowing(int from, int to, int total) {
    return 'Showing $from–$to of $total';
  }

  @override
  String staffTablePageOf(int current, int total) {
    return 'Page $current of $total';
  }

  @override
  String get staffTableFilterAll => 'All';

  @override
  String get staffTableColumnsTitle => 'Table columns';

  @override
  String get staffTableColumnsApply => 'Apply';

  @override
  String get staffTableColumnsShowAll => 'Show all';

  @override
  String get staffTableColumnsCustomize => 'Columns';

  @override
  String get staffTableColumnRequired => 'Always visible';

  @override
  String get staffTableFilterStatus => 'Status';

  @override
  String get staffTableColumnCreated => 'Created';

  @override
  String get staffTableSearchOperators => 'Search by name or email';

  @override
  String get staffTableSearchContent => 'Search by title or description';

  @override
  String get staffTableSearchCompetitions => 'Search by title or description';

  @override
  String get staffTableSearchGroups => 'Search by group or president name';

  @override
  String get staffTableFilterGender => 'Gender';

  @override
  String get staffTableFilterGroup => 'Group';

  @override
  String staffTableSelectedCount(int count) {
    return '$count selected';
  }

  @override
  String get staffTableClearSelection => 'Clear selection';

  @override
  String get pilgrimGenderMale => 'Male';

  @override
  String get pilgrimGenderFemale => 'Female';

  @override
  String get adminPilgrimAdd => 'Add pilgrim';

  @override
  String get adminPilgrimProfileSection => 'Pilgrim profile';

  @override
  String get adminPilgrimBulkAssignGroup => 'Assign group';

  @override
  String get adminPilgrimBulkClearGroup => 'Clear group';

  @override
  String get adminPilgrimAssignGroupTitle =>
      'Assign group to selected pilgrims';

  @override
  String get adminPilgrimAssignGroupConfirm => 'Assign';

  @override
  String get adminPilgrimAssignGroupSuccess =>
      'Group updated for selected pilgrims';

  @override
  String get adminPilgrimAssignGroupError =>
      'Could not update group assignment';

  @override
  String get adminPilgrimNoGroups =>
      'No groups available. Create a group first.';

  @override
  String get adminGroupsTitle => 'Group management';

  @override
  String get adminGroupsSubtitle =>
      'Manage Hajj groups, leadership, and administration members.';

  @override
  String get adminGroupAdd => 'Add group';

  @override
  String get adminGroupNewTitle => 'New group';

  @override
  String get adminGroupEditTitle => 'Edit group';

  @override
  String get adminGroupDetailsSection => 'Group details';

  @override
  String get adminGroupName => 'Group name';

  @override
  String get adminGroupNameRequired => 'Group name is required';

  @override
  String get adminGroupUploadLogo => 'Upload logo';

  @override
  String get adminGroupPresidentName => 'President name';

  @override
  String get adminGroupPresidentPhone => 'President phone';

  @override
  String get adminGroupMembersSection => 'Administration members';

  @override
  String get adminGroupMembersSectionHint =>
      'Add coordinators and staff with their roles and contact details.';

  @override
  String get adminGroupAddMember => 'Add member';

  @override
  String get adminGroupRemoveMember => 'Remove member';

  @override
  String get adminGroupMembersEmpty => 'No administration members yet.';

  @override
  String get adminGroupMemberName => 'Member name';

  @override
  String get adminGroupMemberNameRequired => 'Member name is required';

  @override
  String get adminGroupMemberPosition => 'Position';

  @override
  String get adminGroupMemberContact => 'Contact';

  @override
  String get adminGroupUploadPhoto => 'Upload photo';

  @override
  String get adminGroupMembersCount => 'Members';

  @override
  String get adminGroupCreateSuccess => 'Group created';

  @override
  String get adminGroupSaveSuccess => 'Group updated';

  @override
  String get adminGroupSaveError => 'Could not save group. Try again.';

  @override
  String get adminGroupsLoadError => 'Could not load groups.';

  @override
  String get adminGroupsEmpty => 'No groups yet. Add your first Hajj group.';

  @override
  String get adminGroupDeleteTitle => 'Delete group?';

  @override
  String adminGroupDeleteMessage(String name) {
    return 'Delete \"$name\"? Pilgrims in this group will be unassigned.';
  }

  @override
  String get adminGroupDeleteConfirm => 'Delete';

  @override
  String get adminGroupDeleteSuccess => 'Group deleted';

  @override
  String get adminGroupDeleteError => 'Could not delete group';

  @override
  String get adminSettingsTitle => 'System settings';

  @override
  String get adminSettingsSubtitle =>
      'Configure organization details, features, and platform behavior.';

  @override
  String get adminSettingsSave => 'Save settings';

  @override
  String get adminSettingsSaveSuccess => 'Settings saved';

  @override
  String get adminSettingsSaveError => 'Could not save settings. Try again.';

  @override
  String get adminSettingsLoadError => 'Could not load settings.';

  @override
  String get adminSettingsOrganizationSection => 'Organization';

  @override
  String get adminSettingsOrganizationSectionHint =>
      'Public-facing name and support contacts for the Hajj season.';

  @override
  String get adminSettingsOrganizationName => 'Organization name';

  @override
  String get adminSettingsOrganizationNameRequired =>
      'Organization name is required';

  @override
  String get adminSettingsHajjSeason => 'Hajj season label';

  @override
  String get adminSettingsSupportEmail => 'Support email';

  @override
  String get adminSettingsSupportPhone => 'Support phone';

  @override
  String get adminSettingsOperationsSection => 'Operations';

  @override
  String get adminSettingsOperationsSectionHint =>
      'Control registration availability and maintenance windows.';

  @override
  String get adminSettingsRegistrationOpen => 'Registration open';

  @override
  String get adminSettingsRegistrationOpenHint =>
      'Allow operators to register new pilgrims.';

  @override
  String get adminSettingsMaintenanceMode => 'Maintenance mode';

  @override
  String get adminSettingsMaintenanceModeHint =>
      'Show a maintenance message and limit staff actions.';

  @override
  String get adminSettingsMaintenanceMessage => 'Maintenance message';

  @override
  String get adminSettingsIntakeSection => 'Pilgrim intake';

  @override
  String get adminSettingsIntakeSectionHint =>
      'Defaults for operator registration workflows.';

  @override
  String get adminSettingsRequireDocuments => 'Require documents on intake';

  @override
  String get adminSettingsRequireDocumentsHint =>
      'Operators must upload required documents when registering pilgrims.';

  @override
  String get adminSettingsAutoGeneratePassword =>
      'Auto-generate pilgrim passwords';

  @override
  String get adminSettingsAutoGeneratePasswordHint =>
      'Create secure passwords automatically during registration.';

  @override
  String get adminSettingsOperatorSelfRegistration =>
      'Allow operator self-registration';

  @override
  String get adminSettingsOperatorSelfRegistrationHint =>
      'Let new operators request accounts without admin approval.';

  @override
  String get adminSettingsMaxPilgrimsPerGroup => 'Max pilgrims per group';

  @override
  String get adminSettingsMaxPilgrimsPerGroupHint =>
      'Leave empty for no limit.';

  @override
  String get adminSettingsMaxPilgrimsInvalid =>
      'Enter a positive number or leave empty.';

  @override
  String get adminSettingsFeaturesSection => 'Features';

  @override
  String get adminSettingsFeaturesSectionHint =>
      'Enable or disable major app modules.';

  @override
  String get adminSettingsPublicContentFeed => 'Public content feed';

  @override
  String get adminSettingsPublicContentFeedHint =>
      'Show news and videos on the pilgrim home screen.';

  @override
  String get adminSettingsCompetitions => 'Competitions';

  @override
  String get adminSettingsCompetitionsHint =>
      'Allow pilgrims to view and join Hajj competitions.';

  @override
  String get adminSettingsRitualTracking => 'Pilgrim ritual tracking';

  @override
  String get adminSettingsRitualTrackingHint =>
      'Track and display ritual progress for pilgrims.';

  @override
  String get adminSettingsNotificationsSection => 'Notifications';

  @override
  String get adminSettingsNotificationsSectionHint =>
      'Control in-app and push notification delivery.';

  @override
  String get adminSettingsInAppNotifications => 'In-app notifications';

  @override
  String get adminSettingsInAppNotificationsHint =>
      'Deliver notifications inside the pilgrim inbox.';

  @override
  String get adminSettingsPushNotifications => 'Push notifications';

  @override
  String get adminSettingsPushNotificationsHint =>
      'Send Firebase push notifications to devices.';

  @override
  String get adminSettingsPushNotificationsUnavailable =>
      'Firebase is not configured. Push notifications cannot be enabled.';

  @override
  String get adminSettingsManagementSection => 'Management shortcuts';

  @override
  String get adminSettingsManagementSectionHint =>
      'Jump to related admin areas.';

  @override
  String get adminSettingsIntegrationsSection => 'Integrations';

  @override
  String get adminSettingsIntegrationsSectionHint =>
      'Backend services configured for this deployment.';

  @override
  String get adminSettingsSupabaseStatus => 'Supabase';

  @override
  String get adminSettingsFirebaseStatus => 'Firebase';

  @override
  String get adminSettingsStatusConfigured => 'Configured';

  @override
  String get adminSettingsStatusNotConfigured => 'Not configured';

  @override
  String adminSettingsLastUpdated(String date) {
    return 'Last updated $date';
  }

  @override
  String get profilePilgrimSubtitle =>
      'Registration details entered by your operator.';

  @override
  String get servicesHeroBadge => 'Pilgrim services';

  @override
  String get servicesHeroTitle => 'Services hub';

  @override
  String get servicesHeroSubtitle =>
      'Hajj journey and competitions in one place.';

  @override
  String get servicesJourneySubtitle =>
      'Learn Hajj rituals step by step with educational media.';

  @override
  String get servicesCompetitionsSubtitle =>
      'Test your knowledge and earn points in Hajj quizzes.';

  @override
  String get servicesNotificationsSubtitle =>
      'View your latest alerts and announcements.';

  @override
  String get hajjJourneyHeroSubtitle =>
      'Follow a learning path through Hajj rituals from Ihram to farewell tawaf.';

  @override
  String get hajjJourneyPathTitle => 'Ritual path';

  @override
  String get hajjJourneyPathSubtitle =>
      'Complete each ritual to unlock the next — like the competition track.';

  @override
  String get hajjJourneyEmpty => 'No journey steps available right now.';

  @override
  String get hajjJourneyLoadError => 'Could not load Hajj journey.';

  @override
  String get hajjJourneyStepLocked =>
      'Complete the previous ritual first to unlock this one.';

  @override
  String get hajjJourneyStepNotFound => 'This ritual was not found.';

  @override
  String get hajjJourneyContinue => 'Continue your current ritual';

  @override
  String get hajjJourneyAboutRitual => 'About this ritual';

  @override
  String get hajjJourneyMediaTitle => 'Educational media';

  @override
  String get hajjJourneyNoMedia => 'No media for this ritual yet.';

  @override
  String get hajjJourneyMediaVideo => 'Video';

  @override
  String get hajjJourneyMediaAudio => 'Audio';

  @override
  String get hajjJourneyMediaImage => 'Image';

  @override
  String hajjJourneyImageCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get hajjJourneySlideshowStart => 'Start slideshow';

  @override
  String get hajjJourneySlideshowStop => 'Stop slideshow';

  @override
  String get educationalMediaTitle => 'Educational media';

  @override
  String get educationalMediaEmpty => 'No media available.';

  @override
  String get educationalMediaVideo => 'Video';

  @override
  String get educationalMediaAudio => 'Audio';

  @override
  String get educationalMediaImage => 'Image';

  @override
  String educationalMediaImageCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get educationalMediaSlideshowStart => 'Start slideshow';

  @override
  String get educationalMediaSlideshowStop => 'Stop slideshow';

  @override
  String get adminContentTopicsManage => 'Educational topics';

  @override
  String get adminContentTopicsListTitle => 'Content topics';

  @override
  String get adminContentTopicAdd => 'Add topic';

  @override
  String get adminContentTopicEmpty => 'No topics yet.';

  @override
  String get adminContentTopicMediaItems => 'media';

  @override
  String get adminContentTopicLoadError => 'Could not load topics.';

  @override
  String get adminContentTopicDeleteTitle => 'Delete topic';

  @override
  String adminContentTopicDeleteMessage(String title) {
    return 'Delete \"$title\"?';
  }

  @override
  String get adminContentTopicDeleteSuccess => 'Topic deleted.';

  @override
  String get adminContentTopicDeleteError => 'Could not delete topic.';

  @override
  String get adminContentTopicEditTitle => 'Edit topic';

  @override
  String get adminContentTopicNewTitle => 'New topic';

  @override
  String get adminContentTopicTitleRequired => 'Enter a topic title.';

  @override
  String get adminContentTopicDescription => 'Description';

  @override
  String get adminContentTopicCoverUrl => 'Cover image URL';

  @override
  String get adminContentTopicMediaSection => 'Media series';

  @override
  String get adminContentTopicSaveSuccess => 'Topic saved.';

  @override
  String get adminContentTopicSaveError => 'Could not save topic.';

  @override
  String get adminContentTopicUploadCover => 'Upload cover image';

  @override
  String get adminContentTopicUploadMedia => 'Upload file';

  @override
  String get adminContentTopicUploadSuccess => 'File uploaded successfully.';

  @override
  String get adminContentTopicUploadError => 'Could not upload file.';

  @override
  String get adminContentTopicMediaPreview => 'Media preview';

  @override
  String get contentOfflineTitle => 'Offline content';

  @override
  String get contentOfflineSubtitle =>
      'Download educational topics (audio and images) for use without internet.';

  @override
  String get contentOfflineEnable => 'Enable automatic download';

  @override
  String get contentOfflineDownloading => 'Downloading in background…';

  @override
  String contentOfflineCachedCount(int count) {
    return '$count files saved locally';
  }

  @override
  String get contentOfflineClearCache => 'Clear saved content';

  @override
  String get contentTopicOfflineTitle => 'Offline use';

  @override
  String contentTopicOfflineProgress(int cached, int total) {
    return '$cached / $total files ready';
  }

  @override
  String get contentTopicOfflineDownload => 'Download';

  @override
  String get contentTopicOfflineStarted => 'Background download started.';

  @override
  String get hajjJourneyMarkComplete => 'Mark complete';

  @override
  String get hajjJourneyAlreadyCompleted => 'Completed — back to path';

  @override
  String get hajjJourneyCompletedSnack => 'Well done! Ritual marked complete.';

  @override
  String get hajjJourneyNextStepTitle => 'Next ritual';

  @override
  String get hajjJourneyNextStepBody =>
      'Would you like to go to the next ritual?';

  @override
  String get hajjJourneyStayHere => 'Stay here';

  @override
  String get hajjJourneyGoNext => 'Next ritual';

  @override
  String get adminManageHajjJourney => 'Manage Hajj journey';

  @override
  String get adminHajjJourneyTitle => 'Hajj journey';

  @override
  String get adminHajjJourneyLoadError => 'Could not load Hajj journey steps.';

  @override
  String get adminHajjJourneyEmpty =>
      'No steps yet. Apply the database migration.';

  @override
  String adminHajjJourneyMediaCount(int count) {
    return '$count media items';
  }

  @override
  String get adminHajjJourneyInactive => 'Inactive';

  @override
  String get adminHajjJourneyEditTitle => 'Edit ritual';

  @override
  String get adminHajjJourneyTitleAr => 'Title (Arabic)';

  @override
  String get adminHajjJourneyTitleEn => 'Title (English)';

  @override
  String get adminHajjJourneyDescriptionAr => 'Description (Arabic)';

  @override
  String get adminHajjJourneyDescriptionEn => 'Description (English)';

  @override
  String get adminHajjJourneySortOrder => 'Display order';

  @override
  String get adminHajjJourneyActive => 'Active';

  @override
  String get adminHajjJourneyMediaSection => 'Educational media';

  @override
  String get adminHajjJourneyMediaType => 'Media type';

  @override
  String get adminHajjJourneyMediaTitle => 'Media title';

  @override
  String get adminHajjJourneyMediaUrl => 'Media URL';

  @override
  String get adminHajjJourneyRemoveMedia => 'Remove';

  @override
  String get adminHajjJourneyTitleRequired =>
      'Arabic and English titles are required.';

  @override
  String get adminHajjJourneySaveSuccess => 'Ritual saved.';

  @override
  String get adminHajjJourneySaveError => 'Could not save ritual.';

  @override
  String get staffNavTrips => 'Trips';

  @override
  String get adminTripsTitle => 'Trip management';

  @override
  String get adminTripsSubtitle =>
      'Manage Hajj and Umrah trips per season and the offices that join them.';

  @override
  String get adminTripAdd => 'Add trip';

  @override
  String get adminTripsEmpty =>
      'No trips yet. Add your first Hajj or Umrah trip.';

  @override
  String get adminTripsLoadError => 'Could not load trips.';

  @override
  String get adminTripNewTitle => 'New trip';

  @override
  String get adminTripEditTitle => 'Edit trip';

  @override
  String get adminTripName => 'Trip name';

  @override
  String get adminTripNameRequired => 'Trip name is required';

  @override
  String get adminTripType => 'Trip type';

  @override
  String get adminTripTypeHajj => 'Hajj';

  @override
  String get adminTripTypeUmrah => 'Umrah';

  @override
  String get adminTripSeasonYear => 'Season year';

  @override
  String get adminTripSeasonYearRequired => 'A valid season year is required';

  @override
  String get adminTripStatus => 'Status';

  @override
  String get adminTripMarkActive => 'Set active';

  @override
  String get adminTripMarkFinished => 'Mark finished';

  @override
  String get adminTripStatusUpdated => 'Trip status updated';

  @override
  String get adminTripStatusPlanning => 'Planning';

  @override
  String get adminTripStatusActive => 'Active';

  @override
  String get adminTripStatusCompleted => 'Finished';

  @override
  String get adminTripStatusCancelled => 'Cancelled';

  @override
  String get adminTripSave => 'Save trip';

  @override
  String get adminTripCreateSuccess => 'Trip created';

  @override
  String get adminTripSaveSuccess => 'Trip updated';

  @override
  String get adminTripSaveError => 'Could not save trip. Try again.';

  @override
  String get adminTripDeleteTitle => 'Delete trip?';

  @override
  String adminTripDeleteMessage(String name) {
    return 'Delete \"$name\"? All enrollments in this trip will be removed.';
  }

  @override
  String get adminTripDeleteConfirm => 'Delete';

  @override
  String get adminTripDeleteSuccess => 'Trip deleted';

  @override
  String get adminTripDeleteError => 'Could not delete trip';

  @override
  String get adminTripManageOffices => 'Manage offices';

  @override
  String get adminTripOfficesTitle => 'Participating offices';

  @override
  String get adminTripOfficesSubtitle =>
      'Add or withdraw travel offices for this trip.';

  @override
  String get adminTripOfficesEmpty => 'No offices joined this trip yet.';

  @override
  String get adminTripAddOffice => 'Add office';

  @override
  String get adminTripNoAvailableOffices =>
      'All offices already joined this trip.';

  @override
  String get adminTripOfficeWithdraw => 'Withdraw';

  @override
  String get adminTripOfficeActivate => 'Reactivate';

  @override
  String get adminTripOfficeRemove => 'Remove';

  @override
  String get adminTripOfficeActive => 'Active';

  @override
  String get adminTripOfficeWithdrawn => 'Withdrawn';

  @override
  String get adminTripOfficeUpdated => 'Office updated';

  @override
  String get adminTripOfficeAdded => 'Office added to trip';

  @override
  String get adminTripOfficeError => 'Could not update office';

  @override
  String get tripSelectorLabel => 'Active trip';

  @override
  String get tripSelectorAll => 'All trips';
}
