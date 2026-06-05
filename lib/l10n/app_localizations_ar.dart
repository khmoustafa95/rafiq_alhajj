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

  @override
  String get homeSignInAsPilgrim => 'تسجيل دخول كحاج';

  @override
  String get homePilgrimWelcome =>
      'تم تسجيل دخولك. تصفّح المحتوى العام والحصري أدناه.';

  @override
  String get contentVideosSection => 'فيديوهات توعوية';

  @override
  String get contentNewsSection => 'أخبار وإعلانات';

  @override
  String get contentVideosEmpty => 'لا توجد فيديوهات عامة حالياً.';

  @override
  String get contentNewsEmpty => 'لا توجد أخبار أو إعلانات حالياً.';

  @override
  String get contentLoadError => 'تعذر تحميل المحتوى. اسحب للتحديث.';

  @override
  String get contentSupabaseRequired =>
      'فعّل Supabase لتحميل الفيديوهات والأخبار من الخادم.';

  @override
  String get contentDetailTitle => 'المحتوى';

  @override
  String get contentNotFound => 'هذا المحتوى لم يعد متاحاً.';

  @override
  String get contentOpenMedia => 'فتح الفيديو أو الرابط';

  @override
  String get contentOpenMediaFailed => 'تعذر فتح الرابط.';

  @override
  String homePilgrimGreeting(String name) {
    return 'مرحباً، $name';
  }

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get loginTitle => 'دخول الحاج';

  @override
  String get loginSubtitle => 'استخدم بيانات الحساب التي زوّدك بها المركز';

  @override
  String get loginEmailLabel => 'البريد الإلكتروني للحساب';

  @override
  String get loginPasswordLabel => 'كلمة المرور';

  @override
  String get loginEmailRequired => 'أدخل البريد الإلكتروني للحساب';

  @override
  String get loginEmailInvalid => 'أدخل بريداً إلكترونياً صالحاً';

  @override
  String get loginPasswordRequired => 'أدخل كلمة المرور';

  @override
  String get loginSubmit => 'تسجيل الدخول';

  @override
  String get authErrorInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get authErrorEmailNotConfirmed =>
      'يرجى تأكيد البريد الإلكتروني قبل تسجيل الدخول';

  @override
  String get authErrorNotPilgrimRole =>
      'هذا الحساب ليس حساب حاج. استخدم لوحة الويب.';

  @override
  String get authErrorProfileNotFound => 'لم يُعثر على ملفك. تواصل مع المركز.';

  @override
  String get authErrorSupabaseUnavailable =>
      'تسجيل الدخول يتطلب Supabase. شغّل التطبيق بإعدادات التطوير المحلية.';

  @override
  String get authErrorNetworkConnection =>
      'تعذّر الاتصال بـ Supabase. تأكد أن Supabase يعمل محلياً وجرب بدون VPN.';

  @override
  String get authErrorUnknown => 'فشل تسجيل الدخول. حاول مرة أخرى.';

  @override
  String get homeIslamicTools => 'الأدوات الإسلامية';

  @override
  String get toolsHubTitle => 'الأدوات الإسلامية';

  @override
  String get toolsPrayerTimesTitle => 'مواقيت الصلاة';

  @override
  String get toolsPrayerTimesSubtitle =>
      'حسب موقعك — تعمل دون إنترنت بعد أول تحميل';

  @override
  String get toolsQiblaTitle => 'القبلة';

  @override
  String get toolsQiblaSubtitle => 'اتجاه الكعبة عبر البوصلة';

  @override
  String get toolsQuranTitle => 'القرآن الكريم';

  @override
  String get toolsQuranSubtitle => 'المصحف كاملاً دون اتصال';

  @override
  String get toolsAdhkarTitle => 'الأذكار';

  @override
  String get toolsAdhkarSubtitle => 'أذكار الصباح والمساء';

  @override
  String get toolsRefreshLocation => 'تحديث الموقع';

  @override
  String get toolsUsingCachedLocation =>
      'يُستخدم آخر موقع معروف (دون إنترنت). اضغط التحديث لـ GPS.';

  @override
  String toolsCoordinates(String lat, String lng) {
    return 'الموقع: $lat، $lng';
  }

  @override
  String get prayerFajr => 'الفجر';

  @override
  String get prayerSunrise => 'الشروق';

  @override
  String get prayerDhuhr => 'الظهر';

  @override
  String get prayerAsr => 'العصر';

  @override
  String get prayerMaghrib => 'المغرب';

  @override
  String get prayerIsha => 'العشاء';

  @override
  String toolsQiblaBearing(String degrees) {
    return 'زاوية القبلة: $degrees°';
  }

  @override
  String toolsCompassHeading(String degrees) {
    return 'اتجاه الجهاز: $degrees°';
  }

  @override
  String get toolsQiblaHint => 'أدر الجهاز حتى يشير السهم للأعلى نحو القبلة.';

  @override
  String get toolsQiblaCompassUnavailable =>
      'مستشعر البوصلة غير متاح على هذا الجهاز.';

  @override
  String get toolsQuranAyahs => 'آية';

  @override
  String toolsQuranSurahMeta(int count) {
    return '$count آية';
  }

  @override
  String get toolsQuranOfflineNote => 'النص محمّل محلياً — لا حاجة للإنترنت.';

  @override
  String get toolsAdhkarMorning => 'الصباح';

  @override
  String get toolsAdhkarEvening => 'المساء';

  @override
  String get toolsAdhkarRepeat => 'التكرار';

  @override
  String get locationErrorServiceDisabled =>
      'فعّل خدمات الموقع لحساب المواقيت والقبلة.';

  @override
  String get locationErrorPermissionDenied =>
      'صلاحية الموقع مطلوبة لمواقيت الصلاة والقبلة.';

  @override
  String get locationErrorPermissionDeniedForever =>
      'فعّل صلاحية الموقع من إعدادات النظام.';

  @override
  String get locationErrorUnavailable => 'تعذر تحديد موقعك.';

  @override
  String get homeMyHajjJourney => 'رحلة حجّي';

  @override
  String get pilgrimDashboardTitle => 'رحلة حجّي';

  @override
  String pilgrimRitualsProgress(int completed, int total) {
    return 'أُكمِل $completed من $total مناسك';
  }

  @override
  String get pilgrimRitualPendingSync => 'بانتظار المزامنة عند الاتصال';

  @override
  String pilgrimRitualCompletedAt(String date) {
    return 'اكتمل في $date';
  }

  @override
  String get pilgrimSyncPending =>
      'بعض تحديثات المناسك ستُزامَن عند عودة الاتصال.';

  @override
  String get pilgrimLogisticsTitle => 'السفر والإقامة';

  @override
  String get pilgrimLogisticsEmpty => 'لم ينشر المركز تفاصيلك اللوجستية بعد.';

  @override
  String get pilgrimMedicalStatus => 'الفحص الطبي';

  @override
  String get pilgrimTravelDate => 'تاريخ السفر';

  @override
  String get pilgrimHotel => 'الفندق';

  @override
  String get pilgrimOpenHotelMap => 'فتح موقع الفندق';

  @override
  String get pilgrimTransport => 'المواصلات';

  @override
  String get pilgrimSignInRequired =>
      'سجّل دخولك كحاج لتتبع المناسك وعرض ملفك.';

  @override
  String get pilgrimLoadError => 'تعذر تحميل لوحة الحاج. اسحب للتحديث.';

  @override
  String get authErrorNotStaffRole => 'هذا الحساب غير مصرّح له بلوحة التقني.';

  @override
  String get authErrorNotAdminRole => 'هذا الحساب غير مصرّح له بلوحة المسؤول.';

  @override
  String get operatorLoginTitle => 'دخول التقني';

  @override
  String get operatorLoginSubtitle => 'تقني المركز — تسجيل الحجاج (US-05)';

  @override
  String get operatorIntakeTitle => 'تسجيل حاج';

  @override
  String get operatorIntakeSubtitle =>
      'أدخل بيانات الحاج، ارفع الثبوتيات، وأنشئ حساب الموبايل.';

  @override
  String get operatorGenerateCredentials => 'توليد بريد وكلمة مرور';

  @override
  String operatorGeneratedPasswordPreview(String password) {
    return 'معاينة كلمة المرور (تُثبت عند الإرسال): $password';
  }

  @override
  String get operatorDocumentsSection => 'الثبوتيات والمستندات';

  @override
  String operatorPickDocuments(int count) {
    return 'اختيار ملفات ($count)';
  }

  @override
  String get operatorFullName => 'الاسم الكامل';

  @override
  String get operatorRequired => 'حقل مطلوب';

  @override
  String get operatorPassport => 'رقم الجواز';

  @override
  String get operatorTravelPermit => 'إذن السفر';

  @override
  String get operatorHotelMapUrl => 'رابط موقع الفندق';

  @override
  String get operatorPickDate => 'اختر التاريخ';

  @override
  String get operatorSubmitPilgrim => 'إنشاء حساب الحاج';

  @override
  String get operatorAccountCreatedTitle => 'تم إنشاء حساب الحاج';

  @override
  String get operatorCloseDialog => 'إغلاق';

  @override
  String get homeFieldOperatorSignIn => 'دخول التقني الميداني';

  @override
  String get fieldOperatorLoginTitle => 'التقني الميداني';

  @override
  String get fieldOperatorLoginSubtitle =>
      'البحث عن الحجاج وتحديث حالاتهم في المشاعر (US-06)';

  @override
  String get fieldOperatorHomeTitle => 'الحجاج في الميدان';

  @override
  String get fieldOperatorSearchHint =>
      'ابحث بالاسم أو رقم الجواز أو إذن السفر';

  @override
  String get fieldOperatorLoadError => 'تعذر تحميل قائمة الحجاج. اسحب للتحديث.';

  @override
  String get fieldOperatorNoResults => 'لا يوجد حجاج مطابقون للبحث.';

  @override
  String get fieldOperatorPilgrimTitle => 'تحديث حالة الحاج';

  @override
  String get fieldOperatorStatusSection => 'الحالة الميدانية';

  @override
  String get fieldOperatorMedicalLabel => 'حالة الفحص الطبي';

  @override
  String get fieldOperatorHotelLabel => 'الفندق';

  @override
  String get fieldOperatorTransportLabel => 'المواصلات';

  @override
  String get fieldOperatorSave => 'حفظ التحديثات';

  @override
  String get fieldOperatorSaveSuccess => 'تم تحديث سجل الحاج.';

  @override
  String get fieldOperatorSaveError => 'تعذر حفظ التغييرات.';

  @override
  String get fieldOperatorShare => 'نسخ ملخص للمشاركة';

  @override
  String get fieldOperatorCopied => 'تم نسخ الملخص.';

  @override
  String get fieldOperatorNotFound => 'لم يُعثر على الحاج.';

  @override
  String fieldOperatorShareSummary(
    String name,
    String status,
    String medical,
    String hotel,
  ) {
    return '$name\nالحالة: $status\nالفحص: $medical\nالفندق: $hotel';
  }

  @override
  String get fieldStatusNotSet => 'غير محدد';

  @override
  String get fieldStatusPending => 'قيد الانتظار';

  @override
  String get fieldStatusMedicalDone => 'تم الفحص الطبي';

  @override
  String get fieldStatusArrivedHotel => 'وصل الفندق';

  @override
  String get fieldStatusInTransit => 'في الطريق';

  @override
  String get fieldStatusCompleted => 'مكتمل';

  @override
  String get operatorGoAdminLogin => 'دخول المسؤول — التقارير';

  @override
  String get adminLoginTitle => 'دخول المسؤول';

  @override
  String get adminLoginSubtitle => 'تقارير وإحصائيات التكتل (US-07)';

  @override
  String get adminDashboardTitle => 'لوحة التقارير';

  @override
  String get adminDashboardSubtitle =>
      'مؤشرات لحظية من Supabase — الحجاج والمجموعات والحالة الميدانية.';

  @override
  String get adminDashboardLoadError => 'تعذر تحميل مؤشرات اللوحة.';

  @override
  String get adminStatPilgrims => 'الحجاج';

  @override
  String get adminStatOperators => 'التقنيون الميدانيون';

  @override
  String get adminStatRitualProgress => 'إنجاز المناسك';

  @override
  String get adminChartPilgrimsByGroup => 'توزيع الحجاج على المجموعات';

  @override
  String get adminChartFieldStatus => 'توزيع الحالة الميدانية';

  @override
  String get adminChartOperatorUploads => 'المستندات المرفوعة لكل تقني';

  @override
  String get adminChartEmpty => 'لا توجد بيانات بعد.';

  @override
  String get adminUnassignedGroup => 'بدون مجموعة';

  @override
  String get adminUnknownOperator => 'تقني غير معروف';

  @override
  String get adminManageContent => 'إدارة مكتبة المحتوى';

  @override
  String get adminContentListTitle => 'مكتبة المحتوى';

  @override
  String get adminContentAdd => 'إضافة محتوى';

  @override
  String get adminContentEdit => 'تعديل';

  @override
  String get adminContentNewTitle => 'محتوى جديد';

  @override
  String get adminContentEditTitle => 'تعديل المحتوى';

  @override
  String get adminContentLoadError => 'تعذر تحميل المحتوى.';

  @override
  String get adminContentEmpty => 'لا يوجد محتوى بعد. أضف أول عنصر.';

  @override
  String get adminContentNotFound => 'لم يُعثر على العنصر.';

  @override
  String get adminContentTitleLabel => 'العنوان';

  @override
  String get adminContentTitleRequired => 'أدخل العنوان';

  @override
  String get adminContentDescriptionLabel => 'الوصف';

  @override
  String get adminContentMediaUrlLabel => 'رابط الوسائط (اختياري)';

  @override
  String get adminContentTypeLabel => 'النوع';

  @override
  String get adminContentVisibilityLabel => 'الظهور';

  @override
  String get adminContentTypeVideo => 'فيديو';

  @override
  String get adminContentTypeNews => 'خبر';

  @override
  String get adminContentTypeAnnouncement => 'إعلان';

  @override
  String get adminContentVisibilityPublic => 'عام (للجميع)';

  @override
  String get adminContentVisibilityPilgrimOnly => 'للحجاج فقط';

  @override
  String get adminContentSave => 'حفظ';

  @override
  String get adminContentSaveSuccess => 'تم تحديث المحتوى.';

  @override
  String get adminContentCreateSuccess => 'تم نشر المحتوى.';

  @override
  String get adminContentSaveError => 'تعذر حفظ المحتوى.';

  @override
  String get adminContentDeleteTitle => 'حذف المحتوى؟';

  @override
  String adminContentDeleteMessage(String title) {
    return 'حذف \"$title\"؟ لا يمكن التراجع.';
  }

  @override
  String get adminContentDeleteConfirm => 'حذف';

  @override
  String get adminContentDeleteSuccess => 'تم حذف المحتوى.';

  @override
  String get adminContentDeleteError => 'تعذر حذف المحتوى.';

  @override
  String get dialogCancel => 'إلغاء';

  @override
  String get operatorPilgrimListTitle => 'الحجاج المسجّلون';

  @override
  String get operatorPilgrimSearchHint =>
      'ابحث بالاسم أو رقم الجواز أو إذن السفر';

  @override
  String get operatorPilgrimListLoadError => 'تعذر تحميل قائمة الحجاج.';

  @override
  String get operatorPilgrimListEmpty => 'لا يوجد حجاج مسجّلون بعد.';

  @override
  String get operatorPilgrimNoLogisticsYet => 'لا توجد بيانات لوجستية';

  @override
  String get operatorPilgrimDetailTitle => 'سجل الحاج';

  @override
  String get operatorPilgrimDetailSubtitle =>
      'تحديث بيانات السفر والإقامة (مكتب التسجيل).';

  @override
  String get operatorPilgrimNotFound => 'لم يُعثر على الحاج.';

  @override
  String get operatorPilgrimTravelDateUnset => 'غير محدد';

  @override
  String get operatorPilgrimSave => 'حفظ التغييرات';

  @override
  String get operatorPilgrimSaveSuccess => 'تم تحديث سجل الحاج.';

  @override
  String get operatorPilgrimSaveError => 'تعذر حفظ التغييرات.';

  @override
  String get homeCompetitions => 'المسابقات';

  @override
  String get competitionsTitle => 'المسابقات';

  @override
  String get competitionsLoadError => 'تعذر تحميل المسابقات.';

  @override
  String get competitionsEmpty => 'لا توجد مسابقات نشطة حالياً.';

  @override
  String get competitionsNoDescription => 'بدون وصف';

  @override
  String get competitionDetailTitle => 'المسابقة';

  @override
  String get competitionNotFound => 'لم تُعثر على المسابقة.';

  @override
  String get competitionSignInRequired =>
      'سجّل الدخول كحاج للمشاركة وكسب النقاط.';

  @override
  String get competitionClosed => 'هذه المسابقة غير مفتوحة للمشاركة.';

  @override
  String get competitionJoin => 'انضم للمسابقة';

  @override
  String get competitionJoinSuccess => 'تم انضمامك للمسابقة.';

  @override
  String get competitionJoinError =>
      'تعذر الانضمام. سجّل كحاج أو أعد المحاولة.';

  @override
  String competitionYourScore(int score) {
    return 'نقاطك: $score';
  }

  @override
  String get competitionRecordProgress => 'تسجيل تقدم (+10)';

  @override
  String get competitionProgressRecorded => 'تم تسجيل التقدم.';

  @override
  String get competitionProgressError => 'تعذر تحديث النقاط.';

  @override
  String get competitionLeaderboard => 'لوحة المتصدرين';

  @override
  String get competitionLeaderboardEmpty => 'لا يوجد مشاركون بعد.';

  @override
  String get competitionAnonymous => 'حاج';

  @override
  String competitionPoints(int score) {
    return '$score نقطة';
  }

  @override
  String get adminManageCompetitions => 'إدارة المسابقات';

  @override
  String get adminCompetitionsTitle => 'المسابقات';

  @override
  String get adminCompetitionAdd => 'إضافة مسابقة';

  @override
  String get adminCompetitionsLoadError => 'تعذر تحميل المسابقات.';

  @override
  String get adminCompetitionsEmpty => 'لا توجد مسابقات بعد.';

  @override
  String get adminCompetitionNewTitle => 'مسابقة جديدة';

  @override
  String get adminCompetitionEditTitle => 'تعديل المسابقة';

  @override
  String get adminCompetitionStartsAt => 'تبدأ';

  @override
  String get adminCompetitionEndsAt => 'تنتهي';

  @override
  String get adminCompetitionActiveLabel => 'نشطة';

  @override
  String get adminCompetitionInactive => 'غير نشطة';

  @override
  String get adminCompetitionActive => 'منشورة';

  @override
  String get adminCompetitionSaveSuccess => 'تم حفظ المسابقة.';

  @override
  String get adminCompetitionSaveError => 'تعذر حفظ المسابقة.';

  @override
  String get adminCompetitionDeleteTitle => 'حذف المسابقة؟';

  @override
  String adminCompetitionDeleteMessage(String title) {
    return 'حذف \"$title\"؟';
  }

  @override
  String get adminCompetitionDeleteConfirm => 'حذف';

  @override
  String get adminCompetitionDeleteSuccess => 'تم حذف المسابقة.';

  @override
  String get adminCompetitionDeleteError => 'تعذر حذف المسابقة.';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get notificationsOpenInbox => 'الإشعارات';

  @override
  String get notificationsEmpty => 'لا توجد إشعارات بعد.';

  @override
  String get notificationsLoadError => 'تعذر تحميل الإشعارات.';

  @override
  String get notificationsMarkAllRead => 'تعليم الكل كمقروء';

  @override
  String get adminSendNotification => 'إرسال إشعار';

  @override
  String get adminNotificationSendTitle => 'بث إشعار';

  @override
  String get adminNotificationAudienceLabel => 'الجمهور';

  @override
  String get adminNotificationAudienceAllPilgrims => 'كل الحجاج';

  @override
  String get adminNotificationAudienceGroup => 'مجموعة';

  @override
  String get adminNotificationAudienceOperators => 'كل المشغّلين';

  @override
  String get adminNotificationGroupLabel => 'المجموعة';

  @override
  String get adminNotificationGroupRequired => 'اختر مجموعة.';

  @override
  String get adminNotificationGroupsLoadError => 'تعذر تحميل المجموعات.';

  @override
  String get adminNotificationGroupsEmpty => 'لا توجد مجموعات بعد.';

  @override
  String get adminNotificationTitleAr => 'العنوان (عربي)';

  @override
  String get adminNotificationTitleEn => 'العنوان (إنجليزي)';

  @override
  String get adminNotificationTitleRequired => 'العنوان مطلوب.';

  @override
  String get adminNotificationBodyAr => 'النص (عربي، اختياري)';

  @override
  String get adminNotificationBodyEn => 'النص (إنجليزي، اختياري)';

  @override
  String get adminNotificationSendButton => 'إرسال';

  @override
  String adminNotificationSendSuccess(int count) {
    return 'تم الإرسال إلى $count مستلم.';
  }

  @override
  String get adminNotificationSendError => 'تعذر إرسال الإشعار.';
}
