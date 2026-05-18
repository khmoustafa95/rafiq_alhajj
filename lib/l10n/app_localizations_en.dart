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
}
