// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'رفيق الحج';

  @override
  String get homeTitle => 'الرئيسية';

  @override
  String get homeWelcome => 'مرحباً بك في رفيق الحج';

  @override
  String get routeNotFoundTitle => 'الصفحة غير موجودة';

  @override
  String get routeNotFoundMessage => 'تعذر العثور على الصفحة المطلوبة.';

  @override
  String get goHome => 'العودة للرئيسية';

  @override
  String get bootstrapErrorTitle => 'تعذر تشغيل التطبيق';

  @override
  String get bootstrapErrorMessage =>
      'حدث خطأ أثناء بدء تشغيل رفيق الحج. يرجى المحاولة مرة أخرى.';

  @override
  String get retry => 'إعادة المحاولة';
}
