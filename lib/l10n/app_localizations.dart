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

  /// Supabase not configured or unreachable
  ///
  /// In en, this message translates to:
  /// **'Sign-in requires Supabase. Run with local dart-defines or contact support.'**
  String get authErrorSupabaseUnavailable;

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
  /// **'Center technician — pilgrim registration (US-05)'**
  String get operatorLoginSubtitle;

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
  /// **'Search pilgrims and update logistics in the field (US-06)'**
  String get fieldOperatorLoginSubtitle;

  /// No description provided for @fieldOperatorHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Pilgrims in the field'**
  String get fieldOperatorHomeTitle;

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
  /// **'Consortium analytics and reporting (US-07)'**
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

  /// No description provided for @competitionRecordProgress.
  ///
  /// In en, this message translates to:
  /// **'Record progress (+10)'**
  String get competitionRecordProgress;

  /// No description provided for @competitionProgressRecorded.
  ///
  /// In en, this message translates to:
  /// **'Progress recorded.'**
  String get competitionProgressRecorded;

  /// No description provided for @competitionProgressError.
  ///
  /// In en, this message translates to:
  /// **'Could not update score.'**
  String get competitionProgressError;

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
