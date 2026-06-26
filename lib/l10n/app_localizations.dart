import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Rafiq Al-Hajj'**
  String get appTitle;

  /// Home screen app bar title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Home screen welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome to your Hajj companion'**
  String get homeWelcome;

  /// Shown when navigation target does not exist
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get routeNotFoundTitle;

  /// Route not found body text
  ///
  /// In en, this message translates to:
  /// **'The page you requested could not be found.'**
  String get routeNotFoundMessage;

  /// Navigate back to home
  ///
  /// In en, this message translates to:
  /// **'Go home'**
  String get goHome;

  /// Title when application bootstrap fails
  ///
  /// In en, this message translates to:
  /// **'Unable to start the app'**
  String get bootstrapErrorTitle;

  /// Message when application bootstrap fails
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while starting Rafiq Al-Hajj. Please try again.'**
  String get bootstrapErrorMessage;

  /// Retry bootstrap action
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// Navigate to pilgrim login from guest home
  ///
  /// In en, this message translates to:
  /// **'Sign in as pilgrim'**
  String get homeSignInAsPilgrim;

  /// Welcome message when logged in as pilgrim
  ///
  /// In en, this message translates to:
  /// **'You are signed in. Browse public and exclusive content below.'**
  String get homePilgrimWelcome;

  /// US-01 public videos section title
  ///
  /// In en, this message translates to:
  /// **'Awareness videos'**
  String get contentVideosSection;

  /// Home section for thematic content topics
  ///
  /// In en, this message translates to:
  /// **'Educational topics'**
  String get contentTopicsSection;

  /// US-01 news section title
  ///
  /// In en, this message translates to:
  /// **'News & announcements'**
  String get contentNewsSection;

  /// Empty state for videos
  ///
  /// In en, this message translates to:
  /// **'No public videos available yet.'**
  String get contentVideosEmpty;

  /// Empty state for content topics
  ///
  /// In en, this message translates to:
  /// **'No educational topics available yet.'**
  String get contentTopicsEmpty;

  /// No description provided for @contentTopicNotFound.
  ///
  /// In en, this message translates to:
  /// **'This topic was not found.'**
  String get contentTopicNotFound;

  /// No description provided for @contentTopicMediaTitle.
  ///
  /// In en, this message translates to:
  /// **'Media series'**
  String get contentTopicMediaTitle;

  /// No description provided for @contentTopicNoMedia.
  ///
  /// In en, this message translates to:
  /// **'No media yet.'**
  String get contentTopicNoMedia;

  /// No description provided for @contentTopicVideoCount.
  ///
  /// In en, this message translates to:
  /// **'{count} videos'**
  String contentTopicVideoCount(int count);

  /// No description provided for @contentTopicAudioCount.
  ///
  /// In en, this message translates to:
  /// **'{count} audio'**
  String contentTopicAudioCount(int count);

  /// No description provided for @contentTopicImageCount.
  ///
  /// In en, this message translates to:
  /// **'{count} images'**
  String contentTopicImageCount(int count);

  /// Empty state for news
  ///
  /// In en, this message translates to:
  /// **'No news or announcements yet.'**
  String get contentNewsEmpty;

  /// Content fetch failed
  ///
  /// In en, this message translates to:
  /// **'Could not load content. Pull to refresh.'**
  String get contentLoadError;

  /// Shown when dart-defines are missing
  ///
  /// In en, this message translates to:
  /// **'Connect Supabase to load videos and news from the server.'**
  String get contentSupabaseRequired;

  /// Content detail app bar
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get contentDetailTitle;

  /// Missing content item
  ///
  /// In en, this message translates to:
  /// **'This content is no longer available.'**
  String get contentNotFound;

  /// Open external media URL
  ///
  /// In en, this message translates to:
  /// **'Open video or link'**
  String get contentOpenMedia;

  /// url_launcher failure
  ///
  /// In en, this message translates to:
  /// **'Could not open the link.'**
  String get contentOpenMediaFailed;

  /// Personalized greeting for signed-in pilgrim
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String homePilgrimGreeting(String name);

  /// Sign out action
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// Login screen app bar title
  ///
  /// In en, this message translates to:
  /// **'Pilgrim sign in'**
  String get loginTitle;

  /// Login screen instructions
  ///
  /// In en, this message translates to:
  /// **'Use the account credentials provided by your center'**
  String get loginSubtitle;

  /// Email field label on login
  ///
  /// In en, this message translates to:
  /// **'Account email'**
  String get loginEmailLabel;

  /// Password field label on login
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// Validation when email is empty
  ///
  /// In en, this message translates to:
  /// **'Enter your account email'**
  String get loginEmailRequired;

  /// Validation when email format is invalid
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get loginEmailInvalid;

  /// Validation when password is empty
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get loginPasswordRequired;

  /// Submit login form
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginSubmit;

  /// Supabase invalid login credentials
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect'**
  String get authErrorInvalidCredentials;

  /// Supabase email not confirmed
  ///
  /// In en, this message translates to:
  /// **'Confirm your email before signing in'**
  String get authErrorEmailNotConfirmed;

  /// Signed-in user is operator or admin
  ///
  /// In en, this message translates to:
  /// **'This account is not a pilgrim account. Use the web dashboard instead.'**
  String get authErrorNotPilgrimRole;

  /// Auth user exists but profiles row is missing
  ///
  /// In en, this message translates to:
  /// **'Your profile was not found. Contact your center.'**
  String get authErrorProfileNotFound;

  /// Supabase dart-defines missing at build time
  ///
  /// In en, this message translates to:
  /// **'Sign-in requires Supabase. Run with local dart-defines or contact support.'**
  String get authErrorSupabaseUnavailable;

  /// Supabase configured but request failed (network / cleartext / wrong host)
  ///
  /// In en, this message translates to:
  /// **'Cannot reach Supabase. Check that local Supabase is running and your network (try without VPN).'**
  String get authErrorNetworkConnection;

  /// Generic auth error
  ///
  /// In en, this message translates to:
  /// **'Sign-in failed. Please try again.'**
  String get authErrorUnknown;

  /// Open offline Islamic tools hub from home
  ///
  /// In en, this message translates to:
  /// **'Islamic tools'**
  String get homeIslamicTools;

  /// US-02 tools hub screen title
  ///
  /// In en, this message translates to:
  /// **'Islamic tools'**
  String get toolsHubTitle;

  /// No description provided for @toolsPrayerTimesTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer times'**
  String get toolsPrayerTimesTitle;

  /// No description provided for @toolsPrayerTimesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Calculated from your GPS — works offline after first load'**
  String get toolsPrayerTimesSubtitle;

  /// No description provided for @toolsQiblaTitle.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get toolsQiblaTitle;

  /// No description provided for @toolsQiblaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Compass direction to the Kaaba'**
  String get toolsQiblaSubtitle;

  /// No description provided for @toolsQuranTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get toolsQuranTitle;

  /// No description provided for @toolsQuranSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Full mushaf offline in the app'**
  String get toolsQuranSubtitle;

  /// No description provided for @toolsAdhkarTitle.
  ///
  /// In en, this message translates to:
  /// **'Adhkar'**
  String get toolsAdhkarTitle;

  /// No description provided for @toolsAdhkarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Morning and evening remembrances'**
  String get toolsAdhkarSubtitle;

  /// No description provided for @toolsVirtualTourTitle.
  ///
  /// In en, this message translates to:
  /// **'Haram guide'**
  String get toolsVirtualTourTitle;

  /// No description provided for @toolsVirtualTourSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Real map, ritual guide, and Makkah panorama'**
  String get toolsVirtualTourSubtitle;

  /// No description provided for @toolsVirtualTourLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load the panorama.'**
  String get toolsVirtualTourLoadError;

  /// No description provided for @toolsVirtualTourTabGuide.
  ///
  /// In en, this message translates to:
  /// **'Guide'**
  String get toolsVirtualTourTabGuide;

  /// No description provided for @toolsVirtualTourTabMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get toolsVirtualTourTabMap;

  /// No description provided for @toolsVirtualTourTabPanorama.
  ///
  /// In en, this message translates to:
  /// **'Panorama'**
  String get toolsVirtualTourTabPanorama;

  /// No description provided for @toolsVirtualTourDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'For guidance only — not a substitute for performing Hajj on site.'**
  String get toolsVirtualTourDisclaimer;

  /// No description provided for @toolsVirtualTourGuideHeading.
  ///
  /// In en, this message translates to:
  /// **'Haram landmarks & rituals'**
  String get toolsVirtualTourGuideHeading;

  /// No description provided for @toolsVirtualTourStepsLabel.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get toolsVirtualTourStepsLabel;

  /// No description provided for @toolsVirtualTourTipsLabel.
  ///
  /// In en, this message translates to:
  /// **'Practical tips'**
  String get toolsVirtualTourTipsLabel;

  /// No description provided for @toolsVirtualTourRitualLabel.
  ///
  /// In en, this message translates to:
  /// **'Rite'**
  String get toolsVirtualTourRitualLabel;

  /// No description provided for @toolsVirtualTourMapHint.
  ///
  /// In en, this message translates to:
  /// **'OpenStreetMap — tap a marker for details. Internet required for first load.'**
  String get toolsVirtualTourMapHint;

  /// No description provided for @toolsVirtualTourCenterKaaba.
  ///
  /// In en, this message translates to:
  /// **'Center on Kaaba'**
  String get toolsVirtualTourCenterKaaba;

  /// No description provided for @toolsVirtualTourPanoramaHint.
  ///
  /// In en, this message translates to:
  /// **'Aerial Makkah panorama from Abraj Al-Bait — drag and pinch to explore.'**
  String get toolsVirtualTourPanoramaHint;

  /// No description provided for @toolsVirtualTourPanoramaGestures.
  ///
  /// In en, this message translates to:
  /// **'Drag with one finger or pinch to zoom'**
  String get toolsVirtualTourPanoramaGestures;

  /// No description provided for @toolsVirtualTourPanoramaCredit.
  ///
  /// In en, this message translates to:
  /// **'Panorama: Wurzelgnohm / Wikimedia Commons (CC0)'**
  String get toolsVirtualTourPanoramaCredit;

  /// No description provided for @toolsVirtualTourPhotoCredit.
  ///
  /// In en, this message translates to:
  /// **'Kaaba photo: GusJuned / Wikimedia Commons'**
  String get toolsVirtualTourPhotoCredit;

  /// No description provided for @toolsRefreshLocation.
  ///
  /// In en, this message translates to:
  /// **'Refresh location'**
  String get toolsRefreshLocation;

  /// No description provided for @toolsUsingCachedLocation.
  ///
  /// In en, this message translates to:
  /// **'Using last known location (offline). Tap refresh for GPS.'**
  String get toolsUsingCachedLocation;

  /// No description provided for @toolsCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Location: {lat}, {lng}'**
  String toolsCoordinates(String lat, String lng);

  /// No description provided for @prayerFajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get prayerFajr;

  /// No description provided for @prayerSunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get prayerSunrise;

  /// No description provided for @prayerDhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get prayerDhuhr;

  /// No description provided for @prayerAsr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get prayerAsr;

  /// No description provided for @prayerMaghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get prayerMaghrib;

  /// No description provided for @prayerIsha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get prayerIsha;

  /// No description provided for @toolsQiblaBearing.
  ///
  /// In en, this message translates to:
  /// **'Qibla bearing: {degrees}°'**
  String toolsQiblaBearing(String degrees);

  /// No description provided for @toolsCompassHeading.
  ///
  /// In en, this message translates to:
  /// **'Device heading: {degrees}°'**
  String toolsCompassHeading(String degrees);

  /// No description provided for @toolsQiblaHint.
  ///
  /// In en, this message translates to:
  /// **'Rotate your device until the arrow points up for Qibla.'**
  String get toolsQiblaHint;

  /// No description provided for @toolsQiblaCompassUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Compass sensor unavailable on this device.'**
  String get toolsQiblaCompassUnavailable;

  /// No description provided for @toolsQuranAyahs.
  ///
  /// In en, this message translates to:
  /// **'ayahs'**
  String get toolsQuranAyahs;

  /// No description provided for @toolsQuranSurahMeta.
  ///
  /// In en, this message translates to:
  /// **'{count} ayahs'**
  String toolsQuranSurahMeta(int count);

  /// No description provided for @toolsQuranOfflineNote.
  ///
  /// In en, this message translates to:
  /// **'Text loaded from offline package — no internet required.'**
  String get toolsQuranOfflineNote;

  /// No description provided for @toolsAdhkarMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get toolsAdhkarMorning;

  /// No description provided for @toolsAdhkarEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get toolsAdhkarEvening;

  /// No description provided for @toolsAdhkarRepeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get toolsAdhkarRepeat;

  /// No description provided for @locationErrorServiceDisabled.
  ///
  /// In en, this message translates to:
  /// **'Turn on location services to calculate prayer times and Qibla.'**
  String get locationErrorServiceDisabled;

  /// No description provided for @locationErrorPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required for accurate prayer times and Qibla.'**
  String get locationErrorPermissionDenied;

  /// No description provided for @locationErrorPermissionDeniedForever.
  ///
  /// In en, this message translates to:
  /// **'Enable location permission in system settings.'**
  String get locationErrorPermissionDeniedForever;

  /// No description provided for @locationErrorUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not determine your location.'**
  String get locationErrorUnavailable;

  /// US-04 pilgrim dashboard entry
  ///
  /// In en, this message translates to:
  /// **'My Hajj journey'**
  String get homeMyHajjJourney;

  /// No description provided for @pilgrimDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'My Hajj journey'**
  String get pilgrimDashboardTitle;

  /// No description provided for @pilgrimRitualsProgress.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} rituals completed'**
  String pilgrimRitualsProgress(int completed, int total);

  /// No description provided for @pilgrimRitualPendingSync.
  ///
  /// In en, this message translates to:
  /// **'Pending sync when online'**
  String get pilgrimRitualPendingSync;

  /// No description provided for @pilgrimRitualCompletedAt.
  ///
  /// In en, this message translates to:
  /// **'Completed on {date}'**
  String pilgrimRitualCompletedAt(String date);

  /// No description provided for @pilgrimSyncPending.
  ///
  /// In en, this message translates to:
  /// **'Some ritual updates will sync when you are back online.'**
  String get pilgrimSyncPending;

  /// No description provided for @pilgrimLogisticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Travel & accommodation'**
  String get pilgrimLogisticsTitle;

  /// No description provided for @pilgrimLogisticsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your center has not published logistics details yet.'**
  String get pilgrimLogisticsEmpty;

  /// No description provided for @pilgrimMedicalStatus.
  ///
  /// In en, this message translates to:
  /// **'Medical test'**
  String get pilgrimMedicalStatus;

  /// No description provided for @pilgrimTravelDate.
  ///
  /// In en, this message translates to:
  /// **'Travel date'**
  String get pilgrimTravelDate;

  /// No description provided for @pilgrimHotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get pilgrimHotel;

  /// No description provided for @pilgrimOpenHotelMap.
  ///
  /// In en, this message translates to:
  /// **'Open hotel on map'**
  String get pilgrimOpenHotelMap;

  /// No description provided for @pilgrimTransport.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get pilgrimTransport;

  /// No description provided for @pilgrimSignInRequired.
  ///
  /// In en, this message translates to:
  /// **'Sign in as a pilgrim to track rituals and view your file.'**
  String get pilgrimSignInRequired;

  /// No description provided for @pilgrimLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load your Hajj dashboard. Pull to refresh.'**
  String get pilgrimLoadError;

  /// No description provided for @authErrorNotStaffRole.
  ///
  /// In en, this message translates to:
  /// **'This account is not authorized for the operator dashboard.'**
  String get authErrorNotStaffRole;

  /// No description provided for @authErrorNotAdminRole.
  ///
  /// In en, this message translates to:
  /// **'This account is not authorized for the admin dashboard.'**
  String get authErrorNotAdminRole;

  /// No description provided for @operatorLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Operator sign in'**
  String get operatorLoginTitle;

  /// No description provided for @operatorLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Center technician — pilgrim registration and documents'**
  String get operatorLoginSubtitle;

  /// No description provided for @staffLoginHighlightRegistration.
  ///
  /// In en, this message translates to:
  /// **'Register pilgrims and upload documents'**
  String get staffLoginHighlightRegistration;

  /// No description provided for @staffLoginHighlightDocuments.
  ///
  /// In en, this message translates to:
  /// **'Secure document storage per pilgrim'**
  String get staffLoginHighlightDocuments;

  /// No description provided for @staffLoginHighlightRegistry.
  ///
  /// In en, this message translates to:
  /// **'Manage pilgrim registry in real time'**
  String get staffLoginHighlightRegistry;

  /// No description provided for @staffLoginHighlightAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Live dashboards and field status charts'**
  String get staffLoginHighlightAnalytics;

  /// No description provided for @staffLoginHighlightContent.
  ///
  /// In en, this message translates to:
  /// **'Publish videos, news, and announcements'**
  String get staffLoginHighlightContent;

  /// No description provided for @staffLoginHighlightNotifications.
  ///
  /// In en, this message translates to:
  /// **'Broadcast alerts to pilgrims and staff'**
  String get staffLoginHighlightNotifications;

  /// No description provided for @operatorIntakeTitle.
  ///
  /// In en, this message translates to:
  /// **'Register pilgrim'**
  String get operatorIntakeTitle;

  /// No description provided for @operatorIntakeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter pilgrim data, upload documents, and create a mobile account.'**
  String get operatorIntakeSubtitle;

  /// No description provided for @operatorGenerateCredentials.
  ///
  /// In en, this message translates to:
  /// **'Generate email & password'**
  String get operatorGenerateCredentials;

  /// No description provided for @operatorGeneratedPasswordPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview password (final password is set on submit): {password}'**
  String operatorGeneratedPasswordPreview(String password);

  /// No description provided for @operatorDocumentsSection.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get operatorDocumentsSection;

  /// No description provided for @operatorDocumentsUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Account created, but some documents failed to upload. You can re-upload them later.'**
  String get operatorDocumentsUploadFailed;

  /// No description provided for @operatorSharedDefaultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Shared defaults'**
  String get operatorSharedDefaultsTitle;

  /// No description provided for @operatorSharedDefaultsHint.
  ///
  /// In en, this message translates to:
  /// **'Shared fields (hotel, trip, dates, mashaer…) are saved automatically and pre-filled for the next pilgrim to speed up entry.'**
  String get operatorSharedDefaultsHint;

  /// No description provided for @operatorClearSharedDefaults.
  ///
  /// In en, this message translates to:
  /// **'Clear shared defaults'**
  String get operatorClearSharedDefaults;

  /// No description provided for @operatorSendCredentialsWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Send login info via WhatsApp'**
  String get operatorSendCredentialsWhatsapp;

  /// No description provided for @operatorResetSendConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Send login info'**
  String get operatorResetSendConfirmTitle;

  /// No description provided for @operatorResetSendConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'A new password will be generated for {name} and sent over WhatsApp. Continue?'**
  String operatorResetSendConfirmBody(String name);

  /// No description provided for @operatorResetSendConfirm.
  ///
  /// In en, this message translates to:
  /// **'Reset & send'**
  String get operatorResetSendConfirm;

  /// No description provided for @operatorResetFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not reset the password.'**
  String get operatorResetFailed;

  /// No description provided for @operatorWhatsappOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open WhatsApp.'**
  String get operatorWhatsappOpenFailed;

  /// No description provided for @operatorWhatsappNoNumber.
  ///
  /// In en, this message translates to:
  /// **'No WhatsApp number on file.'**
  String get operatorWhatsappNoNumber;

  /// No description provided for @operatorCredentialsWhatsappMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello, your Rafiq Al-Hajj login details:\nEmail: {email}\nPassword: {password}'**
  String operatorCredentialsWhatsappMessage(String email, String password);

  /// No description provided for @operatorPickDocuments.
  ///
  /// In en, this message translates to:
  /// **'Pick files ({count})'**
  String operatorPickDocuments(int count);

  /// No description provided for @operatorFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get operatorFullName;

  /// No description provided for @operatorRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get operatorRequired;

  /// No description provided for @operatorPassport.
  ///
  /// In en, this message translates to:
  /// **'Passport number'**
  String get operatorPassport;

  /// No description provided for @operatorTravelPermit.
  ///
  /// In en, this message translates to:
  /// **'Travel permit'**
  String get operatorTravelPermit;

  /// No description provided for @operatorHotelMapUrl.
  ///
  /// In en, this message translates to:
  /// **'Hotel map URL'**
  String get operatorHotelMapUrl;

  /// No description provided for @operatorPickDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get operatorPickDate;

  /// No description provided for @operatorSubmitPilgrim.
  ///
  /// In en, this message translates to:
  /// **'Create pilgrim account'**
  String get operatorSubmitPilgrim;

  /// No description provided for @operatorAccountCreatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim account created'**
  String get operatorAccountCreatedTitle;

  /// No description provided for @operatorCloseDialog.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get operatorCloseDialog;

  /// No description provided for @homeFieldOperatorSignIn.
  ///
  /// In en, this message translates to:
  /// **'Field operator sign in'**
  String get homeFieldOperatorSignIn;

  /// No description provided for @fieldOperatorLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Field operator'**
  String get fieldOperatorLoginTitle;

  /// No description provided for @fieldOperatorLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search pilgrims and update logistics in the field'**
  String get fieldOperatorLoginSubtitle;

  /// No description provided for @fieldOperatorHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Pilgrims in the field'**
  String get fieldOperatorHomeTitle;

  /// No description provided for @fieldOperatorDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Field dashboard'**
  String get fieldOperatorDashboardTitle;

  /// No description provided for @fieldOperatorPilgrimsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pilgrims'**
  String get fieldOperatorPilgrimsTitle;

  /// No description provided for @fieldOperatorNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get fieldOperatorNavHome;

  /// No description provided for @fieldOperatorNavPilgrims.
  ///
  /// In en, this message translates to:
  /// **'Pilgrims'**
  String get fieldOperatorNavPilgrims;

  /// No description provided for @fieldOperatorStatsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a card to open the filtered pilgrim list.'**
  String get fieldOperatorStatsHint;

  /// No description provided for @fieldOperatorWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String fieldOperatorWelcome(String name);

  /// No description provided for @fieldOperatorWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{total} pilgrims registered in your groups.'**
  String fieldOperatorWelcomeSubtitle(int total);

  /// No description provided for @fieldOperatorProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Completion overview'**
  String get fieldOperatorProgressTitle;

  /// No description provided for @fieldOperatorProgressSummary.
  ///
  /// In en, this message translates to:
  /// **'{completed} completed · {inProgress} in progress · {total} total'**
  String fieldOperatorProgressSummary(int completed, int inProgress, int total);

  /// No description provided for @fieldOperatorSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name, passport, or permit number'**
  String get fieldOperatorSearchHint;

  /// No description provided for @fieldOperatorLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load pilgrims. Pull to refresh.'**
  String get fieldOperatorLoadError;

  /// No description provided for @fieldOperatorNoResults.
  ///
  /// In en, this message translates to:
  /// **'No pilgrims match your search.'**
  String get fieldOperatorNoResults;

  /// No description provided for @fieldOperatorPilgrimTitle.
  ///
  /// In en, this message translates to:
  /// **'Update pilgrim'**
  String get fieldOperatorPilgrimTitle;

  /// No description provided for @fieldOperatorStatusSection.
  ///
  /// In en, this message translates to:
  /// **'Field status'**
  String get fieldOperatorStatusSection;

  /// No description provided for @fieldOperatorMedicalLabel.
  ///
  /// In en, this message translates to:
  /// **'Medical test status'**
  String get fieldOperatorMedicalLabel;

  /// No description provided for @fieldOperatorHotelLabel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get fieldOperatorHotelLabel;

  /// No description provided for @fieldOperatorTransportLabel.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get fieldOperatorTransportLabel;

  /// No description provided for @fieldOperatorSave.
  ///
  /// In en, this message translates to:
  /// **'Save updates'**
  String get fieldOperatorSave;

  /// No description provided for @fieldOperatorSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim record updated.'**
  String get fieldOperatorSaveSuccess;

  /// No description provided for @fieldOperatorSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save changes.'**
  String get fieldOperatorSaveError;

  /// No description provided for @fieldOperatorShare.
  ///
  /// In en, this message translates to:
  /// **'Copy summary to share'**
  String get fieldOperatorShare;

  /// No description provided for @fieldOperatorCopied.
  ///
  /// In en, this message translates to:
  /// **'Summary copied to clipboard.'**
  String get fieldOperatorCopied;

  /// No description provided for @fieldOperatorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim not found.'**
  String get fieldOperatorNotFound;

  /// No description provided for @fieldOperatorShareSummary.
  ///
  /// In en, this message translates to:
  /// **'{name}\nStatus: {status}\nMedical: {medical}\nHotel: {hotel}'**
  String fieldOperatorShareSummary(
    String name,
    String status,
    String medical,
    String hotel,
  );

  /// No description provided for @fieldStatusNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get fieldStatusNotSet;

  /// No description provided for @fieldStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get fieldStatusPending;

  /// No description provided for @fieldStatusMedicalDone.
  ///
  /// In en, this message translates to:
  /// **'Medical check completed'**
  String get fieldStatusMedicalDone;

  /// No description provided for @fieldStatusArrivedHotel.
  ///
  /// In en, this message translates to:
  /// **'Arrived at hotel'**
  String get fieldStatusArrivedHotel;

  /// No description provided for @fieldStatusInTransit.
  ///
  /// In en, this message translates to:
  /// **'In transit'**
  String get fieldStatusInTransit;

  /// No description provided for @fieldStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get fieldStatusCompleted;

  /// No description provided for @fieldOperatorStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Field overview'**
  String get fieldOperatorStatsTitle;

  /// No description provided for @fieldOperatorStatsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total pilgrims'**
  String get fieldOperatorStatsTotal;

  /// No description provided for @fieldOperatorStatsWheelchair.
  ///
  /// In en, this message translates to:
  /// **'Wheelchair'**
  String get fieldOperatorStatsWheelchair;

  /// No description provided for @fieldOperatorFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get fieldOperatorFilterAll;

  /// No description provided for @fieldOperatorSearchHintExtended.
  ///
  /// In en, this message translates to:
  /// **'Search by name, passport, visa, sticker, or phone'**
  String get fieldOperatorSearchHintExtended;

  /// No description provided for @pilgrimProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'My registration profile'**
  String get pilgrimProfileTitle;

  /// No description provided for @pilgrimProfileEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your registration details are not available yet.'**
  String get pilgrimProfileEmpty;

  /// No description provided for @pilgrimYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get pilgrimYes;

  /// No description provided for @pilgrimNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get pilgrimNo;

  /// No description provided for @pilgrimNotProvided.
  ///
  /// In en, this message translates to:
  /// **'Not provided'**
  String get pilgrimNotProvided;

  /// No description provided for @pilgrimSectionIdentity.
  ///
  /// In en, this message translates to:
  /// **'Identity & registration'**
  String get pilgrimSectionIdentity;

  /// No description provided for @pilgrimSectionTravelDocs.
  ///
  /// In en, this message translates to:
  /// **'Travel documents'**
  String get pilgrimSectionTravelDocs;

  /// No description provided for @pilgrimSectionPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get pilgrimSectionPersonal;

  /// No description provided for @pilgrimSectionHousing.
  ///
  /// In en, this message translates to:
  /// **'Request & housing'**
  String get pilgrimSectionHousing;

  /// No description provided for @pilgrimSectionHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get pilgrimSectionHealth;

  /// No description provided for @pilgrimSectionMakkah.
  ///
  /// In en, this message translates to:
  /// **'Makkah accommodation'**
  String get pilgrimSectionMakkah;

  /// No description provided for @pilgrimSectionMadinah.
  ///
  /// In en, this message translates to:
  /// **'Madinah accommodation'**
  String get pilgrimSectionMadinah;

  /// No description provided for @pilgrimSectionDepartureFlight.
  ///
  /// In en, this message translates to:
  /// **'Outbound flight'**
  String get pilgrimSectionDepartureFlight;

  /// No description provided for @pilgrimSectionReturnFlight.
  ///
  /// In en, this message translates to:
  /// **'Return flight'**
  String get pilgrimSectionReturnFlight;

  /// No description provided for @pilgrimSectionHolySites.
  ///
  /// In en, this message translates to:
  /// **'Holy sites (Mina & Arafat)'**
  String get pilgrimSectionHolySites;

  /// No description provided for @pilgrimSectionContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get pilgrimSectionContact;

  /// No description provided for @pilgrimSectionNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get pilgrimSectionNotes;

  /// No description provided for @pilgrimLabelSequence.
  ///
  /// In en, this message translates to:
  /// **'Sequence'**
  String get pilgrimLabelSequence;

  /// No description provided for @pilgrimLabelCluster.
  ///
  /// In en, this message translates to:
  /// **'Cluster'**
  String get pilgrimLabelCluster;

  /// No description provided for @pilgrimLabelCoordinator.
  ///
  /// In en, this message translates to:
  /// **'Coordinator'**
  String get pilgrimLabelCoordinator;

  /// No description provided for @pilgrimLabelSticker.
  ///
  /// In en, this message translates to:
  /// **'Sticker no.'**
  String get pilgrimLabelSticker;

  /// No description provided for @pilgrimLabelVisa.
  ///
  /// In en, this message translates to:
  /// **'Visa no.'**
  String get pilgrimLabelVisa;

  /// No description provided for @pilgrimLabelBarcode.
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get pilgrimLabelBarcode;

  /// No description provided for @pilgrimLabelFullNameAr.
  ///
  /// In en, this message translates to:
  /// **'Full name (Arabic)'**
  String get pilgrimLabelFullNameAr;

  /// No description provided for @pilgrimLabelMotherAr.
  ///
  /// In en, this message translates to:
  /// **'Mother\'s name (Arabic)'**
  String get pilgrimLabelMotherAr;

  /// No description provided for @pilgrimLabelBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get pilgrimLabelBirthDate;

  /// No description provided for @pilgrimLabelFirstNameEn.
  ///
  /// In en, this message translates to:
  /// **'First name (English)'**
  String get pilgrimLabelFirstNameEn;

  /// No description provided for @pilgrimLabelLastNameEn.
  ///
  /// In en, this message translates to:
  /// **'Last name (English)'**
  String get pilgrimLabelLastNameEn;

  /// No description provided for @pilgrimLabelFatherEn.
  ///
  /// In en, this message translates to:
  /// **'Father\'s name (English)'**
  String get pilgrimLabelFatherEn;

  /// No description provided for @pilgrimLabelMotherEn.
  ///
  /// In en, this message translates to:
  /// **'Mother\'s name (English)'**
  String get pilgrimLabelMotherEn;

  /// No description provided for @pilgrimLabelPassportIssue.
  ///
  /// In en, this message translates to:
  /// **'Passport issue date'**
  String get pilgrimLabelPassportIssue;

  /// No description provided for @pilgrimLabelPassportExpiry.
  ///
  /// In en, this message translates to:
  /// **'Passport expiry date'**
  String get pilgrimLabelPassportExpiry;

  /// No description provided for @pilgrimLabelGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get pilgrimLabelGender;

  /// No description provided for @pilgrimLabelBodySize.
  ///
  /// In en, this message translates to:
  /// **'Body size'**
  String get pilgrimLabelBodySize;

  /// No description provided for @pilgrimLabelGroup.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get pilgrimLabelGroup;

  /// No description provided for @pilgrimLabelCompanion.
  ///
  /// In en, this message translates to:
  /// **'Companion'**
  String get pilgrimLabelCompanion;

  /// No description provided for @pilgrimLabelRelation.
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get pilgrimLabelRelation;

  /// No description provided for @pilgrimLabelRequestType.
  ///
  /// In en, this message translates to:
  /// **'Request type'**
  String get pilgrimLabelRequestType;

  /// No description provided for @pilgrimLabelHousingType.
  ///
  /// In en, this message translates to:
  /// **'Housing type'**
  String get pilgrimLabelHousingType;

  /// No description provided for @pilgrimLabelHadyStatus.
  ///
  /// In en, this message translates to:
  /// **'Hady status'**
  String get pilgrimLabelHadyStatus;

  /// No description provided for @pilgrimLabelResidence.
  ///
  /// In en, this message translates to:
  /// **'Residence'**
  String get pilgrimLabelResidence;

  /// No description provided for @pilgrimLabelHealthStatus.
  ///
  /// In en, this message translates to:
  /// **'Health status'**
  String get pilgrimLabelHealthStatus;

  /// No description provided for @pilgrimLabelWheelchair.
  ///
  /// In en, this message translates to:
  /// **'Wheelchair needed'**
  String get pilgrimLabelWheelchair;

  /// No description provided for @pilgrimLabelSmoking.
  ///
  /// In en, this message translates to:
  /// **'Smoking'**
  String get pilgrimLabelSmoking;

  /// No description provided for @pilgrimLabelHealthCard.
  ///
  /// In en, this message translates to:
  /// **'Health card'**
  String get pilgrimLabelHealthCard;

  /// No description provided for @pilgrimLabelVaccinated.
  ///
  /// In en, this message translates to:
  /// **'Vaccinated'**
  String get pilgrimLabelVaccinated;

  /// No description provided for @pilgrimLabelMakkahHotel.
  ///
  /// In en, this message translates to:
  /// **'Makkah hotel'**
  String get pilgrimLabelMakkahHotel;

  /// No description provided for @pilgrimLabelMakkahFloor.
  ///
  /// In en, this message translates to:
  /// **'Makkah floor'**
  String get pilgrimLabelMakkahFloor;

  /// No description provided for @pilgrimLabelMakkahRoom.
  ///
  /// In en, this message translates to:
  /// **'Makkah room'**
  String get pilgrimLabelMakkahRoom;

  /// No description provided for @pilgrimLabelMadinahTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel date to Madinah'**
  String get pilgrimLabelMadinahTravel;

  /// No description provided for @pilgrimLabelMadinahHotel.
  ///
  /// In en, this message translates to:
  /// **'Madinah hotel'**
  String get pilgrimLabelMadinahHotel;

  /// No description provided for @pilgrimLabelMadinahFloor.
  ///
  /// In en, this message translates to:
  /// **'Madinah floor'**
  String get pilgrimLabelMadinahFloor;

  /// No description provided for @pilgrimLabelMadinahRoom.
  ///
  /// In en, this message translates to:
  /// **'Madinah room'**
  String get pilgrimLabelMadinahRoom;

  /// No description provided for @pilgrimLabelDepartureAirport.
  ///
  /// In en, this message translates to:
  /// **'Departure airport'**
  String get pilgrimLabelDepartureAirport;

  /// No description provided for @pilgrimLabelDepartureAirline.
  ///
  /// In en, this message translates to:
  /// **'Departure airline'**
  String get pilgrimLabelDepartureAirline;

  /// No description provided for @pilgrimLabelDepartureFlight.
  ///
  /// In en, this message translates to:
  /// **'Departure flight no.'**
  String get pilgrimLabelDepartureFlight;

  /// No description provided for @pilgrimLabelDepartureDate.
  ///
  /// In en, this message translates to:
  /// **'Departure date'**
  String get pilgrimLabelDepartureDate;

  /// No description provided for @pilgrimLabelDepartureTime.
  ///
  /// In en, this message translates to:
  /// **'Departure time'**
  String get pilgrimLabelDepartureTime;

  /// No description provided for @pilgrimLabelReturnAirport.
  ///
  /// In en, this message translates to:
  /// **'Return airport'**
  String get pilgrimLabelReturnAirport;

  /// No description provided for @pilgrimLabelReturnAirline.
  ///
  /// In en, this message translates to:
  /// **'Return airline'**
  String get pilgrimLabelReturnAirline;

  /// No description provided for @pilgrimLabelReturnFlight.
  ///
  /// In en, this message translates to:
  /// **'Return flight no.'**
  String get pilgrimLabelReturnFlight;

  /// No description provided for @pilgrimLabelReturnDate.
  ///
  /// In en, this message translates to:
  /// **'Return date'**
  String get pilgrimLabelReturnDate;

  /// No description provided for @pilgrimLabelReturnTime.
  ///
  /// In en, this message translates to:
  /// **'Return time'**
  String get pilgrimLabelReturnTime;

  /// No description provided for @pilgrimLabelServiceCenter.
  ///
  /// In en, this message translates to:
  /// **'Service center'**
  String get pilgrimLabelServiceCenter;

  /// No description provided for @pilgrimLabelCenterArafat.
  ///
  /// In en, this message translates to:
  /// **'Arafat service center'**
  String get pilgrimLabelCenterArafat;

  /// No description provided for @pilgrimLabelCenterMina.
  ///
  /// In en, this message translates to:
  /// **'Mina service center'**
  String get pilgrimLabelCenterMina;

  /// No description provided for @pilgrimLabelBusArafat.
  ///
  /// In en, this message translates to:
  /// **'Arafat bus'**
  String get pilgrimLabelBusArafat;

  /// No description provided for @pilgrimLabelBusMina.
  ///
  /// In en, this message translates to:
  /// **'Mina bus'**
  String get pilgrimLabelBusMina;

  /// No description provided for @pilgrimLabelTentArafat.
  ///
  /// In en, this message translates to:
  /// **'Arafat tent'**
  String get pilgrimLabelTentArafat;

  /// No description provided for @pilgrimLabelTentMina.
  ///
  /// In en, this message translates to:
  /// **'Mina tent'**
  String get pilgrimLabelTentMina;

  /// No description provided for @pilgrimLabelPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get pilgrimLabelPhone;

  /// No description provided for @pilgrimLabelWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get pilgrimLabelWhatsapp;

  /// No description provided for @pilgrimLabelSyrianPhone.
  ///
  /// In en, this message translates to:
  /// **'Syrian phone'**
  String get pilgrimLabelSyrianPhone;

  /// No description provided for @operatorGoAdminLogin.
  ///
  /// In en, this message translates to:
  /// **'Admin analytics sign in'**
  String get operatorGoAdminLogin;

  /// No description provided for @adminLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin sign in'**
  String get adminLoginTitle;

  /// No description provided for @adminLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Consortium analytics and reporting'**
  String get adminLoginSubtitle;

  /// No description provided for @adminDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Analytics dashboard'**
  String get adminDashboardTitle;

  /// No description provided for @adminDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Live metrics from Supabase — pilgrims, groups, and field status.'**
  String get adminDashboardSubtitle;

  /// No description provided for @adminDashboardLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load dashboard metrics.'**
  String get adminDashboardLoadError;

  /// No description provided for @adminStatPilgrims.
  ///
  /// In en, this message translates to:
  /// **'Pilgrims'**
  String get adminStatPilgrims;

  /// No description provided for @adminStatOperators.
  ///
  /// In en, this message translates to:
  /// **'Field operators'**
  String get adminStatOperators;

  /// No description provided for @adminStatRitualProgress.
  ///
  /// In en, this message translates to:
  /// **'Ritual completion'**
  String get adminStatRitualProgress;

  /// No description provided for @adminChartPilgrimsByGroup.
  ///
  /// In en, this message translates to:
  /// **'Pilgrims by group'**
  String get adminChartPilgrimsByGroup;

  /// No description provided for @adminChartFieldStatus.
  ///
  /// In en, this message translates to:
  /// **'Field status distribution'**
  String get adminChartFieldStatus;

  /// No description provided for @adminChartOperatorUploads.
  ///
  /// In en, this message translates to:
  /// **'Documents uploaded by operator'**
  String get adminChartOperatorUploads;

  /// No description provided for @adminChartEmpty.
  ///
  /// In en, this message translates to:
  /// **'No data yet.'**
  String get adminChartEmpty;

  /// No description provided for @adminUnassignedGroup.
  ///
  /// In en, this message translates to:
  /// **'Unassigned'**
  String get adminUnassignedGroup;

  /// No description provided for @adminUnknownOperator.
  ///
  /// In en, this message translates to:
  /// **'Unknown operator'**
  String get adminUnknownOperator;

  /// No description provided for @adminManageContent.
  ///
  /// In en, this message translates to:
  /// **'Manage content library'**
  String get adminManageContent;

  /// No description provided for @adminContentListTitle.
  ///
  /// In en, this message translates to:
  /// **'Content library'**
  String get adminContentListTitle;

  /// No description provided for @adminContentAdd.
  ///
  /// In en, this message translates to:
  /// **'Add content'**
  String get adminContentAdd;

  /// No description provided for @adminContentEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get adminContentEdit;

  /// No description provided for @adminContentNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New content'**
  String get adminContentNewTitle;

  /// No description provided for @adminContentEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit content'**
  String get adminContentEditTitle;

  /// No description provided for @adminContentLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load content.'**
  String get adminContentLoadError;

  /// No description provided for @adminContentEmpty.
  ///
  /// In en, this message translates to:
  /// **'No content yet. Add your first item.'**
  String get adminContentEmpty;

  /// No description provided for @adminContentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Content item not found.'**
  String get adminContentNotFound;

  /// No description provided for @adminContentTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get adminContentTitleLabel;

  /// No description provided for @adminContentTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a title'**
  String get adminContentTitleRequired;

  /// No description provided for @adminContentDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get adminContentDescriptionLabel;

  /// No description provided for @adminContentMediaUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Media URL (optional)'**
  String get adminContentMediaUrlLabel;

  /// No description provided for @adminContentTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get adminContentTypeLabel;

  /// No description provided for @adminContentVisibilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get adminContentVisibilityLabel;

  /// No description provided for @adminContentTypeVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get adminContentTypeVideo;

  /// No description provided for @adminContentTypeNews.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get adminContentTypeNews;

  /// No description provided for @adminContentTypeAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get adminContentTypeAnnouncement;

  /// No description provided for @adminContentVisibilityPublic.
  ///
  /// In en, this message translates to:
  /// **'Public (everyone)'**
  String get adminContentVisibilityPublic;

  /// No description provided for @adminContentVisibilityPilgrimOnly.
  ///
  /// In en, this message translates to:
  /// **'Pilgrims only'**
  String get adminContentVisibilityPilgrimOnly;

  /// No description provided for @adminContentSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get adminContentSave;

  /// No description provided for @adminContentSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Content updated.'**
  String get adminContentSaveSuccess;

  /// No description provided for @adminContentCreateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Content published.'**
  String get adminContentCreateSuccess;

  /// No description provided for @adminContentSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save content.'**
  String get adminContentSaveError;

  /// No description provided for @adminContentDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete content?'**
  String get adminContentDeleteTitle;

  /// No description provided for @adminContentDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{title}\"? This cannot be undone.'**
  String adminContentDeleteMessage(String title);

  /// No description provided for @adminContentDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminContentDeleteConfirm;

  /// No description provided for @adminContentDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Content deleted.'**
  String get adminContentDeleteSuccess;

  /// No description provided for @adminContentDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete content.'**
  String get adminContentDeleteError;

  /// No description provided for @dialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dialogCancel;

  /// No description provided for @operatorPilgrimListTitle.
  ///
  /// In en, this message translates to:
  /// **'Registered pilgrims'**
  String get operatorPilgrimListTitle;

  /// No description provided for @operatorPilgrimSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name, passport, or permit number'**
  String get operatorPilgrimSearchHint;

  /// No description provided for @operatorPilgrimListLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load pilgrim list.'**
  String get operatorPilgrimListLoadError;

  /// No description provided for @operatorPilgrimListEmpty.
  ///
  /// In en, this message translates to:
  /// **'No pilgrims registered yet.'**
  String get operatorPilgrimListEmpty;

  /// No description provided for @operatorPilgrimNoLogisticsYet.
  ///
  /// In en, this message translates to:
  /// **'No logistics on file'**
  String get operatorPilgrimNoLogisticsYet;

  /// No description provided for @operatorPilgrimDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim record'**
  String get operatorPilgrimDetailTitle;

  /// No description provided for @operatorPilgrimDetailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update travel and accommodation details (desk operator).'**
  String get operatorPilgrimDetailSubtitle;

  /// No description provided for @operatorPilgrimNotFound.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim not found.'**
  String get operatorPilgrimNotFound;

  /// No description provided for @operatorPilgrimTravelDateUnset.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get operatorPilgrimTravelDateUnset;

  /// No description provided for @operatorPilgrimSave.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get operatorPilgrimSave;

  /// No description provided for @operatorPilgrimSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim record updated.'**
  String get operatorPilgrimSaveSuccess;

  /// No description provided for @operatorPilgrimSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save changes.'**
  String get operatorPilgrimSaveError;

  /// No description provided for @homeCompetitions.
  ///
  /// In en, this message translates to:
  /// **'Competitions'**
  String get homeCompetitions;

  /// No description provided for @competitionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Competitions'**
  String get competitionsTitle;

  /// No description provided for @competitionsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load competitions.'**
  String get competitionsLoadError;

  /// No description provided for @competitionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No active competitions right now.'**
  String get competitionsEmpty;

  /// No description provided for @competitionsNoDescription.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get competitionsNoDescription;

  /// No description provided for @competitionDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Competition'**
  String get competitionDetailTitle;

  /// No description provided for @competitionNotFound.
  ///
  /// In en, this message translates to:
  /// **'Competition not found.'**
  String get competitionNotFound;

  /// No description provided for @competitionSignInRequired.
  ///
  /// In en, this message translates to:
  /// **'Sign in as a pilgrim to join and earn points.'**
  String get competitionSignInRequired;

  /// No description provided for @competitionClosed.
  ///
  /// In en, this message translates to:
  /// **'This competition is not open for entries.'**
  String get competitionClosed;

  /// No description provided for @competitionJoin.
  ///
  /// In en, this message translates to:
  /// **'Join competition'**
  String get competitionJoin;

  /// No description provided for @competitionJoinSuccess.
  ///
  /// In en, this message translates to:
  /// **'You joined the competition.'**
  String get competitionJoinSuccess;

  /// No description provided for @competitionJoinError.
  ///
  /// In en, this message translates to:
  /// **'Could not join. Sign in as a pilgrim or try again.'**
  String get competitionJoinError;

  /// No description provided for @competitionYourScore.
  ///
  /// In en, this message translates to:
  /// **'Your score: {score} points'**
  String competitionYourScore(int score);

  /// No description provided for @competitionAnswerTrue.
  ///
  /// In en, this message translates to:
  /// **'True'**
  String get competitionAnswerTrue;

  /// No description provided for @competitionAnswerFalse.
  ///
  /// In en, this message translates to:
  /// **'False'**
  String get competitionAnswerFalse;

  /// No description provided for @competitionQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get competitionQuizTitle;

  /// No description provided for @competitionQuizLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load quiz questions.'**
  String get competitionQuizLoadError;

  /// No description provided for @competitionQuizNoQuestions.
  ///
  /// In en, this message translates to:
  /// **'No questions have been added to this competition yet.'**
  String get competitionQuizNoQuestions;

  /// No description provided for @competitionQuizProgress.
  ///
  /// In en, this message translates to:
  /// **'{answered} of {total} questions answered'**
  String competitionQuizProgress(int answered, int total);

  /// No description provided for @competitionQuizStart.
  ///
  /// In en, this message translates to:
  /// **'Start quiz'**
  String get competitionQuizStart;

  /// No description provided for @competitionQuizContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue quiz'**
  String get competitionQuizContinue;

  /// No description provided for @competitionQuizReview.
  ///
  /// In en, this message translates to:
  /// **'Review answers'**
  String get competitionQuizReview;

  /// No description provided for @competitionQuizSubmit.
  ///
  /// In en, this message translates to:
  /// **'Check answer'**
  String get competitionQuizSubmit;

  /// No description provided for @competitionQuizSubmitError.
  ///
  /// In en, this message translates to:
  /// **'Could not submit your answer. Try again.'**
  String get competitionQuizSubmitError;

  /// No description provided for @competitionQuizCorrect.
  ///
  /// In en, this message translates to:
  /// **'Correct! +{points} points'**
  String competitionQuizCorrect(int points);

  /// No description provided for @competitionQuizIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Not quite — review the explanation below.'**
  String get competitionQuizIncorrect;

  /// No description provided for @competitionQuizComplete.
  ///
  /// In en, this message translates to:
  /// **'Lesson complete!'**
  String get competitionQuizComplete;

  /// No description provided for @competitionQuizCompleteSummary.
  ///
  /// In en, this message translates to:
  /// **'You answered {count} questions in this competition.'**
  String competitionQuizCompleteSummary(int count);

  /// No description provided for @competitionQuizDone.
  ///
  /// In en, this message translates to:
  /// **'Back to competition'**
  String get competitionQuizDone;

  /// No description provided for @competitionQuizQuestionBadge.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String competitionQuizQuestionBadge(int current, int total);

  /// No description provided for @competitionPathTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning path'**
  String get competitionPathTitle;

  /// No description provided for @competitionPathSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete each lesson in order to earn points.'**
  String get competitionPathSubtitle;

  /// No description provided for @competitionLessonLocked.
  ///
  /// In en, this message translates to:
  /// **'Complete the previous lesson first.'**
  String get competitionLessonLocked;

  /// No description provided for @competitionLearnBadge.
  ///
  /// In en, this message translates to:
  /// **'Interactive learning'**
  String get competitionLearnBadge;

  /// No description provided for @competitionLearnHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn Hajj rituals playfully'**
  String get competitionLearnHeroTitle;

  /// No description provided for @competitionLearnHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Answer questions, track your progress, and climb the leaderboard.'**
  String get competitionLearnHeroSubtitle;

  /// No description provided for @competitionStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open now'**
  String get competitionStatusOpen;

  /// No description provided for @competitionStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get competitionStatusUpcoming;

  /// No description provided for @competitionJoinPrompt.
  ///
  /// In en, this message translates to:
  /// **'Join this competition to start earning points.'**
  String get competitionJoinPrompt;

  /// No description provided for @competitionLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get competitionLeaderboard;

  /// No description provided for @competitionLeaderboardEmpty.
  ///
  /// In en, this message translates to:
  /// **'No participants yet.'**
  String get competitionLeaderboardEmpty;

  /// No description provided for @competitionAnonymous.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim'**
  String get competitionAnonymous;

  /// No description provided for @competitionPoints.
  ///
  /// In en, this message translates to:
  /// **'{score} pts'**
  String competitionPoints(int score);

  /// No description provided for @adminManageCompetitions.
  ///
  /// In en, this message translates to:
  /// **'Manage competitions'**
  String get adminManageCompetitions;

  /// No description provided for @adminCompetitionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Competitions'**
  String get adminCompetitionsTitle;

  /// No description provided for @adminCompetitionAdd.
  ///
  /// In en, this message translates to:
  /// **'Add competition'**
  String get adminCompetitionAdd;

  /// No description provided for @adminCompetitionsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load competitions.'**
  String get adminCompetitionsLoadError;

  /// No description provided for @adminCompetitionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No competitions yet.'**
  String get adminCompetitionsEmpty;

  /// No description provided for @adminCompetitionNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New competition'**
  String get adminCompetitionNewTitle;

  /// No description provided for @adminCompetitionEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit competition'**
  String get adminCompetitionEditTitle;

  /// No description provided for @adminCompetitionStartsAt.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get adminCompetitionStartsAt;

  /// No description provided for @adminCompetitionEndsAt.
  ///
  /// In en, this message translates to:
  /// **'Ends'**
  String get adminCompetitionEndsAt;

  /// No description provided for @adminCompetitionActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminCompetitionActiveLabel;

  /// No description provided for @adminCompetitionInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adminCompetitionInactive;

  /// No description provided for @adminCompetitionActive.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get adminCompetitionActive;

  /// No description provided for @adminCompetitionSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Competition saved.'**
  String get adminCompetitionSaveSuccess;

  /// No description provided for @adminCompetitionSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save competition.'**
  String get adminCompetitionSaveError;

  /// No description provided for @adminCompetitionDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete competition?'**
  String get adminCompetitionDeleteTitle;

  /// No description provided for @adminCompetitionDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{title}\"?'**
  String adminCompetitionDeleteMessage(String title);

  /// No description provided for @adminCompetitionDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminCompetitionDeleteConfirm;

  /// No description provided for @adminCompetitionDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Competition deleted.'**
  String get adminCompetitionDeleteSuccess;

  /// No description provided for @adminCompetitionDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete competition.'**
  String get adminCompetitionDeleteError;

  /// No description provided for @adminCompetitionQuestionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get adminCompetitionQuestionsTitle;

  /// No description provided for @adminCompetitionQuestionAdd.
  ///
  /// In en, this message translates to:
  /// **'Add question'**
  String get adminCompetitionQuestionAdd;

  /// No description provided for @adminCompetitionQuestionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No questions yet. Add multiple-choice or true/false questions.'**
  String get adminCompetitionQuestionsEmpty;

  /// No description provided for @adminCompetitionQuestionsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load questions.'**
  String get adminCompetitionQuestionsLoadError;

  /// No description provided for @adminCompetitionQuestionNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New question'**
  String get adminCompetitionQuestionNewTitle;

  /// No description provided for @adminCompetitionQuestionEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit question'**
  String get adminCompetitionQuestionEditTitle;

  /// No description provided for @adminCompetitionQuestionTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Question type'**
  String get adminCompetitionQuestionTypeLabel;

  /// No description provided for @adminCompetitionQuestionTypeMultipleChoice.
  ///
  /// In en, this message translates to:
  /// **'Multiple choice'**
  String get adminCompetitionQuestionTypeMultipleChoice;

  /// No description provided for @adminCompetitionQuestionTypeTrueFalse.
  ///
  /// In en, this message translates to:
  /// **'True or false'**
  String get adminCompetitionQuestionTypeTrueFalse;

  /// No description provided for @adminCompetitionQuestionTypeOrdering.
  ///
  /// In en, this message translates to:
  /// **'Order the steps'**
  String get adminCompetitionQuestionTypeOrdering;

  /// No description provided for @adminCompetitionQuestionOrderingStepsLabel.
  ///
  /// In en, this message translates to:
  /// **'Steps (top = first)'**
  String get adminCompetitionQuestionOrderingStepsLabel;

  /// No description provided for @adminCompetitionQuestionOrderingStepsHint.
  ///
  /// In en, this message translates to:
  /// **'Drag to set the correct order pilgrims should follow.'**
  String get adminCompetitionQuestionOrderingStepsHint;

  /// No description provided for @adminCompetitionQuestionStepLabel.
  ///
  /// In en, this message translates to:
  /// **'Step {number}'**
  String adminCompetitionQuestionStepLabel(int number);

  /// No description provided for @adminCompetitionQuestionAddStep.
  ///
  /// In en, this message translates to:
  /// **'Add step'**
  String get adminCompetitionQuestionAddStep;

  /// No description provided for @competitionOrderingHint.
  ///
  /// In en, this message translates to:
  /// **'Drag the cards into the correct order.'**
  String get competitionOrderingHint;

  /// No description provided for @competitionQuizOrderingBadge.
  ///
  /// In en, this message translates to:
  /// **'Order · {current}/{total}'**
  String competitionQuizOrderingBadge(int current, int total);

  /// No description provided for @adminCompetitionQuestionPromptLabel.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get adminCompetitionQuestionPromptLabel;

  /// No description provided for @adminCompetitionQuestionPromptRequired.
  ///
  /// In en, this message translates to:
  /// **'Question text is required.'**
  String get adminCompetitionQuestionPromptRequired;

  /// No description provided for @adminCompetitionQuestionExplanationLabel.
  ///
  /// In en, this message translates to:
  /// **'Explanation (shown after answering)'**
  String get adminCompetitionQuestionExplanationLabel;

  /// No description provided for @adminCompetitionQuestionPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points for correct answer'**
  String get adminCompetitionQuestionPointsLabel;

  /// No description provided for @adminCompetitionQuestionPointsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a positive number of points.'**
  String get adminCompetitionQuestionPointsInvalid;

  /// No description provided for @adminCompetitionQuestionPoints.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String adminCompetitionQuestionPoints(int points);

  /// No description provided for @adminCompetitionQuestionOptionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Answer options'**
  String get adminCompetitionQuestionOptionsLabel;

  /// No description provided for @adminCompetitionQuestionOptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Option {number}'**
  String adminCompetitionQuestionOptionLabel(int number);

  /// No description provided for @adminCompetitionQuestionOptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Option text is required.'**
  String get adminCompetitionQuestionOptionRequired;

  /// No description provided for @adminCompetitionQuestionSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save question.'**
  String get adminCompetitionQuestionSaveError;

  /// No description provided for @adminCompetitionQuestionDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete question?'**
  String get adminCompetitionQuestionDeleteTitle;

  /// No description provided for @adminCompetitionQuestionDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This question and its answers will be removed.'**
  String get adminCompetitionQuestionDeleteMessage;

  /// No description provided for @adminCompetitionQuestionDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminCompetitionQuestionDeleteConfirm;

  /// No description provided for @adminCompetitionQuestionDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Question deleted.'**
  String get adminCompetitionQuestionDeleteSuccess;

  /// No description provided for @adminCompetitionQuestionDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete question.'**
  String get adminCompetitionQuestionDeleteError;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsOpenInbox.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsOpenInbox;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet.'**
  String get notificationsEmpty;

  /// No description provided for @notificationsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load notifications.'**
  String get notificationsLoadError;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notificationsMarkAllRead;

  /// No description provided for @adminSendNotification.
  ///
  /// In en, this message translates to:
  /// **'Send notification'**
  String get adminSendNotification;

  /// No description provided for @adminNotificationSendTitle.
  ///
  /// In en, this message translates to:
  /// **'Broadcast notification'**
  String get adminNotificationSendTitle;

  /// No description provided for @adminNotificationAudienceLabel.
  ///
  /// In en, this message translates to:
  /// **'Audience'**
  String get adminNotificationAudienceLabel;

  /// No description provided for @adminNotificationAudienceAllPilgrims.
  ///
  /// In en, this message translates to:
  /// **'All pilgrims'**
  String get adminNotificationAudienceAllPilgrims;

  /// No description provided for @adminNotificationAudienceGroup.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get adminNotificationAudienceGroup;

  /// No description provided for @adminNotificationAudienceOperators.
  ///
  /// In en, this message translates to:
  /// **'All operators'**
  String get adminNotificationAudienceOperators;

  /// No description provided for @adminNotificationGroupLabel.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get adminNotificationGroupLabel;

  /// No description provided for @adminNotificationGroupRequired.
  ///
  /// In en, this message translates to:
  /// **'Select a group.'**
  String get adminNotificationGroupRequired;

  /// No description provided for @adminNotificationGroupsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load groups.'**
  String get adminNotificationGroupsLoadError;

  /// No description provided for @adminNotificationGroupsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No groups defined yet.'**
  String get adminNotificationGroupsEmpty;

  /// No description provided for @adminNotificationTitleAr.
  ///
  /// In en, this message translates to:
  /// **'Title (Arabic)'**
  String get adminNotificationTitleAr;

  /// No description provided for @adminNotificationTitleEn.
  ///
  /// In en, this message translates to:
  /// **'Title (English)'**
  String get adminNotificationTitleEn;

  /// No description provided for @adminNotificationTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required.'**
  String get adminNotificationTitleRequired;

  /// No description provided for @adminNotificationBodyAr.
  ///
  /// In en, this message translates to:
  /// **'Message (Arabic, optional)'**
  String get adminNotificationBodyAr;

  /// No description provided for @adminNotificationBodyEn.
  ///
  /// In en, this message translates to:
  /// **'Message (English, optional)'**
  String get adminNotificationBodyEn;

  /// No description provided for @adminNotificationSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get adminNotificationSendButton;

  /// No description provided for @adminNotificationSendSuccess.
  ///
  /// In en, this message translates to:
  /// **'Sent to {count} recipients.'**
  String adminNotificationSendSuccess(int count);

  /// No description provided for @adminNotificationSendError.
  ///
  /// In en, this message translates to:
  /// **'Could not send notification.'**
  String get adminNotificationSendError;

  /// Title on the language picker bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get languageSwitcherTitle;

  /// Subtitle on the language picker bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Your choice is saved for next time'**
  String get languageSwitcherSubtitle;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @languageArabicSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabicSubtitle;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageEnglishSubtitle.
  ///
  /// In en, this message translates to:
  /// **'الإنجليزية'**
  String get languageEnglishSubtitle;

  /// No description provided for @languageArabicShort.
  ///
  /// In en, this message translates to:
  /// **'عربي'**
  String get languageArabicShort;

  /// No description provided for @languageEnglishShort.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get languageEnglishShort;

  /// No description provided for @toolsQuranSurahSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{name} · {count} {ayahsLabel}'**
  String toolsQuranSurahSubtitle(String name, int count, String ayahsLabel);

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navGuidance.
  ///
  /// In en, this message translates to:
  /// **'Guidance'**
  String get navGuidance;

  /// No description provided for @navServices.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get navServices;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @homeNextPrayer.
  ///
  /// In en, this message translates to:
  /// **'Next Prayer'**
  String get homeNextPrayer;

  /// No description provided for @homePrayerLocation.
  ///
  /// In en, this message translates to:
  /// **'Makkah, KSA'**
  String get homePrayerLocation;

  /// No description provided for @homeQuickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick tools'**
  String get homeQuickActionsTitle;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All →'**
  String get homeSeeAll;

  /// No description provided for @homeJourneyTitle.
  ///
  /// In en, this message translates to:
  /// **'Begin Your Sacred Journey'**
  String get homeJourneyTitle;

  /// No description provided for @homeJourneyBody.
  ///
  /// In en, this message translates to:
  /// **'Contact us to inquire about registration. If the technical team provided your account credentials, enter them to sign in.'**
  String get homeJourneyBody;

  /// No description provided for @homeContactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get homeContactUs;

  /// No description provided for @homeEnterRegistration.
  ///
  /// In en, this message translates to:
  /// **'Enter registration details'**
  String get homeEnterRegistration;

  /// No description provided for @homeRegisterNow.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get homeRegisterNow;

  /// No description provided for @homeNewsSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All →'**
  String get homeNewsSeeAll;

  /// No description provided for @contentImportantTag.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get contentImportantTag;

  /// No description provided for @contentHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} Hours Ago'**
  String contentHoursAgo(int hours);

  /// No description provided for @profileGuestTitle.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get profileGuestTitle;

  /// No description provided for @profileGuestBody.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access your Hajj journey, rituals, and personalized content.'**
  String get profileGuestBody;

  /// No description provided for @notificationsLatestUpdates.
  ///
  /// In en, this message translates to:
  /// **'Latest Updates'**
  String get notificationsLatestUpdates;

  /// No description provided for @notificationsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notificationsFilterAll;

  /// No description provided for @notificationsFilterGeneral.
  ///
  /// In en, this message translates to:
  /// **'General News'**
  String get notificationsFilterGeneral;

  /// No description provided for @notificationsFilterUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent Alerts'**
  String get notificationsFilterUrgent;

  /// No description provided for @notificationsUrgentBadge.
  ///
  /// In en, this message translates to:
  /// **'Urgent Alert!'**
  String get notificationsUrgentBadge;

  /// No description provided for @notificationsMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min ago'**
  String notificationsMinutesAgo(int minutes);

  /// No description provided for @notificationsGroupToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get notificationsGroupToday;

  /// No description provided for @notificationsGroupYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get notificationsGroupYesterday;

  /// No description provided for @notificationsGroupEarlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get notificationsGroupEarlier;

  /// No description provided for @notificationsUnreadCount.
  ///
  /// In en, this message translates to:
  /// **'{count} unread'**
  String notificationsUnreadCount(int count);

  /// No description provided for @notificationsAllReadSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All caught up'**
  String get notificationsAllReadSubtitle;

  /// No description provided for @notificationsAllCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up'**
  String get notificationsAllCaughtUp;

  /// No description provided for @notificationsNewBadge.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get notificationsNewBadge;

  /// No description provided for @notificationsRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get notificationsRefresh;

  /// No description provided for @notificationsJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get notificationsJustNow;

  /// No description provided for @notificationsHoursAgoShort.
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String notificationsHoursAgoShort(int hours);

  /// No description provided for @notificationsMinutesAgoShort.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String notificationsMinutesAgoShort(int minutes);

  /// No description provided for @staffNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get staffNavHome;

  /// No description provided for @staffNavPilgrims.
  ///
  /// In en, this message translates to:
  /// **'Pilgrims'**
  String get staffNavPilgrims;

  /// No description provided for @staffNavOperators.
  ///
  /// In en, this message translates to:
  /// **'Operators'**
  String get staffNavOperators;

  /// No description provided for @staffNavGroups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get staffNavGroups;

  /// No description provided for @staffNavContent.
  ///
  /// In en, this message translates to:
  /// **'Content Management'**
  String get staffNavContent;

  /// No description provided for @staffNavCompetitions.
  ///
  /// In en, this message translates to:
  /// **'Competitions'**
  String get staffNavCompetitions;

  /// No description provided for @staffNavNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get staffNavNotifications;

  /// No description provided for @staffNavSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get staffNavSettings;

  /// No description provided for @staffSidebarCollapse.
  ///
  /// In en, this message translates to:
  /// **'Collapse sidebar'**
  String get staffSidebarCollapse;

  /// No description provided for @staffSidebarExpand.
  ///
  /// In en, this message translates to:
  /// **'Expand sidebar'**
  String get staffSidebarExpand;

  /// No description provided for @staffPortalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Portal'**
  String get staffPortalSubtitle;

  /// No description provided for @staffDefaultUser.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get staffDefaultUser;

  /// No description provided for @staffAdminRole.
  ///
  /// In en, this message translates to:
  /// **'Chief Coordinator'**
  String get staffAdminRole;

  /// No description provided for @staffConnectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get staffConnectedStatus;

  /// No description provided for @staffOfflineStatus.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get staffOfflineStatus;

  /// No description provided for @staffOfflineBanner.
  ///
  /// In en, this message translates to:
  /// **'You appear to be offline. Some actions may not work until connectivity is restored.'**
  String get staffOfflineBanner;

  /// No description provided for @staffErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the server. Check your internet connection and try again.'**
  String get staffErrorNetwork;

  /// No description provided for @staffErrorPermission.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to perform this action.'**
  String get staffErrorPermission;

  /// No description provided for @staffErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get staffErrorGeneric;

  /// No description provided for @staffActiveNow.
  ///
  /// In en, this message translates to:
  /// **'Active now'**
  String get staffActiveNow;

  /// No description provided for @staffStable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get staffStable;

  /// No description provided for @staffNavRegister.
  ///
  /// In en, this message translates to:
  /// **'Register pilgrim'**
  String get staffNavRegister;

  /// No description provided for @staffOperatorPortalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Operator Portal'**
  String get staffOperatorPortalSubtitle;

  /// No description provided for @staffOperatorRole.
  ///
  /// In en, this message translates to:
  /// **'Center technician'**
  String get staffOperatorRole;

  /// No description provided for @operatorSectionPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get operatorSectionPersonalInfo;

  /// No description provided for @operatorSectionPersonalInfoHint.
  ///
  /// In en, this message translates to:
  /// **'Full legal name as shown on passport.'**
  String get operatorSectionPersonalInfoHint;

  /// No description provided for @operatorSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Mobile account'**
  String get operatorSectionAccount;

  /// No description provided for @operatorSectionAccountHint.
  ///
  /// In en, this message translates to:
  /// **'Credentials for the pilgrim mobile app.'**
  String get operatorSectionAccountHint;

  /// No description provided for @operatorSectionDocumentsHint.
  ///
  /// In en, this message translates to:
  /// **'Upload passport, permit, or medical files (PDF or images).'**
  String get operatorSectionDocumentsHint;

  /// No description provided for @operatorSectionLogisticsHint.
  ///
  /// In en, this message translates to:
  /// **'Travel and accommodation details (optional at registration).'**
  String get operatorSectionLogisticsHint;

  /// No description provided for @operatorClearForm.
  ///
  /// In en, this message translates to:
  /// **'Clear form'**
  String get operatorClearForm;

  /// No description provided for @operatorPilgrimListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search and manage registered pilgrims.'**
  String get operatorPilgrimListSubtitle;

  /// No description provided for @adminNotificationSendSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Compose and broadcast a bilingual notification.'**
  String get adminNotificationSendSubtitle;

  /// No description provided for @adminNotificationContentSection.
  ///
  /// In en, this message translates to:
  /// **'Message content'**
  String get adminNotificationContentSection;

  /// No description provided for @adminOperatorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Operator management'**
  String get adminOperatorsTitle;

  /// No description provided for @adminOperatorsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add operators and control their roles and permissions.'**
  String get adminOperatorsSubtitle;

  /// No description provided for @adminOperatorAdd.
  ///
  /// In en, this message translates to:
  /// **'Add operator'**
  String get adminOperatorAdd;

  /// No description provided for @adminOperatorNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New operator'**
  String get adminOperatorNewTitle;

  /// No description provided for @adminOperatorEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit operator'**
  String get adminOperatorEditTitle;

  /// No description provided for @adminOperatorFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get adminOperatorFullName;

  /// No description provided for @adminOperatorFullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get adminOperatorFullNameRequired;

  /// No description provided for @adminOperatorEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get adminOperatorEmail;

  /// No description provided for @adminOperatorEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get adminOperatorEmailRequired;

  /// No description provided for @adminOperatorEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get adminOperatorEmailInvalid;

  /// No description provided for @adminOperatorActive.
  ///
  /// In en, this message translates to:
  /// **'Account active'**
  String get adminOperatorActive;

  /// No description provided for @adminOperatorActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminOperatorActiveLabel;

  /// No description provided for @adminOperatorInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adminOperatorInactive;

  /// No description provided for @adminOperatorPermissionsSection.
  ///
  /// In en, this message translates to:
  /// **'Roles & permissions'**
  String get adminOperatorPermissionsSection;

  /// No description provided for @adminOperatorPermRegister.
  ///
  /// In en, this message translates to:
  /// **'Register pilgrims'**
  String get adminOperatorPermRegister;

  /// No description provided for @adminOperatorPermRegisterHint.
  ///
  /// In en, this message translates to:
  /// **'Allow pilgrim intake and mobile account creation.'**
  String get adminOperatorPermRegisterHint;

  /// No description provided for @adminOperatorPermRegistry.
  ///
  /// In en, this message translates to:
  /// **'Manage pilgrim registry'**
  String get adminOperatorPermRegistry;

  /// No description provided for @adminOperatorPermRegistryHint.
  ///
  /// In en, this message translates to:
  /// **'View and edit registered pilgrims.'**
  String get adminOperatorPermRegistryHint;

  /// No description provided for @adminOperatorPermField.
  ///
  /// In en, this message translates to:
  /// **'Field operator tools'**
  String get adminOperatorPermField;

  /// No description provided for @adminOperatorPermFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Access the field operator portal and on-site workflows.'**
  String get adminOperatorPermFieldHint;

  /// No description provided for @adminOperatorPermUpload.
  ///
  /// In en, this message translates to:
  /// **'Upload documents'**
  String get adminOperatorPermUpload;

  /// No description provided for @adminOperatorPermUploadHint.
  ///
  /// In en, this message translates to:
  /// **'Upload pilgrim documents during registration.'**
  String get adminOperatorPermUploadHint;

  /// No description provided for @adminOperatorGroupsSection.
  ///
  /// In en, this message translates to:
  /// **'Group access'**
  String get adminOperatorGroupsSection;

  /// No description provided for @adminOperatorGroupsHint.
  ///
  /// In en, this message translates to:
  /// **'Choose which travel offices (groups) this operator can read and write.'**
  String get adminOperatorGroupsHint;

  /// No description provided for @adminOperatorGroupsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No groups available yet.'**
  String get adminOperatorGroupsEmpty;

  /// No description provided for @adminOperatorGroupRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get adminOperatorGroupRead;

  /// No description provided for @adminOperatorGroupWrite.
  ///
  /// In en, this message translates to:
  /// **'Read & write'**
  String get adminOperatorGroupWrite;

  /// No description provided for @adminOperatorGeneratePassword.
  ///
  /// In en, this message translates to:
  /// **'Generate password'**
  String get adminOperatorGeneratePassword;

  /// No description provided for @adminOperatorPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get adminOperatorPasswordLabel;

  /// No description provided for @adminOperatorPasswordCreateHint.
  ///
  /// In en, this message translates to:
  /// **'Leave blank to auto-generate a secure password.'**
  String get adminOperatorPasswordCreateHint;

  /// No description provided for @adminOperatorPasswordEditHint.
  ///
  /// In en, this message translates to:
  /// **'Leave blank to keep the current password.'**
  String get adminOperatorPasswordEditHint;

  /// No description provided for @adminOperatorCopyPassword.
  ///
  /// In en, this message translates to:
  /// **'Copy password'**
  String get adminOperatorCopyPassword;

  /// No description provided for @adminOperatorCreateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Operator account created'**
  String get adminOperatorCreateSuccess;

  /// No description provided for @adminOperatorSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Operator updated'**
  String get adminOperatorSaveSuccess;

  /// No description provided for @adminOperatorSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save operator. Try again.'**
  String get adminOperatorSaveError;

  /// No description provided for @adminOperatorLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load operators.'**
  String get adminOperatorLoadError;

  /// No description provided for @adminOperatorEmpty.
  ///
  /// In en, this message translates to:
  /// **'No operators yet. Add your first center technician.'**
  String get adminOperatorEmpty;

  /// No description provided for @staffTableEmpty.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get staffTableEmpty;

  /// No description provided for @staffTableRowsPerPage.
  ///
  /// In en, this message translates to:
  /// **'Rows per page'**
  String get staffTableRowsPerPage;

  /// No description provided for @staffTableDensityCompact.
  ///
  /// In en, this message translates to:
  /// **'Compact rows'**
  String get staffTableDensityCompact;

  /// No description provided for @staffTableDensityComfortable.
  ///
  /// In en, this message translates to:
  /// **'Comfortable rows'**
  String get staffTableDensityComfortable;

  /// No description provided for @staffTablePreviousPage.
  ///
  /// In en, this message translates to:
  /// **'Previous page'**
  String get staffTablePreviousPage;

  /// No description provided for @staffTableNextPage.
  ///
  /// In en, this message translates to:
  /// **'Next page'**
  String get staffTableNextPage;

  /// No description provided for @staffTableShowing.
  ///
  /// In en, this message translates to:
  /// **'Showing {from}–{to} of {total}'**
  String staffTableShowing(int from, int to, int total);

  /// No description provided for @staffTablePageOf.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String staffTablePageOf(int current, int total);

  /// No description provided for @staffTableFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get staffTableFilterAll;

  /// No description provided for @staffTableColumnsTitle.
  ///
  /// In en, this message translates to:
  /// **'Table columns'**
  String get staffTableColumnsTitle;

  /// No description provided for @staffTableColumnsApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get staffTableColumnsApply;

  /// No description provided for @staffTableColumnsShowAll.
  ///
  /// In en, this message translates to:
  /// **'Show all'**
  String get staffTableColumnsShowAll;

  /// No description provided for @staffTableColumnsCustomize.
  ///
  /// In en, this message translates to:
  /// **'Columns'**
  String get staffTableColumnsCustomize;

  /// No description provided for @staffTableColumnRequired.
  ///
  /// In en, this message translates to:
  /// **'Always visible'**
  String get staffTableColumnRequired;

  /// No description provided for @staffTableFilterStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get staffTableFilterStatus;

  /// No description provided for @staffTableColumnCreated.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get staffTableColumnCreated;

  /// No description provided for @staffTableSearchOperators.
  ///
  /// In en, this message translates to:
  /// **'Search by name or email'**
  String get staffTableSearchOperators;

  /// No description provided for @staffTableSearchContent.
  ///
  /// In en, this message translates to:
  /// **'Search by title or description'**
  String get staffTableSearchContent;

  /// No description provided for @staffTableSearchCompetitions.
  ///
  /// In en, this message translates to:
  /// **'Search by title or description'**
  String get staffTableSearchCompetitions;

  /// No description provided for @staffTableSearchGroups.
  ///
  /// In en, this message translates to:
  /// **'Search by group or president name'**
  String get staffTableSearchGroups;

  /// No description provided for @staffTableFilterGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get staffTableFilterGender;

  /// No description provided for @staffTableFilterGroup.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get staffTableFilterGroup;

  /// No description provided for @staffTableSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String staffTableSelectedCount(int count);

  /// No description provided for @staffTableClearSelection.
  ///
  /// In en, this message translates to:
  /// **'Clear selection'**
  String get staffTableClearSelection;

  /// No description provided for @pilgrimGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get pilgrimGenderMale;

  /// No description provided for @pilgrimGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get pilgrimGenderFemale;

  /// No description provided for @adminPilgrimAdd.
  ///
  /// In en, this message translates to:
  /// **'Add pilgrim'**
  String get adminPilgrimAdd;

  /// No description provided for @adminPilgrimProfileSection.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim profile'**
  String get adminPilgrimProfileSection;

  /// No description provided for @adminPilgrimBulkAssignGroup.
  ///
  /// In en, this message translates to:
  /// **'Assign group'**
  String get adminPilgrimBulkAssignGroup;

  /// No description provided for @adminPilgrimBulkClearGroup.
  ///
  /// In en, this message translates to:
  /// **'Clear group'**
  String get adminPilgrimBulkClearGroup;

  /// No description provided for @adminPilgrimAssignGroupTitle.
  ///
  /// In en, this message translates to:
  /// **'Assign group to selected pilgrims'**
  String get adminPilgrimAssignGroupTitle;

  /// No description provided for @adminPilgrimAssignGroupConfirm.
  ///
  /// In en, this message translates to:
  /// **'Assign'**
  String get adminPilgrimAssignGroupConfirm;

  /// No description provided for @adminPilgrimAssignGroupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Group updated for selected pilgrims'**
  String get adminPilgrimAssignGroupSuccess;

  /// No description provided for @adminPilgrimAssignGroupError.
  ///
  /// In en, this message translates to:
  /// **'Could not update group assignment'**
  String get adminPilgrimAssignGroupError;

  /// No description provided for @adminPilgrimNoGroups.
  ///
  /// In en, this message translates to:
  /// **'No groups available. Create a group first.'**
  String get adminPilgrimNoGroups;

  /// No description provided for @adminGroupsTitle.
  ///
  /// In en, this message translates to:
  /// **'Group management'**
  String get adminGroupsTitle;

  /// No description provided for @adminGroupsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Hajj groups, leadership, and administration members.'**
  String get adminGroupsSubtitle;

  /// No description provided for @adminGroupAdd.
  ///
  /// In en, this message translates to:
  /// **'Add group'**
  String get adminGroupAdd;

  /// No description provided for @adminGroupNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New group'**
  String get adminGroupNewTitle;

  /// No description provided for @adminGroupEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit group'**
  String get adminGroupEditTitle;

  /// No description provided for @adminGroupDetailsSection.
  ///
  /// In en, this message translates to:
  /// **'Group details'**
  String get adminGroupDetailsSection;

  /// No description provided for @adminGroupName.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get adminGroupName;

  /// No description provided for @adminGroupNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Group name is required'**
  String get adminGroupNameRequired;

  /// No description provided for @adminGroupUploadLogo.
  ///
  /// In en, this message translates to:
  /// **'Upload logo'**
  String get adminGroupUploadLogo;

  /// No description provided for @adminGroupPresidentName.
  ///
  /// In en, this message translates to:
  /// **'President name'**
  String get adminGroupPresidentName;

  /// No description provided for @adminGroupPresidentPhone.
  ///
  /// In en, this message translates to:
  /// **'President phone'**
  String get adminGroupPresidentPhone;

  /// No description provided for @adminGroupMembersSection.
  ///
  /// In en, this message translates to:
  /// **'Administration members'**
  String get adminGroupMembersSection;

  /// No description provided for @adminGroupMembersSectionHint.
  ///
  /// In en, this message translates to:
  /// **'Add coordinators and staff with their roles and contact details.'**
  String get adminGroupMembersSectionHint;

  /// No description provided for @adminGroupAddMember.
  ///
  /// In en, this message translates to:
  /// **'Add member'**
  String get adminGroupAddMember;

  /// No description provided for @adminGroupRemoveMember.
  ///
  /// In en, this message translates to:
  /// **'Remove member'**
  String get adminGroupRemoveMember;

  /// No description provided for @adminGroupMembersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No administration members yet.'**
  String get adminGroupMembersEmpty;

  /// No description provided for @adminGroupMemberName.
  ///
  /// In en, this message translates to:
  /// **'Member name'**
  String get adminGroupMemberName;

  /// No description provided for @adminGroupMemberNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Member name is required'**
  String get adminGroupMemberNameRequired;

  /// No description provided for @adminGroupMemberPosition.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get adminGroupMemberPosition;

  /// No description provided for @adminGroupMemberContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get adminGroupMemberContact;

  /// No description provided for @adminGroupUploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload photo'**
  String get adminGroupUploadPhoto;

  /// No description provided for @adminGroupMembersCount.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get adminGroupMembersCount;

  /// No description provided for @adminGroupCreateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Group created'**
  String get adminGroupCreateSuccess;

  /// No description provided for @adminGroupSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Group updated'**
  String get adminGroupSaveSuccess;

  /// No description provided for @adminGroupSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save group. Try again.'**
  String get adminGroupSaveError;

  /// No description provided for @adminGroupsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load groups.'**
  String get adminGroupsLoadError;

  /// No description provided for @adminGroupsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No groups yet. Add your first Hajj group.'**
  String get adminGroupsEmpty;

  /// No description provided for @adminGroupDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete group?'**
  String get adminGroupDeleteTitle;

  /// No description provided for @adminGroupDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"? Pilgrims in this group will be unassigned.'**
  String adminGroupDeleteMessage(String name);

  /// No description provided for @adminGroupDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminGroupDeleteConfirm;

  /// No description provided for @adminGroupDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Group deleted'**
  String get adminGroupDeleteSuccess;

  /// No description provided for @adminGroupDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete group'**
  String get adminGroupDeleteError;

  /// No description provided for @adminSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'System settings'**
  String get adminSettingsTitle;

  /// No description provided for @adminSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure organization details, features, and platform behavior.'**
  String get adminSettingsSubtitle;

  /// No description provided for @adminSettingsSave.
  ///
  /// In en, this message translates to:
  /// **'Save settings'**
  String get adminSettingsSave;

  /// No description provided for @adminSettingsSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get adminSettingsSaveSuccess;

  /// No description provided for @adminSettingsSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save settings. Try again.'**
  String get adminSettingsSaveError;

  /// No description provided for @adminSettingsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load settings.'**
  String get adminSettingsLoadError;

  /// No description provided for @adminSettingsOrganizationSection.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get adminSettingsOrganizationSection;

  /// No description provided for @adminSettingsOrganizationSectionHint.
  ///
  /// In en, this message translates to:
  /// **'Public-facing name and support contacts for the Hajj season.'**
  String get adminSettingsOrganizationSectionHint;

  /// No description provided for @adminSettingsOrganizationName.
  ///
  /// In en, this message translates to:
  /// **'Organization name'**
  String get adminSettingsOrganizationName;

  /// No description provided for @adminSettingsOrganizationNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Organization name is required'**
  String get adminSettingsOrganizationNameRequired;

  /// No description provided for @adminSettingsHajjSeason.
  ///
  /// In en, this message translates to:
  /// **'Hajj season label'**
  String get adminSettingsHajjSeason;

  /// No description provided for @adminSettingsSupportEmail.
  ///
  /// In en, this message translates to:
  /// **'Support email'**
  String get adminSettingsSupportEmail;

  /// No description provided for @adminSettingsSupportPhone.
  ///
  /// In en, this message translates to:
  /// **'Support phone'**
  String get adminSettingsSupportPhone;

  /// No description provided for @adminSettingsOperationsSection.
  ///
  /// In en, this message translates to:
  /// **'Operations'**
  String get adminSettingsOperationsSection;

  /// No description provided for @adminSettingsOperationsSectionHint.
  ///
  /// In en, this message translates to:
  /// **'Control registration availability and maintenance windows.'**
  String get adminSettingsOperationsSectionHint;

  /// No description provided for @adminSettingsRegistrationOpen.
  ///
  /// In en, this message translates to:
  /// **'Registration open'**
  String get adminSettingsRegistrationOpen;

  /// No description provided for @adminSettingsRegistrationOpenHint.
  ///
  /// In en, this message translates to:
  /// **'Allow operators to register new pilgrims.'**
  String get adminSettingsRegistrationOpenHint;

  /// No description provided for @adminSettingsMaintenanceMode.
  ///
  /// In en, this message translates to:
  /// **'Maintenance mode'**
  String get adminSettingsMaintenanceMode;

  /// No description provided for @adminSettingsMaintenanceModeHint.
  ///
  /// In en, this message translates to:
  /// **'Show a maintenance message and limit staff actions.'**
  String get adminSettingsMaintenanceModeHint;

  /// No description provided for @adminSettingsMaintenanceMessage.
  ///
  /// In en, this message translates to:
  /// **'Maintenance message'**
  String get adminSettingsMaintenanceMessage;

  /// No description provided for @adminSettingsIntakeSection.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim intake'**
  String get adminSettingsIntakeSection;

  /// No description provided for @adminSettingsIntakeSectionHint.
  ///
  /// In en, this message translates to:
  /// **'Defaults for operator registration workflows.'**
  String get adminSettingsIntakeSectionHint;

  /// No description provided for @adminSettingsRequireDocuments.
  ///
  /// In en, this message translates to:
  /// **'Require documents on intake'**
  String get adminSettingsRequireDocuments;

  /// No description provided for @adminSettingsRequireDocumentsHint.
  ///
  /// In en, this message translates to:
  /// **'Operators must upload required documents when registering pilgrims.'**
  String get adminSettingsRequireDocumentsHint;

  /// No description provided for @adminSettingsAutoGeneratePassword.
  ///
  /// In en, this message translates to:
  /// **'Auto-generate pilgrim passwords'**
  String get adminSettingsAutoGeneratePassword;

  /// No description provided for @adminSettingsAutoGeneratePasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Create secure passwords automatically during registration.'**
  String get adminSettingsAutoGeneratePasswordHint;

  /// No description provided for @adminSettingsOperatorSelfRegistration.
  ///
  /// In en, this message translates to:
  /// **'Allow operator self-registration'**
  String get adminSettingsOperatorSelfRegistration;

  /// No description provided for @adminSettingsOperatorSelfRegistrationHint.
  ///
  /// In en, this message translates to:
  /// **'Let new operators request accounts without admin approval.'**
  String get adminSettingsOperatorSelfRegistrationHint;

  /// No description provided for @adminSettingsMaxPilgrimsPerGroup.
  ///
  /// In en, this message translates to:
  /// **'Max pilgrims per group'**
  String get adminSettingsMaxPilgrimsPerGroup;

  /// No description provided for @adminSettingsMaxPilgrimsPerGroupHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for no limit.'**
  String get adminSettingsMaxPilgrimsPerGroupHint;

  /// No description provided for @adminSettingsMaxPilgrimsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a positive number or leave empty.'**
  String get adminSettingsMaxPilgrimsInvalid;

  /// No description provided for @adminSettingsFeaturesSection.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get adminSettingsFeaturesSection;

  /// No description provided for @adminSettingsFeaturesSectionHint.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable major app modules.'**
  String get adminSettingsFeaturesSectionHint;

  /// No description provided for @adminSettingsPublicContentFeed.
  ///
  /// In en, this message translates to:
  /// **'Public content feed'**
  String get adminSettingsPublicContentFeed;

  /// No description provided for @adminSettingsPublicContentFeedHint.
  ///
  /// In en, this message translates to:
  /// **'Show news and videos on the pilgrim home screen.'**
  String get adminSettingsPublicContentFeedHint;

  /// No description provided for @adminSettingsCompetitions.
  ///
  /// In en, this message translates to:
  /// **'Competitions'**
  String get adminSettingsCompetitions;

  /// No description provided for @adminSettingsCompetitionsHint.
  ///
  /// In en, this message translates to:
  /// **'Allow pilgrims to view and join Hajj competitions.'**
  String get adminSettingsCompetitionsHint;

  /// No description provided for @adminSettingsRitualTracking.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim ritual tracking'**
  String get adminSettingsRitualTracking;

  /// No description provided for @adminSettingsRitualTrackingHint.
  ///
  /// In en, this message translates to:
  /// **'Track and display ritual progress for pilgrims.'**
  String get adminSettingsRitualTrackingHint;

  /// No description provided for @adminSettingsNotificationsSection.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get adminSettingsNotificationsSection;

  /// No description provided for @adminSettingsNotificationsSectionHint.
  ///
  /// In en, this message translates to:
  /// **'Control in-app and push notification delivery.'**
  String get adminSettingsNotificationsSectionHint;

  /// No description provided for @adminSettingsInAppNotifications.
  ///
  /// In en, this message translates to:
  /// **'In-app notifications'**
  String get adminSettingsInAppNotifications;

  /// No description provided for @adminSettingsInAppNotificationsHint.
  ///
  /// In en, this message translates to:
  /// **'Deliver notifications inside the pilgrim inbox.'**
  String get adminSettingsInAppNotificationsHint;

  /// No description provided for @adminSettingsPushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get adminSettingsPushNotifications;

  /// No description provided for @adminSettingsPushNotificationsHint.
  ///
  /// In en, this message translates to:
  /// **'Send Firebase push notifications to devices.'**
  String get adminSettingsPushNotificationsHint;

  /// No description provided for @adminSettingsPushNotificationsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Firebase is not configured. Push notifications cannot be enabled.'**
  String get adminSettingsPushNotificationsUnavailable;

  /// No description provided for @adminSettingsManagementSection.
  ///
  /// In en, this message translates to:
  /// **'Management shortcuts'**
  String get adminSettingsManagementSection;

  /// No description provided for @adminSettingsManagementSectionHint.
  ///
  /// In en, this message translates to:
  /// **'Jump to related admin areas.'**
  String get adminSettingsManagementSectionHint;

  /// No description provided for @adminSettingsIntegrationsSection.
  ///
  /// In en, this message translates to:
  /// **'Integrations'**
  String get adminSettingsIntegrationsSection;

  /// No description provided for @adminSettingsIntegrationsSectionHint.
  ///
  /// In en, this message translates to:
  /// **'Backend services configured for this deployment.'**
  String get adminSettingsIntegrationsSectionHint;

  /// No description provided for @adminSettingsSupabaseStatus.
  ///
  /// In en, this message translates to:
  /// **'Supabase'**
  String get adminSettingsSupabaseStatus;

  /// No description provided for @adminSettingsFirebaseStatus.
  ///
  /// In en, this message translates to:
  /// **'Firebase'**
  String get adminSettingsFirebaseStatus;

  /// No description provided for @adminSettingsStatusConfigured.
  ///
  /// In en, this message translates to:
  /// **'Configured'**
  String get adminSettingsStatusConfigured;

  /// No description provided for @adminSettingsStatusNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get adminSettingsStatusNotConfigured;

  /// No description provided for @adminSettingsLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated {date}'**
  String adminSettingsLastUpdated(String date);

  /// No description provided for @profilePilgrimSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Registration details entered by your operator.'**
  String get profilePilgrimSubtitle;

  /// No description provided for @servicesHeroBadge.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim services'**
  String get servicesHeroBadge;

  /// No description provided for @servicesHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Services hub'**
  String get servicesHeroTitle;

  /// No description provided for @servicesHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hajj journey and competitions in one place.'**
  String get servicesHeroSubtitle;

  /// No description provided for @servicesJourneySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn Hajj rituals step by step with educational media.'**
  String get servicesJourneySubtitle;

  /// No description provided for @servicesCompetitionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Test your knowledge and earn points in Hajj quizzes.'**
  String get servicesCompetitionsSubtitle;

  /// No description provided for @servicesNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View your latest alerts and announcements.'**
  String get servicesNotificationsSubtitle;

  /// No description provided for @hajjJourneyHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Follow a learning path through Hajj rituals from Ihram to farewell tawaf.'**
  String get hajjJourneyHeroSubtitle;

  /// No description provided for @hajjJourneyPathTitle.
  ///
  /// In en, this message translates to:
  /// **'Ritual path'**
  String get hajjJourneyPathTitle;

  /// No description provided for @hajjJourneyPathSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete each ritual to unlock the next — like the competition track.'**
  String get hajjJourneyPathSubtitle;

  /// No description provided for @hajjJourneyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No journey steps available right now.'**
  String get hajjJourneyEmpty;

  /// No description provided for @hajjJourneyLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load Hajj journey.'**
  String get hajjJourneyLoadError;

  /// No description provided for @hajjJourneyStepLocked.
  ///
  /// In en, this message translates to:
  /// **'Complete the previous ritual first to unlock this one.'**
  String get hajjJourneyStepLocked;

  /// No description provided for @hajjJourneyStepNotFound.
  ///
  /// In en, this message translates to:
  /// **'This ritual was not found.'**
  String get hajjJourneyStepNotFound;

  /// No description provided for @hajjJourneyContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue your current ritual'**
  String get hajjJourneyContinue;

  /// No description provided for @hajjJourneyAboutRitual.
  ///
  /// In en, this message translates to:
  /// **'About this ritual'**
  String get hajjJourneyAboutRitual;

  /// No description provided for @hajjJourneyMediaTitle.
  ///
  /// In en, this message translates to:
  /// **'Educational media'**
  String get hajjJourneyMediaTitle;

  /// No description provided for @hajjJourneyNoMedia.
  ///
  /// In en, this message translates to:
  /// **'No media for this ritual yet.'**
  String get hajjJourneyNoMedia;

  /// No description provided for @hajjJourneyMediaVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get hajjJourneyMediaVideo;

  /// No description provided for @hajjJourneyMediaAudio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get hajjJourneyMediaAudio;

  /// No description provided for @hajjJourneyMediaImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get hajjJourneyMediaImage;

  /// No description provided for @hajjJourneyImageCounter.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String hajjJourneyImageCounter(int current, int total);

  /// No description provided for @hajjJourneySlideshowStart.
  ///
  /// In en, this message translates to:
  /// **'Start slideshow'**
  String get hajjJourneySlideshowStart;

  /// No description provided for @hajjJourneySlideshowStop.
  ///
  /// In en, this message translates to:
  /// **'Stop slideshow'**
  String get hajjJourneySlideshowStop;

  /// No description provided for @educationalMediaTitle.
  ///
  /// In en, this message translates to:
  /// **'Educational media'**
  String get educationalMediaTitle;

  /// No description provided for @educationalMediaEmpty.
  ///
  /// In en, this message translates to:
  /// **'No media available.'**
  String get educationalMediaEmpty;

  /// No description provided for @educationalMediaVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get educationalMediaVideo;

  /// No description provided for @educationalMediaAudio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get educationalMediaAudio;

  /// No description provided for @educationalMediaImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get educationalMediaImage;

  /// No description provided for @educationalMediaImageCounter.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String educationalMediaImageCounter(int current, int total);

  /// No description provided for @educationalMediaSlideshowStart.
  ///
  /// In en, this message translates to:
  /// **'Start slideshow'**
  String get educationalMediaSlideshowStart;

  /// No description provided for @educationalMediaSlideshowStop.
  ///
  /// In en, this message translates to:
  /// **'Stop slideshow'**
  String get educationalMediaSlideshowStop;

  /// No description provided for @adminContentTopicsManage.
  ///
  /// In en, this message translates to:
  /// **'Educational topics'**
  String get adminContentTopicsManage;

  /// No description provided for @adminContentTopicsListTitle.
  ///
  /// In en, this message translates to:
  /// **'Content topics'**
  String get adminContentTopicsListTitle;

  /// No description provided for @adminContentTopicAdd.
  ///
  /// In en, this message translates to:
  /// **'Add topic'**
  String get adminContentTopicAdd;

  /// No description provided for @adminContentTopicEmpty.
  ///
  /// In en, this message translates to:
  /// **'No topics yet.'**
  String get adminContentTopicEmpty;

  /// No description provided for @adminContentTopicMediaItems.
  ///
  /// In en, this message translates to:
  /// **'media'**
  String get adminContentTopicMediaItems;

  /// No description provided for @adminContentTopicLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load topics.'**
  String get adminContentTopicLoadError;

  /// No description provided for @adminContentTopicDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete topic'**
  String get adminContentTopicDeleteTitle;

  /// No description provided for @adminContentTopicDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{title}\"?'**
  String adminContentTopicDeleteMessage(String title);

  /// No description provided for @adminContentTopicDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Topic deleted.'**
  String get adminContentTopicDeleteSuccess;

  /// No description provided for @adminContentTopicDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete topic.'**
  String get adminContentTopicDeleteError;

  /// No description provided for @adminContentTopicEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit topic'**
  String get adminContentTopicEditTitle;

  /// No description provided for @adminContentTopicNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New topic'**
  String get adminContentTopicNewTitle;

  /// No description provided for @adminContentTopicTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a topic title.'**
  String get adminContentTopicTitleRequired;

  /// No description provided for @adminContentTopicDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get adminContentTopicDescription;

  /// No description provided for @adminContentTopicCoverUrl.
  ///
  /// In en, this message translates to:
  /// **'Cover image URL'**
  String get adminContentTopicCoverUrl;

  /// No description provided for @adminContentTopicMediaSection.
  ///
  /// In en, this message translates to:
  /// **'Media series'**
  String get adminContentTopicMediaSection;

  /// No description provided for @adminContentTopicSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Topic saved.'**
  String get adminContentTopicSaveSuccess;

  /// No description provided for @adminContentTopicSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save topic.'**
  String get adminContentTopicSaveError;

  /// No description provided for @adminContentTopicUploadCover.
  ///
  /// In en, this message translates to:
  /// **'Upload cover image'**
  String get adminContentTopicUploadCover;

  /// No description provided for @adminContentTopicUploadMedia.
  ///
  /// In en, this message translates to:
  /// **'Upload file'**
  String get adminContentTopicUploadMedia;

  /// No description provided for @adminContentTopicUploadSuccess.
  ///
  /// In en, this message translates to:
  /// **'File uploaded successfully.'**
  String get adminContentTopicUploadSuccess;

  /// No description provided for @adminContentTopicUploadError.
  ///
  /// In en, this message translates to:
  /// **'Could not upload file.'**
  String get adminContentTopicUploadError;

  /// No description provided for @adminContentTopicMediaPreview.
  ///
  /// In en, this message translates to:
  /// **'Media preview'**
  String get adminContentTopicMediaPreview;

  /// No description provided for @contentOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline content'**
  String get contentOfflineTitle;

  /// No description provided for @contentOfflineSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Download educational topics (audio and images) for use without internet.'**
  String get contentOfflineSubtitle;

  /// No description provided for @contentOfflineEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable automatic download'**
  String get contentOfflineEnable;

  /// No description provided for @contentOfflineDownloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading in background…'**
  String get contentOfflineDownloading;

  /// No description provided for @contentOfflineCachedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} files saved locally'**
  String contentOfflineCachedCount(int count);

  /// No description provided for @contentOfflineClearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear saved content'**
  String get contentOfflineClearCache;

  /// No description provided for @contentTopicOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline use'**
  String get contentTopicOfflineTitle;

  /// No description provided for @contentTopicOfflineProgress.
  ///
  /// In en, this message translates to:
  /// **'{cached} / {total} files ready'**
  String contentTopicOfflineProgress(int cached, int total);

  /// No description provided for @contentTopicOfflineDownload.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get contentTopicOfflineDownload;

  /// No description provided for @contentTopicOfflineStarted.
  ///
  /// In en, this message translates to:
  /// **'Background download started.'**
  String get contentTopicOfflineStarted;

  /// No description provided for @hajjJourneyMarkComplete.
  ///
  /// In en, this message translates to:
  /// **'Mark complete'**
  String get hajjJourneyMarkComplete;

  /// No description provided for @hajjJourneyAlreadyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed — back to path'**
  String get hajjJourneyAlreadyCompleted;

  /// No description provided for @hajjJourneyCompletedSnack.
  ///
  /// In en, this message translates to:
  /// **'Well done! Ritual marked complete.'**
  String get hajjJourneyCompletedSnack;

  /// No description provided for @hajjJourneyNextStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Next ritual'**
  String get hajjJourneyNextStepTitle;

  /// No description provided for @hajjJourneyNextStepBody.
  ///
  /// In en, this message translates to:
  /// **'Would you like to go to the next ritual?'**
  String get hajjJourneyNextStepBody;

  /// No description provided for @hajjJourneyStayHere.
  ///
  /// In en, this message translates to:
  /// **'Stay here'**
  String get hajjJourneyStayHere;

  /// No description provided for @hajjJourneyGoNext.
  ///
  /// In en, this message translates to:
  /// **'Next ritual'**
  String get hajjJourneyGoNext;

  /// No description provided for @adminManageHajjJourney.
  ///
  /// In en, this message translates to:
  /// **'Manage Hajj journey'**
  String get adminManageHajjJourney;

  /// No description provided for @adminHajjJourneyTitle.
  ///
  /// In en, this message translates to:
  /// **'Hajj journey'**
  String get adminHajjJourneyTitle;

  /// No description provided for @adminHajjJourneyLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load Hajj journey steps.'**
  String get adminHajjJourneyLoadError;

  /// No description provided for @adminHajjJourneyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No steps yet. Apply the database migration.'**
  String get adminHajjJourneyEmpty;

  /// No description provided for @adminHajjJourneyMediaCount.
  ///
  /// In en, this message translates to:
  /// **'{count} media items'**
  String adminHajjJourneyMediaCount(int count);

  /// No description provided for @adminHajjJourneyInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adminHajjJourneyInactive;

  /// No description provided for @adminHajjJourneyEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit ritual'**
  String get adminHajjJourneyEditTitle;

  /// No description provided for @adminHajjJourneyTitleAr.
  ///
  /// In en, this message translates to:
  /// **'Title (Arabic)'**
  String get adminHajjJourneyTitleAr;

  /// No description provided for @adminHajjJourneyTitleEn.
  ///
  /// In en, this message translates to:
  /// **'Title (English)'**
  String get adminHajjJourneyTitleEn;

  /// No description provided for @adminHajjJourneyDescriptionAr.
  ///
  /// In en, this message translates to:
  /// **'Description (Arabic)'**
  String get adminHajjJourneyDescriptionAr;

  /// No description provided for @adminHajjJourneyDescriptionEn.
  ///
  /// In en, this message translates to:
  /// **'Description (English)'**
  String get adminHajjJourneyDescriptionEn;

  /// No description provided for @adminHajjJourneySortOrder.
  ///
  /// In en, this message translates to:
  /// **'Display order'**
  String get adminHajjJourneySortOrder;

  /// No description provided for @adminHajjJourneyActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminHajjJourneyActive;

  /// No description provided for @adminHajjJourneyMediaSection.
  ///
  /// In en, this message translates to:
  /// **'Educational media'**
  String get adminHajjJourneyMediaSection;

  /// No description provided for @adminHajjJourneyMediaType.
  ///
  /// In en, this message translates to:
  /// **'Media type'**
  String get adminHajjJourneyMediaType;

  /// No description provided for @adminHajjJourneyMediaTitle.
  ///
  /// In en, this message translates to:
  /// **'Media title'**
  String get adminHajjJourneyMediaTitle;

  /// No description provided for @adminHajjJourneyMediaUrl.
  ///
  /// In en, this message translates to:
  /// **'Media URL'**
  String get adminHajjJourneyMediaUrl;

  /// No description provided for @adminHajjJourneyRemoveMedia.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get adminHajjJourneyRemoveMedia;

  /// No description provided for @adminHajjJourneyTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Arabic and English titles are required.'**
  String get adminHajjJourneyTitleRequired;

  /// No description provided for @adminHajjJourneySaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Ritual saved.'**
  String get adminHajjJourneySaveSuccess;

  /// No description provided for @adminHajjJourneySaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save ritual.'**
  String get adminHajjJourneySaveError;

  /// No description provided for @staffNavTrips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get staffNavTrips;

  /// No description provided for @adminTripsTitle.
  ///
  /// In en, this message translates to:
  /// **'Trip management'**
  String get adminTripsTitle;

  /// No description provided for @adminTripsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Hajj and Umrah trips per season and the offices that join them.'**
  String get adminTripsSubtitle;

  /// No description provided for @adminTripAdd.
  ///
  /// In en, this message translates to:
  /// **'Add trip'**
  String get adminTripAdd;

  /// No description provided for @adminTripsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No trips yet. Add your first Hajj or Umrah trip.'**
  String get adminTripsEmpty;

  /// No description provided for @adminTripsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load trips.'**
  String get adminTripsLoadError;

  /// No description provided for @adminTripNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New trip'**
  String get adminTripNewTitle;

  /// No description provided for @adminTripEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit trip'**
  String get adminTripEditTitle;

  /// No description provided for @adminTripName.
  ///
  /// In en, this message translates to:
  /// **'Trip name'**
  String get adminTripName;

  /// No description provided for @adminTripNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Trip name is required'**
  String get adminTripNameRequired;

  /// No description provided for @adminTripType.
  ///
  /// In en, this message translates to:
  /// **'Trip type'**
  String get adminTripType;

  /// No description provided for @adminTripTypeHajj.
  ///
  /// In en, this message translates to:
  /// **'Hajj'**
  String get adminTripTypeHajj;

  /// No description provided for @adminTripTypeUmrah.
  ///
  /// In en, this message translates to:
  /// **'Umrah'**
  String get adminTripTypeUmrah;

  /// No description provided for @adminTripSeasonYear.
  ///
  /// In en, this message translates to:
  /// **'Season year'**
  String get adminTripSeasonYear;

  /// No description provided for @adminTripSeasonYearRequired.
  ///
  /// In en, this message translates to:
  /// **'A valid season year is required'**
  String get adminTripSeasonYearRequired;

  /// No description provided for @adminTripStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminTripStatus;

  /// No description provided for @adminTripMarkActive.
  ///
  /// In en, this message translates to:
  /// **'Set active'**
  String get adminTripMarkActive;

  /// No description provided for @adminTripMarkFinished.
  ///
  /// In en, this message translates to:
  /// **'Mark finished'**
  String get adminTripMarkFinished;

  /// No description provided for @adminTripStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Trip status updated'**
  String get adminTripStatusUpdated;

  /// No description provided for @adminTripStatusPlanning.
  ///
  /// In en, this message translates to:
  /// **'Planning'**
  String get adminTripStatusPlanning;

  /// No description provided for @adminTripStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminTripStatusActive;

  /// No description provided for @adminTripStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get adminTripStatusCompleted;

  /// No description provided for @adminTripStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get adminTripStatusCancelled;

  /// No description provided for @adminTripSave.
  ///
  /// In en, this message translates to:
  /// **'Save trip'**
  String get adminTripSave;

  /// No description provided for @adminTripCreateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Trip created'**
  String get adminTripCreateSuccess;

  /// No description provided for @adminTripSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Trip updated'**
  String get adminTripSaveSuccess;

  /// No description provided for @adminTripSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save trip. Try again.'**
  String get adminTripSaveError;

  /// No description provided for @adminTripDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete trip?'**
  String get adminTripDeleteTitle;

  /// No description provided for @adminTripDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"? All enrollments in this trip will be removed.'**
  String adminTripDeleteMessage(String name);

  /// No description provided for @adminTripDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminTripDeleteConfirm;

  /// No description provided for @adminTripDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Trip deleted'**
  String get adminTripDeleteSuccess;

  /// No description provided for @adminTripDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete trip'**
  String get adminTripDeleteError;

  /// No description provided for @adminTripManageOffices.
  ///
  /// In en, this message translates to:
  /// **'Manage offices'**
  String get adminTripManageOffices;

  /// No description provided for @adminTripOfficesTitle.
  ///
  /// In en, this message translates to:
  /// **'Participating offices'**
  String get adminTripOfficesTitle;

  /// No description provided for @adminTripOfficesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add or withdraw travel offices for this trip.'**
  String get adminTripOfficesSubtitle;

  /// No description provided for @adminTripOfficesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No offices joined this trip yet.'**
  String get adminTripOfficesEmpty;

  /// No description provided for @adminTripAddOffice.
  ///
  /// In en, this message translates to:
  /// **'Add office'**
  String get adminTripAddOffice;

  /// No description provided for @adminTripNoAvailableOffices.
  ///
  /// In en, this message translates to:
  /// **'All offices already joined this trip.'**
  String get adminTripNoAvailableOffices;

  /// No description provided for @adminTripOfficeWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get adminTripOfficeWithdraw;

  /// No description provided for @adminTripOfficeActivate.
  ///
  /// In en, this message translates to:
  /// **'Reactivate'**
  String get adminTripOfficeActivate;

  /// No description provided for @adminTripOfficeRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get adminTripOfficeRemove;

  /// No description provided for @adminTripOfficeActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminTripOfficeActive;

  /// No description provided for @adminTripOfficeWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Withdrawn'**
  String get adminTripOfficeWithdrawn;

  /// No description provided for @adminTripOfficeUpdated.
  ///
  /// In en, this message translates to:
  /// **'Office updated'**
  String get adminTripOfficeUpdated;

  /// No description provided for @adminTripOfficeAdded.
  ///
  /// In en, this message translates to:
  /// **'Office added to trip'**
  String get adminTripOfficeAdded;

  /// No description provided for @adminTripOfficeError.
  ///
  /// In en, this message translates to:
  /// **'Could not update office'**
  String get adminTripOfficeError;

  /// No description provided for @tripSelectorLabel.
  ///
  /// In en, this message translates to:
  /// **'Active trip'**
  String get tripSelectorLabel;

  /// No description provided for @tripSelectorAll.
  ///
  /// In en, this message translates to:
  /// **'All trips'**
  String get tripSelectorAll;

  /// No description provided for @staffNavContacts.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get staffNavContacts;

  /// No description provided for @staffNavSos.
  ///
  /// In en, this message translates to:
  /// **'SOS alerts'**
  String get staffNavSos;

  /// No description provided for @servicesContactsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency and service numbers — call or message on WhatsApp.'**
  String get servicesContactsSubtitle;

  /// No description provided for @supportContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & contacts'**
  String get supportContactsTitle;

  /// No description provided for @supportContactsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reach the right team quickly. Call or message on WhatsApp.'**
  String get supportContactsSubtitle;

  /// No description provided for @supportContactsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No contacts are available right now.'**
  String get supportContactsEmpty;

  /// No description provided for @supportContactsError.
  ///
  /// In en, this message translates to:
  /// **'Could not load contacts. Check your connection.'**
  String get supportContactsError;

  /// No description provided for @supportContactsCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get supportContactsCall;

  /// No description provided for @supportContactsWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get supportContactsWhatsapp;

  /// No description provided for @supportContactsLaunchFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open this contact.'**
  String get supportContactsLaunchFailed;

  /// No description provided for @adminSupportContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Support contacts'**
  String get adminSupportContactsTitle;

  /// No description provided for @adminSupportContactsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Phone and WhatsApp numbers shown to pilgrims.'**
  String get adminSupportContactsSubtitle;

  /// No description provided for @adminSupportContactsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No contacts yet. Add the first one.'**
  String get adminSupportContactsEmpty;

  /// No description provided for @adminSupportContactAdd.
  ///
  /// In en, this message translates to:
  /// **'Add contact'**
  String get adminSupportContactAdd;

  /// No description provided for @adminSupportContactEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit contact'**
  String get adminSupportContactEditTitle;

  /// No description provided for @adminSupportContactNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New contact'**
  String get adminSupportContactNewTitle;

  /// No description provided for @adminSupportContactDetailsSection.
  ///
  /// In en, this message translates to:
  /// **'Contact details'**
  String get adminSupportContactDetailsSection;

  /// No description provided for @adminSupportContactScopeSection.
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get adminSupportContactScopeSection;

  /// No description provided for @adminSupportContactLabelAr.
  ///
  /// In en, this message translates to:
  /// **'Label (Arabic)'**
  String get adminSupportContactLabelAr;

  /// No description provided for @adminSupportContactLabelEn.
  ///
  /// In en, this message translates to:
  /// **'Label (English)'**
  String get adminSupportContactLabelEn;

  /// No description provided for @adminSupportContactLabelRequired.
  ///
  /// In en, this message translates to:
  /// **'Both labels are required'**
  String get adminSupportContactLabelRequired;

  /// No description provided for @adminSupportContactDescriptionAr.
  ///
  /// In en, this message translates to:
  /// **'Description (Arabic)'**
  String get adminSupportContactDescriptionAr;

  /// No description provided for @adminSupportContactDescriptionEn.
  ///
  /// In en, this message translates to:
  /// **'Description (English)'**
  String get adminSupportContactDescriptionEn;

  /// No description provided for @adminSupportContactPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get adminSupportContactPhone;

  /// No description provided for @adminSupportContactWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp number'**
  String get adminSupportContactWhatsapp;

  /// No description provided for @adminSupportContactScope.
  ///
  /// In en, this message translates to:
  /// **'Audience'**
  String get adminSupportContactScope;

  /// No description provided for @adminSupportContactScopeGlobal.
  ///
  /// In en, this message translates to:
  /// **'Everyone'**
  String get adminSupportContactScopeGlobal;

  /// No description provided for @adminSupportContactScopeGroup.
  ///
  /// In en, this message translates to:
  /// **'Specific group'**
  String get adminSupportContactScopeGroup;

  /// No description provided for @adminSupportContactGroup.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get adminSupportContactGroup;

  /// No description provided for @adminSupportContactGroupRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose a group for this contact'**
  String get adminSupportContactGroupRequired;

  /// No description provided for @adminSupportContactChannelRequired.
  ///
  /// In en, this message translates to:
  /// **'Add a phone or WhatsApp number'**
  String get adminSupportContactChannelRequired;

  /// No description provided for @adminSupportContactSortOrder.
  ///
  /// In en, this message translates to:
  /// **'Sort order'**
  String get adminSupportContactSortOrder;

  /// No description provided for @adminSupportContactActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminSupportContactActive;

  /// No description provided for @adminSupportContactActiveHint.
  ///
  /// In en, this message translates to:
  /// **'Inactive contacts are hidden from pilgrims.'**
  String get adminSupportContactActiveHint;

  /// No description provided for @adminSupportContactActiveBadge.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminSupportContactActiveBadge;

  /// No description provided for @adminSupportContactInactiveBadge.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get adminSupportContactInactiveBadge;

  /// No description provided for @adminSupportContactSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Contact saved'**
  String get adminSupportContactSaveSuccess;

  /// No description provided for @adminSupportContactCreateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Contact added'**
  String get adminSupportContactCreateSuccess;

  /// No description provided for @adminSupportContactSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save contact. Try again.'**
  String get adminSupportContactSaveError;

  /// No description provided for @adminSupportContactDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete contact'**
  String get adminSupportContactDeleteTitle;

  /// No description provided for @adminSupportContactDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{label}\"?'**
  String adminSupportContactDeleteMessage(String label);

  /// No description provided for @adminSupportContactDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminSupportContactDeleteConfirm;

  /// No description provided for @adminSupportContactDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Contact deleted'**
  String get adminSupportContactDeleteSuccess;

  /// No description provided for @adminSupportContactDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Could not delete contact'**
  String get adminSupportContactDeleteError;

  /// No description provided for @sosTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get sosTitle;

  /// No description provided for @fieldOperatorNavSos.
  ///
  /// In en, this message translates to:
  /// **'SOS'**
  String get fieldOperatorNavSos;

  /// No description provided for @sosHomeButton.
  ///
  /// In en, this message translates to:
  /// **'I\'m lost'**
  String get sosHomeButton;

  /// No description provided for @sosHomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send your location to your team'**
  String get sosHomeSubtitle;

  /// No description provided for @sosIntro.
  ///
  /// In en, this message translates to:
  /// **'If you are lost or need urgent help, send an alert. Your group team and supervisors will be notified with your live location.'**
  String get sosIntro;

  /// No description provided for @sosRaiseButton.
  ///
  /// In en, this message translates to:
  /// **'Send SOS'**
  String get sosRaiseButton;

  /// No description provided for @sosRaiseError.
  ///
  /// In en, this message translates to:
  /// **'Could not send the alert. Try again.'**
  String get sosRaiseError;

  /// No description provided for @sosLocationPermissionNeeded.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to share your position. The alert was sent without it.'**
  String get sosLocationPermissionNeeded;

  /// No description provided for @sosActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Help is on the way'**
  String get sosActiveTitle;

  /// No description provided for @sosActiveBody.
  ///
  /// In en, this message translates to:
  /// **'Your team and supervisors have been notified. Keep this screen open to share your live location.'**
  String get sosActiveBody;

  /// No description provided for @sosSharingLocation.
  ///
  /// In en, this message translates to:
  /// **'Sharing your live location…'**
  String get sosSharingLocation;

  /// No description provided for @sosLastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last update: {time}'**
  String sosLastUpdate(String time);

  /// No description provided for @sosLocationPending.
  ///
  /// In en, this message translates to:
  /// **'Getting your location…'**
  String get sosLocationPending;

  /// No description provided for @sosCancelButton.
  ///
  /// In en, this message translates to:
  /// **'I\'m safe now'**
  String get sosCancelButton;

  /// No description provided for @sosCancelConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel the alert?'**
  String get sosCancelConfirmTitle;

  /// No description provided for @sosCancelConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This will tell your team that you are safe.'**
  String get sosCancelConfirmMessage;

  /// No description provided for @sosCancelConfirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, I\'m safe'**
  String get sosCancelConfirm;

  /// No description provided for @sosCancelError.
  ///
  /// In en, this message translates to:
  /// **'Could not cancel the alert. Try again.'**
  String get sosCancelError;

  /// No description provided for @sosMonitorTitle.
  ///
  /// In en, this message translates to:
  /// **'SOS alerts'**
  String get sosMonitorTitle;

  /// No description provided for @sosMonitorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Live location of pilgrims who asked for help.'**
  String get sosMonitorSubtitle;

  /// No description provided for @sosMonitorEmpty.
  ///
  /// In en, this message translates to:
  /// **'No active SOS alerts.'**
  String get sosMonitorEmpty;

  /// No description provided for @sosMonitorActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{count} active'**
  String sosMonitorActiveCount(int count);

  /// No description provided for @sosMonitorError.
  ///
  /// In en, this message translates to:
  /// **'Could not load SOS alerts.'**
  String get sosMonitorError;

  /// No description provided for @sosMonitorRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get sosMonitorRefresh;

  /// No description provided for @sosMonitorLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get sosMonitorLive;

  /// No description provided for @sosMonitorSelectHint.
  ///
  /// In en, this message translates to:
  /// **'Tap an alert to track it on the map.'**
  String get sosMonitorSelectHint;

  /// No description provided for @sosUnknownPilgrim.
  ///
  /// In en, this message translates to:
  /// **'Pilgrim'**
  String get sosUnknownPilgrim;

  /// No description provided for @sosNoGroup.
  ///
  /// In en, this message translates to:
  /// **'No group'**
  String get sosNoGroup;

  /// No description provided for @sosNoLocationYet.
  ///
  /// In en, this message translates to:
  /// **'Waiting for location…'**
  String get sosNoLocationYet;

  /// No description provided for @sosOpenInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in maps'**
  String get sosOpenInMaps;

  /// No description provided for @sosResolveButton.
  ///
  /// In en, this message translates to:
  /// **'Resolve'**
  String get sosResolveButton;

  /// No description provided for @sosResolveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Resolve this alert?'**
  String get sosResolveConfirmTitle;

  /// No description provided for @sosResolveConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Mark \"{name}\" as found and safe.'**
  String sosResolveConfirmMessage(String name);

  /// No description provided for @sosResolveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Resolve'**
  String get sosResolveConfirm;

  /// No description provided for @sosResolvedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Alert resolved'**
  String get sosResolvedSuccess;

  /// No description provided for @sosResolveError.
  ///
  /// In en, this message translates to:
  /// **'Could not resolve the alert.'**
  String get sosResolveError;

  /// No description provided for @sosStartedAt.
  ///
  /// In en, this message translates to:
  /// **'Since {time}'**
  String sosStartedAt(String time);

  /// No description provided for @importTitle.
  ///
  /// In en, this message translates to:
  /// **'Import pilgrims'**
  String get importTitle;

  /// No description provided for @importSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add or update pilgrims from an Excel or CSV file.'**
  String get importSubtitle;

  /// No description provided for @importPickTitle.
  ///
  /// In en, this message translates to:
  /// **'Import from Excel / CSV'**
  String get importPickTitle;

  /// No description provided for @importPickDescription.
  ///
  /// In en, this message translates to:
  /// **'Pick an .xlsx or .csv file. The first row must be the column headers. Existing pilgrims are matched by passport number and updated; the rest are created.'**
  String get importPickDescription;

  /// No description provided for @importPickFile.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get importPickFile;

  /// No description provided for @importMappingTitle.
  ///
  /// In en, this message translates to:
  /// **'Match columns'**
  String get importMappingTitle;

  /// No description provided for @importMappingDescription.
  ///
  /// In en, this message translates to:
  /// **'We matched your file columns to pilgrim fields. Review and fix any that look wrong.'**
  String get importMappingDescription;

  /// No description provided for @importColumnIgnore.
  ///
  /// In en, this message translates to:
  /// **'Ignore this column'**
  String get importColumnIgnore;

  /// No description provided for @importFileColumn.
  ///
  /// In en, this message translates to:
  /// **'File column'**
  String get importFileColumn;

  /// No description provided for @importMapsTo.
  ///
  /// In en, this message translates to:
  /// **'Maps to'**
  String get importMapsTo;

  /// No description provided for @importEmailColumnLabel.
  ///
  /// In en, this message translates to:
  /// **'Login email'**
  String get importEmailColumnLabel;

  /// No description provided for @importPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get importPreviewTitle;

  /// No description provided for @importNewCount.
  ///
  /// In en, this message translates to:
  /// **'{count} new'**
  String importNewCount(int count);

  /// No description provided for @importUpdateCount.
  ///
  /// In en, this message translates to:
  /// **'{count} to update'**
  String importUpdateCount(int count);

  /// No description provided for @importErrorCount.
  ///
  /// In en, this message translates to:
  /// **'{count} with errors'**
  String importErrorCount(int count);

  /// No description provided for @importIgnoredColumns.
  ///
  /// In en, this message translates to:
  /// **'{count} columns ignored'**
  String importIgnoredColumns(int count);

  /// No description provided for @importColRow.
  ///
  /// In en, this message translates to:
  /// **'Row'**
  String get importColRow;

  /// No description provided for @importColName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get importColName;

  /// No description provided for @importColAction.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get importColAction;

  /// No description provided for @importColIssues.
  ///
  /// In en, this message translates to:
  /// **'Issues'**
  String get importColIssues;

  /// No description provided for @importActionCreate.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get importActionCreate;

  /// No description provided for @importActionUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get importActionUpdate;

  /// No description provided for @importActionError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get importActionError;

  /// No description provided for @importConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Import {count} pilgrims'**
  String importConfirmButton(int count);

  /// No description provided for @importCommitting.
  ///
  /// In en, this message translates to:
  /// **'Importing…'**
  String get importCommitting;

  /// No description provided for @importResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Import complete'**
  String get importResultTitle;

  /// No description provided for @importResultCreated.
  ///
  /// In en, this message translates to:
  /// **'{count} created'**
  String importResultCreated(int count);

  /// No description provided for @importResultUpdated.
  ///
  /// In en, this message translates to:
  /// **'{count} updated'**
  String importResultUpdated(int count);

  /// No description provided for @importResultFailed.
  ///
  /// In en, this message translates to:
  /// **'{count} failed'**
  String importResultFailed(int count);

  /// No description provided for @importResultErrorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Errors'**
  String get importResultErrorsTitle;

  /// No description provided for @importAnother.
  ///
  /// In en, this message translates to:
  /// **'Import another file'**
  String get importAnother;

  /// No description provided for @importChangeFile.
  ///
  /// In en, this message translates to:
  /// **'Choose a different file'**
  String get importChangeFile;

  /// No description provided for @importNoRows.
  ///
  /// In en, this message translates to:
  /// **'No data rows were found in the file.'**
  String get importNoRows;

  /// No description provided for @importNothingToImport.
  ///
  /// In en, this message translates to:
  /// **'There are no valid rows to import.'**
  String get importNothingToImport;

  /// No description provided for @importGenericError.
  ///
  /// In en, this message translates to:
  /// **'Could not read the file. Make sure it is a valid Excel or CSV file.'**
  String get importGenericError;

  /// No description provided for @importIssueMissingName.
  ///
  /// In en, this message translates to:
  /// **'Arabic full name is required'**
  String get importIssueMissingName;

  /// No description provided for @importIssueInvalidDate.
  ///
  /// In en, this message translates to:
  /// **'Invalid date'**
  String get importIssueInvalidDate;

  /// No description provided for @importIssueInvalidGender.
  ///
  /// In en, this message translates to:
  /// **'Unrecognized gender'**
  String get importIssueInvalidGender;

  /// No description provided for @importIssueInvalidBoolean.
  ///
  /// In en, this message translates to:
  /// **'Unrecognized yes/no value'**
  String get importIssueInvalidBoolean;

  /// No description provided for @importIssueDuplicatePassport.
  ///
  /// In en, this message translates to:
  /// **'Duplicate passport in file'**
  String get importIssueDuplicatePassport;

  /// No description provided for @exportButton.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportButton;

  /// No description provided for @exportTemplateButton.
  ///
  /// In en, this message translates to:
  /// **'Template'**
  String get exportTemplateButton;

  /// No description provided for @exportEmpty.
  ///
  /// In en, this message translates to:
  /// **'There are no pilgrims to export.'**
  String get exportEmpty;

  /// No description provided for @exportDownloadStarted.
  ///
  /// In en, this message translates to:
  /// **'Export ready — check your downloads.'**
  String get exportDownloadStarted;

  /// No description provided for @exportSavedTo.
  ///
  /// In en, this message translates to:
  /// **'Saved to {path}'**
  String exportSavedTo(String path);

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed. Please try again.'**
  String get exportFailed;

  /// No description provided for @bulkEditAction.
  ///
  /// In en, this message translates to:
  /// **'Bulk edit'**
  String get bulkEditAction;

  /// No description provided for @bulkEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Bulk edit {count} pilgrims'**
  String bulkEditTitle(int count);

  /// No description provided for @bulkEditDescription.
  ///
  /// In en, this message translates to:
  /// **'Only the fields you enable will change. Fields left off keep each pilgrim\'s current value.'**
  String get bulkEditDescription;

  /// No description provided for @bulkEditEnableField.
  ///
  /// In en, this message translates to:
  /// **'Update this field'**
  String get bulkEditEnableField;

  /// No description provided for @bulkEditNotify.
  ///
  /// In en, this message translates to:
  /// **'Notify pilgrims of changes'**
  String get bulkEditNotify;

  /// No description provided for @bulkEditNotifyHint.
  ///
  /// In en, this message translates to:
  /// **'Pilgrims with the app get a notification when their hotel, flight, or other logistics change.'**
  String get bulkEditNotifyHint;

  /// No description provided for @bulkEditApply.
  ///
  /// In en, this message translates to:
  /// **'Apply to {count} pilgrims'**
  String bulkEditApply(int count);

  /// No description provided for @bulkEditNoFields.
  ///
  /// In en, this message translates to:
  /// **'Enable at least one field to update.'**
  String get bulkEditNoFields;

  /// No description provided for @bulkEditSuccess.
  ///
  /// In en, this message translates to:
  /// **'Updated {count} pilgrims'**
  String bulkEditSuccess(int count);

  /// No description provided for @bulkEditError.
  ///
  /// In en, this message translates to:
  /// **'Could not apply the changes. Please try again.'**
  String get bulkEditError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
