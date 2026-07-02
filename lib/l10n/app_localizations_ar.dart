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
  String get contentTopicsSection => 'مواضيع تعليمية';

  @override
  String get contentNewsSection => 'أخبار وإعلانات';

  @override
  String get contentNewsSectionTitle => 'الأخبار';

  @override
  String get contentAnnouncementsSection => 'الإعلانات';

  @override
  String get contentAnnouncementsEmpty => 'لا توجد إعلانات بعد.';

  @override
  String get contentLibrarySection => 'المكتبة التعليمية';

  @override
  String get contentMediaPdf => 'ملف PDF';

  @override
  String get educationalMediaPdfError => 'تعذّر فتح ملف PDF.';

  @override
  String get contentVideosEmpty => 'لا توجد فيديوهات عامة حالياً.';

  @override
  String get contentTopicsEmpty => 'لا توجد مواضيع تعليمية حالياً.';

  @override
  String get contentTopicNotFound => 'لم يُعثر على هذا الموضوع.';

  @override
  String get contentTopicMediaTitle => 'سلسلة الوسائط';

  @override
  String get contentTopicNoMedia => 'لا توجد وسائط بعد.';

  @override
  String contentTopicVideoCount(int count) {
    return '$count فيديو';
  }

  @override
  String contentTopicAudioCount(int count) {
    return '$count صوت';
  }

  @override
  String contentTopicImageCount(int count) {
    return '$count صورة';
  }

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
  String get toolsVirtualTourTitle => 'دليل الحرم';

  @override
  String get toolsVirtualTourSubtitle =>
      'خريطة حقيقية، دليل المناسك، وبانوراما لمكة';

  @override
  String get toolsVirtualTourLoadError => 'تعذر تحميل البانوراما.';

  @override
  String get toolsVirtualTourTabGuide => 'الدليل';

  @override
  String get toolsVirtualTourTabMap => 'الخريطة';

  @override
  String get toolsVirtualTourTabPanorama => 'بانوراما';

  @override
  String get toolsVirtualTourDisclaimer =>
      'للتعريف والإرشاد فقط — ليس بديلاً عن أداء الحج في المشاعر.';

  @override
  String get toolsVirtualTourGuideHeading => 'معالم الحرم ومناسكها';

  @override
  String get toolsVirtualTourStepsLabel => 'الخطوات';

  @override
  String get toolsVirtualTourTipsLabel => 'نصائح عملية';

  @override
  String get toolsVirtualTourRitualLabel => 'المنسك';

  @override
  String get toolsVirtualTourMapHint =>
      'خريطة OpenStreetMap — اضغط أيقونة معلم لعرض التفاصيل. تتطلب اتصالاً للتحميل الأول.';

  @override
  String get toolsVirtualTourCenterKaaba => 'توسيط الكعبة';

  @override
  String get toolsVirtualTourPanoramaHint =>
      'بانوراما جوية لمكة من برج الساعة — اسحب وقرّب للاستكشاف.';

  @override
  String get toolsVirtualTourPanoramaGestures =>
      'اسحب بإصبعك أو قرّب بالقرص للتكبير';

  @override
  String get toolsVirtualTourPanoramaCredit =>
      'صورة بانوراما: Wurzelgnohm / Wikimedia Commons (CC0)';

  @override
  String get toolsVirtualTourPhotoCredit =>
      'صورة الكعبة: GusJuned / Wikimedia Commons';

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
  String get operatorLoginSubtitle =>
      'تقني المركز — تسجيل الحجاج ورفع المستندات';

  @override
  String get staffLoginHighlightRegistration => 'تسجيل الحجاج ورفع المستندات';

  @override
  String get staffLoginHighlightDocuments => 'تخزين آمن للمستندات لكل حاج';

  @override
  String get staffLoginHighlightRegistry => 'إدارة سجل الحجاج لحظياً';

  @override
  String get staffLoginHighlightAnalytics =>
      'لوحات وتقارير وحالة ميدانية مباشرة';

  @override
  String get staffLoginHighlightContent => 'نشر الفيديوهات والأخبار والإعلانات';

  @override
  String get staffLoginHighlightNotifications => 'بث التنبيهات للحجاج والطاقم';

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
  String get operatorDocumentsUploadFailed =>
      'تم إنشاء الحساب، لكن تعذّر رفع بعض المستندات. يمكنك إعادة رفعها لاحقاً.';

  @override
  String get operatorSharedDefaultsTitle => 'بيانات مشتركة';

  @override
  String get operatorSharedDefaultsHint =>
      'الحقول المشتركة (الفندق، الرحلة، التواريخ، المشاعر…) تُحفظ تلقائياً وتُعبّأ في الحاج التالي لتسريع الإدخال.';

  @override
  String get operatorClearSharedDefaults => 'مسح البيانات المشتركة';

  @override
  String get operatorSendCredentialsWhatsapp =>
      'إرسال بيانات الدخول عبر واتساب';

  @override
  String get operatorResetSendConfirmTitle => 'إرسال بيانات الدخول';

  @override
  String operatorResetSendConfirmBody(String name) {
    return 'سيتم إنشاء كلمة مرور جديدة لـ $name وإرسالها عبر واتساب. هل تريد المتابعة؟';
  }

  @override
  String get operatorResetSendConfirm => 'إعادة التعيين والإرسال';

  @override
  String get operatorResetFailed => 'تعذّر إعادة تعيين كلمة المرور.';

  @override
  String get operatorWhatsappOpenFailed => 'تعذّر فتح واتساب.';

  @override
  String get operatorWhatsappNoNumber => 'لا يوجد رقم واتساب مسجّل.';

  @override
  String operatorCredentialsWhatsappMessage(String email, String password) {
    return 'مرحباً، بيانات الدخول لتطبيق رفيق الحاج:\nالبريد الإلكتروني: $email\nكلمة المرور: $password';
  }

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
      'البحث عن الحجاج وتحديث حالاتهم في المشاعر';

  @override
  String get fieldOperatorHomeTitle => 'الحجاج في الميدان';

  @override
  String get fieldOperatorDashboardTitle => 'لوحة الميدان';

  @override
  String get fieldOperatorPilgrimsTitle => 'الحجاج';

  @override
  String get fieldOperatorNavHome => 'الرئيسية';

  @override
  String get fieldOperatorNavPilgrims => 'الحجاج';

  @override
  String get fieldOperatorStatsHint =>
      'اضغط على البطاقة لفتح قائمة الحجاج المفلترة.';

  @override
  String fieldOperatorWelcome(String name) {
    return 'مرحباً، $name';
  }

  @override
  String fieldOperatorWelcomeSubtitle(int total) {
    return '$total حاج مسجل في مجموعاتك.';
  }

  @override
  String get fieldOperatorProgressTitle => 'نظرة على الإنجاز';

  @override
  String fieldOperatorProgressSummary(
    int completed,
    int inProgress,
    int total,
  ) {
    return '$completed مكتمل · $inProgress قيد المتابعة · $total الإجمالي';
  }

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
  String get fieldOperatorStatsTitle => 'نظرة عامة على الميدان';

  @override
  String get fieldOperatorStatsTotal => 'إجمالي الحجاج';

  @override
  String get fieldOperatorStatsWheelchair => 'كرسي عجزة';

  @override
  String get fieldOperatorFilterAll => 'الكل';

  @override
  String get fieldOperatorSearchHintExtended =>
      'ابحث بالاسم أو الجواز أو التأشيرة أو اللصاقة أو الهاتف';

  @override
  String get pilgrimProfileTitle => 'ملف التسجيل';

  @override
  String get pilgrimProfileEmpty => 'بيانات التسجيل غير متوفرة بعد.';

  @override
  String get pilgrimYes => 'نعم';

  @override
  String get pilgrimNo => 'لا';

  @override
  String get pilgrimNotProvided => 'غير متوفر';

  @override
  String get pilgrimSectionIdentity => 'بيانات التعريف والتسجيل';

  @override
  String get pilgrimSectionTravelDocs => 'وثائق السفر';

  @override
  String get pilgrimSectionPersonal => 'معلومات شخصية';

  @override
  String get pilgrimSectionHousing => 'الطلب والسكن';

  @override
  String get pilgrimSectionHealth => 'الحالة الصحية';

  @override
  String get pilgrimSectionMakkah => 'سكن مكة';

  @override
  String get pilgrimSectionMadinah => 'سكن المدينة';

  @override
  String get pilgrimSectionDepartureFlight => 'رحلة الذهاب';

  @override
  String get pilgrimSectionReturnFlight => 'رحلة العودة';

  @override
  String get pilgrimSectionHolySites => 'المشاعر المقدسة (منى وعرفات)';

  @override
  String get pilgrimSectionContact => 'التواصل';

  @override
  String get pilgrimSectionNotes => 'ملاحظات';

  @override
  String get pilgrimLabelSequence => 'التسلسل';

  @override
  String get pilgrimLabelCluster => 'التكتل';

  @override
  String get pilgrimLabelCoordinator => 'المنسق';

  @override
  String get pilgrimLabelSticker => 'رقم اللصاقة';

  @override
  String get pilgrimLabelVisa => 'رقم التأشيرة';

  @override
  String get pilgrimLabelBarcode => 'رقم الباركود';

  @override
  String get pilgrimLabelFullNameAr => 'الاسم الثلاثي';

  @override
  String get pilgrimLabelMotherAr => 'اسم الأم';

  @override
  String get pilgrimLabelBirthDate => 'تاريخ الميلاد';

  @override
  String get pilgrimLabelFirstNameEn => 'الاسم (إنجليزي)';

  @override
  String get pilgrimLabelLastNameEn => 'الكنية (إنجليزي)';

  @override
  String get pilgrimLabelFatherEn => 'اسم الأب (إنجليزي)';

  @override
  String get pilgrimLabelMotherEn => 'اسم الأم (إنجليزي)';

  @override
  String get pilgrimLabelPassportIssue => 'تاريخ إصدار الجواز';

  @override
  String get pilgrimLabelPassportExpiry => 'تاريخ انتهاء الجواز';

  @override
  String get pilgrimLabelGender => 'الجنس';

  @override
  String get pilgrimLabelBodySize => 'قياس البدن';

  @override
  String get pilgrimLabelGroup => 'المجموعة';

  @override
  String get pilgrimLabelCompanion => 'المرافق';

  @override
  String get pilgrimLabelRelation => 'صلة القرابة';

  @override
  String get pilgrimLabelRequestType => 'نوع الطلب';

  @override
  String get pilgrimLabelHousingType => 'نوع السكن';

  @override
  String get pilgrimLabelHadyStatus => 'حالة الهدي';

  @override
  String get pilgrimLabelResidence => 'مكان الإقامة';

  @override
  String get pilgrimLabelHealthStatus => 'الحالة الصحية';

  @override
  String get pilgrimLabelWheelchair => 'كرسي عجزة';

  @override
  String get pilgrimLabelSmoking => 'التدخين';

  @override
  String get pilgrimLabelHealthCard => 'البطاقة الصحية';

  @override
  String get pilgrimLabelVaccinated => 'التطعيم';

  @override
  String get pilgrimLabelMakkahHotel => 'فندق مكة';

  @override
  String get pilgrimLabelMakkahFloor => 'طابق مكة';

  @override
  String get pilgrimLabelMakkahRoom => 'غرفة مكة';

  @override
  String get pilgrimLabelMadinahTravel => 'تاريخ السفر للمدينة';

  @override
  String get pilgrimLabelMadinahHotel => 'فندق المدينة';

  @override
  String get pilgrimLabelMadinahFloor => 'طابق المدينة';

  @override
  String get pilgrimLabelMadinahRoom => 'غرفة المدينة';

  @override
  String get pilgrimLabelDepartureAirport => 'مطار الذهاب';

  @override
  String get pilgrimLabelDepartureAirline => 'شركة طيران الذهاب';

  @override
  String get pilgrimLabelDepartureFlight => 'رقم رحلة الذهاب';

  @override
  String get pilgrimLabelDepartureDate => 'تاريخ الذهاب';

  @override
  String get pilgrimLabelDepartureTime => 'وقت إقلاع الذهاب';

  @override
  String get pilgrimLabelReturnAirport => 'مطار العودة';

  @override
  String get pilgrimLabelReturnAirline => 'شركة طيران العودة';

  @override
  String get pilgrimLabelReturnFlight => 'رقم رحلة العودة';

  @override
  String get pilgrimLabelReturnDate => 'تاريخ العودة';

  @override
  String get pilgrimLabelReturnTime => 'وقت إقلاع العودة';

  @override
  String get pilgrimLabelServiceCenter => 'مركز الخدمات';

  @override
  String get pilgrimLabelCenterArafat => 'مركز الخدمة عرفات';

  @override
  String get pilgrimLabelCenterMina => 'مركز الخدمة منى';

  @override
  String get pilgrimLabelBusArafat => 'باص عرفات';

  @override
  String get pilgrimLabelBusMina => 'باص منى';

  @override
  String get pilgrimLabelTentArafat => 'خيمة عرفات';

  @override
  String get pilgrimLabelTentMina => 'خيمة منى';

  @override
  String get pilgrimLabelPhone => 'الهاتف';

  @override
  String get pilgrimLabelWhatsapp => 'واتساب';

  @override
  String get pilgrimLabelSyrianPhone => 'هاتف سوري';

  @override
  String get operatorGoAdminLogin => 'دخول المسؤول — التقارير';

  @override
  String get adminLoginTitle => 'دخول المسؤول';

  @override
  String get adminLoginSubtitle => 'تقارير وإحصائيات التكتل';

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
  String get adminContentListTitle => 'إدارة المحتوى';

  @override
  String get adminContentAdd => 'إضافة محتوى';

  @override
  String get adminContentEdit => 'تعديل';

  @override
  String get adminContentNewTitle => 'محتوى جديد';

  @override
  String get adminContentEditTitle => 'تعديل المحتوى';

  @override
  String get adminContentTabAnnouncements => 'الإعلانات';

  @override
  String get adminContentTabNews => 'الأخبار';

  @override
  String get adminContentTabLibrary => 'المكتبة التعليمية';

  @override
  String get adminContentNotifyPilgrims => 'إشعار الحجاج';

  @override
  String get adminContentNotifyPilgrimsHint =>
      'إرسال إشعار للحجاج بهذا التغيير.';

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
  String get competitionAnswerTrue => 'صح';

  @override
  String get competitionAnswerFalse => 'خطأ';

  @override
  String get competitionQuizTitle => 'الاختبار';

  @override
  String get competitionQuizLoadError => 'تعذر تحميل أسئلة الاختبار.';

  @override
  String get competitionQuizNoQuestions => 'لم تُضف أسئلة لهذه المسابقة بعد.';

  @override
  String competitionQuizProgress(int answered, int total) {
    return '$answered من $total أسئلة';
  }

  @override
  String get competitionQuizStart => 'ابدأ الاختبار';

  @override
  String get competitionQuizContinue => 'تابع الاختبار';

  @override
  String get competitionQuizReview => 'مراجعة الإجابات';

  @override
  String get competitionQuizSubmit => 'تحقق من الإجابة';

  @override
  String get competitionQuizSubmitError => 'تعذر إرسال إجابتك. أعد المحاولة.';

  @override
  String competitionQuizCorrect(int points) {
    return 'إجابة صحيحة! +$points نقطة';
  }

  @override
  String get competitionQuizIncorrect =>
      'ليست الإجابة الصحيحة — راجع الشرح أدناه.';

  @override
  String get competitionQuizComplete => 'أكملت الدرس!';

  @override
  String competitionQuizCompleteSummary(int count) {
    return 'أجبت على $count أسئلة في هذه المسابقة.';
  }

  @override
  String get competitionQuizDone => 'العودة للمسابقة';

  @override
  String competitionQuizQuestionBadge(int current, int total) {
    return 'السؤال $current من $total';
  }

  @override
  String get competitionPathTitle => 'مسار التعلّم';

  @override
  String get competitionPathSubtitle => 'أكمل كل درس بالترتيب لكسب النقاط.';

  @override
  String get competitionLessonLocked => 'أكمل الدرس السابق أولاً.';

  @override
  String get competitionLearnBadge => 'تعلّم تفاعلي';

  @override
  String get competitionLearnHeroTitle => 'تعلّم مناسك الحج بطريقة ممتعة';

  @override
  String get competitionLearnHeroSubtitle =>
      'أجب على الأسئلة، تابع تقدمك، وتنافس على لوحة المتصدرين.';

  @override
  String get competitionStatusOpen => 'مفتوحة الآن';

  @override
  String get competitionStatusUpcoming => 'قريباً';

  @override
  String get competitionJoinPrompt => 'انضم لهذه المسابقة لبدء كسب النقاط.';

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
  String get adminCompetitionQuestionsTitle => 'الأسئلة';

  @override
  String get adminCompetitionQuestionAdd => 'إضافة سؤال';

  @override
  String get adminCompetitionQuestionsEmpty =>
      'لا توجد أسئلة بعد. أضف أسئلة اختيار من متعدد أو صح/خطأ.';

  @override
  String get adminCompetitionQuestionsLoadError => 'تعذر تحميل الأسئلة.';

  @override
  String get adminCompetitionQuestionNewTitle => 'سؤال جديد';

  @override
  String get adminCompetitionQuestionEditTitle => 'تعديل السؤال';

  @override
  String get adminCompetitionQuestionTypeLabel => 'نوع السؤال';

  @override
  String get adminCompetitionQuestionTypeMultipleChoice => 'اختيار من متعدد';

  @override
  String get adminCompetitionQuestionTypeTrueFalse => 'صح أو خطأ';

  @override
  String get adminCompetitionQuestionTypeOrdering => 'ترتيب الخطوات';

  @override
  String get adminCompetitionQuestionOrderingStepsLabel =>
      'الخطوات (الأعلى = الأولى)';

  @override
  String get adminCompetitionQuestionOrderingStepsHint =>
      'اسحب لتحديد الترتيب الصحيح الذي يجب على الحاج اتباعه.';

  @override
  String adminCompetitionQuestionStepLabel(int number) {
    return 'الخطوة $number';
  }

  @override
  String get adminCompetitionQuestionAddStep => 'إضافة خطوة';

  @override
  String get competitionOrderingHint => 'اسحب البطاقات إلى الترتيب الصحيح.';

  @override
  String competitionQuizOrderingBadge(int current, int total) {
    return 'ترتيب · $current/$total';
  }

  @override
  String get adminCompetitionQuestionPromptLabel => 'نص السؤال';

  @override
  String get adminCompetitionQuestionPromptRequired => 'نص السؤال مطلوب.';

  @override
  String get adminCompetitionQuestionExplanationLabel =>
      'شرح (يُعرض بعد الإجابة)';

  @override
  String get adminCompetitionQuestionPointsLabel => 'نقاط الإجابة الصحيحة';

  @override
  String get adminCompetitionQuestionPointsInvalid =>
      'أدخل عدداً موجباً للنقاط.';

  @override
  String adminCompetitionQuestionPoints(int points) {
    return '$points نقطة';
  }

  @override
  String get adminCompetitionQuestionOptionsLabel => 'خيارات الإجابة';

  @override
  String adminCompetitionQuestionOptionLabel(int number) {
    return 'الخيار $number';
  }

  @override
  String get adminCompetitionQuestionOptionRequired => 'نص الخيار مطلوب.';

  @override
  String get adminCompetitionQuestionSaveError => 'تعذر حفظ السؤال.';

  @override
  String get adminCompetitionQuestionDeleteTitle => 'حذف السؤال؟';

  @override
  String get adminCompetitionQuestionDeleteMessage =>
      'سيُحذف هذا السؤال وإجاباته.';

  @override
  String get adminCompetitionQuestionDeleteConfirm => 'حذف';

  @override
  String get adminCompetitionQuestionDeleteSuccess => 'تم حذف السؤال.';

  @override
  String get adminCompetitionQuestionDeleteError => 'تعذر حذف السؤال.';

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

  @override
  String get languageSwitcherTitle => 'اختر اللغة';

  @override
  String get languageSwitcherSubtitle => 'سيتم حفظ اختيارك للمرة القادمة';

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
  String get navHome => 'الرئيسية';

  @override
  String get navGuidance => 'الإرشادات';

  @override
  String get navServices => 'الخدمات';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get homeNextPrayer => 'الصلاة القادمة';

  @override
  String get homePrayerLocation => 'مكة، السعودية';

  @override
  String get homeQuickActionsTitle => 'الأدوات السريعة';

  @override
  String get homeSeeAll => 'عرض الكل ←';

  @override
  String get homeJourneyTitle => 'ابدأ رحلتك المقدسة';

  @override
  String get homeJourneyBody =>
      'للاستفسار عن التسجيل تواصل معنا. إذا زوّدك الفريق التقني بمعلومات الحساب، أدخلها للدخول.';

  @override
  String get homeContactUs => 'تواصل معنا';

  @override
  String get homeEnterRegistration => 'إدخال معلومات التسجيل';

  @override
  String get homeRegisterNow => 'سجّل الآن';

  @override
  String get homeNewsSeeAll => 'عرض الكل ←';

  @override
  String get contentImportantTag => 'مهم';

  @override
  String contentHoursAgo(int hours) {
    return 'منذ $hours ساعة';
  }

  @override
  String get profileGuestTitle => 'زائر';

  @override
  String get profileGuestBody =>
      'سجّل الدخول للوصول إلى رحلة حجّك والمناسك والمحتوى المخصص.';

  @override
  String get notificationsLatestUpdates => 'آخر المستجدات';

  @override
  String get notificationsFilterAll => 'الكل';

  @override
  String get notificationsFilterGeneral => 'أخبار عامة';

  @override
  String get notificationsFilterUrgent => 'تنبيهات عاجلة';

  @override
  String get notificationsUrgentBadge => 'تنبيه عاجل!';

  @override
  String notificationsMinutesAgo(int minutes) {
    return 'منذ $minutes دقيقة';
  }

  @override
  String get notificationsGroupToday => 'اليوم';

  @override
  String get notificationsGroupYesterday => 'أمس';

  @override
  String get notificationsGroupEarlier => 'الأقدم';

  @override
  String notificationsUnreadCount(int count) {
    return '$count غير مقروء';
  }

  @override
  String get notificationsAllReadSubtitle => 'تمت قراءة الكل';

  @override
  String get notificationsAllCaughtUp => 'أنت على اطّلاع بكل جديد';

  @override
  String get notificationsNewBadge => 'جديد';

  @override
  String get notificationsRefresh => 'تحديث';

  @override
  String get notificationsJustNow => 'الآن';

  @override
  String notificationsHoursAgoShort(int hours) {
    return '$hours س';
  }

  @override
  String notificationsMinutesAgoShort(int minutes) {
    return '$minutes د';
  }

  @override
  String get staffNavHome => 'الرئيسية';

  @override
  String get staffNavPilgrims => 'الحجاج';

  @override
  String get staffNavOperators => 'المشغّلون';

  @override
  String get staffNavGroups => 'المجموعات';

  @override
  String get staffNavContent => 'إدارة المحتوى';

  @override
  String get staffNavCompetitions => 'المسابقات';

  @override
  String get staffNavNotifications => 'الإشعارات';

  @override
  String get staffNavSettings => 'الإعدادات';

  @override
  String get staffSidebarCollapse => 'طيّ الشريط الجانبي';

  @override
  String get staffSidebarExpand => 'توسيع الشريط الجانبي';

  @override
  String get staffPortalSubtitle => 'بوابة المسؤول';

  @override
  String get staffDefaultUser => 'المسؤول';

  @override
  String get staffAdminRole => 'المسؤول الرئيسي';

  @override
  String get staffConnectedStatus => 'متصل بالخدمة';

  @override
  String get staffOfflineStatus => 'غير متصل';

  @override
  String get staffOfflineBanner =>
      'يبدو أنك غير متصل بالإنترنت. قد لا تعمل بعض الإجراءات حتى يعود الاتصال.';

  @override
  String get staffErrorNetwork =>
      'تعذّر الوصول إلى الخادم. تحقق من اتصال الإنترنت ثم أعد المحاولة.';

  @override
  String get staffErrorPermission => 'ليس لديك صلاحية لتنفيذ هذا الإجراء.';

  @override
  String get staffErrorGeneric => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get staffActiveNow => 'نشط الآن';

  @override
  String get staffStable => 'مستقر';

  @override
  String get staffNavRegister => 'تسجيل حاج';

  @override
  String get staffOperatorPortalSubtitle => 'بوابة التقني';

  @override
  String get staffOperatorRole => 'تقني المركز';

  @override
  String get operatorSectionPersonalInfo => 'البيانات الشخصية';

  @override
  String get operatorSectionPersonalInfoHint =>
      'الاسم الكامل كما في جواز السفر.';

  @override
  String get operatorSectionAccount => 'حساب الموبايل';

  @override
  String get operatorSectionAccountHint => 'بيانات الدخول لتطبيق الحاج.';

  @override
  String get operatorSectionDocumentsHint =>
      'ارفع جواز السفر أو التصريح أو الملفات الطبية (PDF أو صور).';

  @override
  String get operatorSectionLogisticsHint =>
      'تفاصيل السفر والإقامة (اختياري عند التسجيل).';

  @override
  String get operatorClearForm => 'مسح النموذج';

  @override
  String get operatorPilgrimListSubtitle => 'ابحث وأدر الحجاج المسجّلين.';

  @override
  String get adminNotificationSendSubtitle => 'أنشئ وأرسل إشعاراً ثنائي اللغة.';

  @override
  String get adminNotificationContentSection => 'محتوى الرسالة';

  @override
  String get adminOperatorsTitle => 'إدارة المشغّلين';

  @override
  String get adminOperatorsSubtitle =>
      'أضف المشغّلين وتحكّم بأدوارهم وصلاحياتهم.';

  @override
  String get adminOperatorAdd => 'إضافة مشغّل';

  @override
  String get adminOperatorNewTitle => 'مشغّل جديد';

  @override
  String get adminOperatorEditTitle => 'تعديل المشغّل';

  @override
  String get adminOperatorFullName => 'الاسم الكامل';

  @override
  String get adminOperatorFullNameRequired => 'الاسم الكامل مطلوب';

  @override
  String get adminOperatorEmail => 'البريد الإلكتروني';

  @override
  String get adminOperatorEmailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get adminOperatorEmailInvalid => 'أدخل بريداً إلكترونياً صالحاً';

  @override
  String get adminOperatorActive => 'الحساب نشط';

  @override
  String get adminOperatorActiveLabel => 'نشط';

  @override
  String get adminOperatorInactive => 'غير نشط';

  @override
  String get adminOperatorPermissionsSection => 'الأدوار والصلاحيات';

  @override
  String get adminOperatorPermRegister => 'تسجيل الحجاج';

  @override
  String get adminOperatorPermRegisterHint =>
      'السماح بتسجيل الحجاج وإنشاء حسابات الموبايل.';

  @override
  String get adminOperatorPermRegistry => 'إدارة سجل الحجاج';

  @override
  String get adminOperatorPermRegistryHint => 'عرض وتعديل الحجاج المسجّلين.';

  @override
  String get adminOperatorPermField => 'أدوات المشغّل الميداني';

  @override
  String get adminOperatorPermFieldHint =>
      'الوصول إلى بوابة المشغّل الميداني وسير العمل الميداني.';

  @override
  String get adminOperatorPermUpload => 'رفع المستندات';

  @override
  String get adminOperatorPermUploadHint => 'رفع مستندات الحجاج أثناء التسجيل.';

  @override
  String get adminOperatorGroupsSection => 'صلاحية المجموعات';

  @override
  String get adminOperatorGroupsHint =>
      'اختر المكاتب (المجموعات) التي يمكن لهذا المشغّل قراءتها والكتابة فيها.';

  @override
  String get adminOperatorGroupsEmpty => 'لا توجد مجموعات متاحة بعد.';

  @override
  String get adminOperatorGroupRead => 'قراءة';

  @override
  String get adminOperatorGroupWrite => 'قراءة وكتابة';

  @override
  String get adminOperatorGeneratePassword => 'توليد كلمة مرور';

  @override
  String get adminOperatorPasswordLabel => 'كلمة المرور';

  @override
  String get adminOperatorPasswordCreateHint =>
      'اتركه فارغاً لتوليد كلمة مرور آمنة تلقائياً.';

  @override
  String get adminOperatorPasswordEditHint =>
      'اتركه فارغاً للإبقاء على كلمة المرور الحالية.';

  @override
  String get adminOperatorCopyPassword => 'نسخ كلمة المرور';

  @override
  String get adminOperatorCreateSuccess => 'تم إنشاء حساب المشغّل';

  @override
  String get adminOperatorSaveSuccess => 'تم تحديث المشغّل';

  @override
  String get adminOperatorSaveError => 'تعذّر حفظ المشغّل. حاول مرة أخرى.';

  @override
  String get adminOperatorLoadError => 'تعذّر تحميل المشغّلين.';

  @override
  String get adminOperatorEmpty => 'لا يوجد مشغّلون بعد. أضف أول تقني مركز.';

  @override
  String get staffTableEmpty => 'لا توجد نتائج';

  @override
  String get staffTableRowsPerPage => 'صفوف لكل صفحة';

  @override
  String get staffTableDensityCompact => 'صفوف مضغوطة';

  @override
  String get staffTableDensityComfortable => 'صفوف مريحة';

  @override
  String get staffTablePreviousPage => 'الصفحة السابقة';

  @override
  String get staffTableNextPage => 'الصفحة التالية';

  @override
  String staffTableShowing(int from, int to, int total) {
    return 'عرض $from–$to من $total';
  }

  @override
  String staffTablePageOf(int current, int total) {
    return 'صفحة $current من $total';
  }

  @override
  String get staffTableFilterAll => 'الكل';

  @override
  String get staffTableColumnsTitle => 'أعمدة الجدول';

  @override
  String get staffTableColumnsApply => 'تطبيق';

  @override
  String get staffTableColumnsShowAll => 'إظهار الكل';

  @override
  String get staffTableColumnsCustomize => 'الأعمدة';

  @override
  String get staffTableColumnRequired => 'يظهر دائماً';

  @override
  String get staffTableFilterStatus => 'الحالة';

  @override
  String get staffTableColumnCreated => 'تاريخ الإنشاء';

  @override
  String get staffTableSearchOperators => 'ابحث بالاسم أو البريد';

  @override
  String get staffTableSearchContent => 'ابحث بالعنوان أو الوصف';

  @override
  String get staffTableSearchCompetitions => 'ابحث بالعنوان أو الوصف';

  @override
  String get staffTableSearchGroups => 'ابحث باسم المجموعة أو الرئيس';

  @override
  String get staffTableFilterGender => 'الجنس';

  @override
  String get staffTableFilterGroup => 'المجموعة';

  @override
  String staffTableSelectedCount(int count) {
    return '$count محدّد';
  }

  @override
  String get staffTableClearSelection => 'مسح التحديد';

  @override
  String get pilgrimGenderMale => 'ذكر';

  @override
  String get pilgrimGenderFemale => 'أنثى';

  @override
  String get adminPilgrimAdd => 'إضافة حاج';

  @override
  String get adminPilgrimProfileSection => 'ملف الحاج';

  @override
  String get adminPilgrimBulkAssignGroup => 'تعيين مجموعة';

  @override
  String get adminPilgrimBulkClearGroup => 'إزالة المجموعة';

  @override
  String get adminPilgrimAssignGroupTitle => 'تعيين مجموعة للحجاج المحدّدين';

  @override
  String get adminPilgrimAssignGroupConfirm => 'تعيين';

  @override
  String get adminPilgrimAssignGroupSuccess =>
      'تم تحديث مجموعة الحجاج المحدّدين';

  @override
  String get adminPilgrimAssignGroupError => 'تعذّر تحديث تعيين المجموعة';

  @override
  String get adminPilgrimNoGroups => 'لا توجد مجموعات. أنشئ مجموعة أولاً.';

  @override
  String get adminGroupsTitle => 'إدارة المجموعات';

  @override
  String get adminGroupsSubtitle => 'أدر مجموعات الحج والقيادة وأعضاء الإدارة.';

  @override
  String get adminGroupAdd => 'إضافة مجموعة';

  @override
  String get adminGroupNewTitle => 'مجموعة جديدة';

  @override
  String get adminGroupEditTitle => 'تعديل المجموعة';

  @override
  String get adminGroupDetailsSection => 'بيانات المجموعة';

  @override
  String get adminGroupName => 'اسم المجموعة';

  @override
  String get adminGroupNameRequired => 'اسم المجموعة مطلوب';

  @override
  String get adminGroupUploadLogo => 'رفع الشعار';

  @override
  String get adminGroupPresidentName => 'اسم الرئيس';

  @override
  String get adminGroupPresidentPhone => 'هاتف الرئيس';

  @override
  String get adminGroupMembersSection => 'أعضاء الإدارة';

  @override
  String get adminGroupMembersSectionHint =>
      'أضف المنسقين والموظفين مع أدوارهم وبيانات التواصل.';

  @override
  String get adminGroupAddMember => 'إضافة عضو';

  @override
  String get adminGroupRemoveMember => 'إزالة العضو';

  @override
  String get adminGroupMembersEmpty => 'لا يوجد أعضاء إدارة بعد.';

  @override
  String get adminGroupMemberName => 'اسم العضو';

  @override
  String get adminGroupMemberNameRequired => 'اسم العضو مطلوب';

  @override
  String get adminGroupMemberPosition => 'المنصب';

  @override
  String get adminGroupMemberContact => 'التواصل';

  @override
  String get adminGroupUploadPhoto => 'رفع الصورة';

  @override
  String get adminGroupMembersCount => 'الأعضاء';

  @override
  String get adminGroupCreateSuccess => 'تم إنشاء المجموعة';

  @override
  String get adminGroupSaveSuccess => 'تم تحديث المجموعة';

  @override
  String get adminGroupSaveError => 'تعذّر حفظ المجموعة. حاول مرة أخرى.';

  @override
  String get adminGroupsLoadError => 'تعذّر تحميل المجموعات.';

  @override
  String get adminGroupsEmpty => 'لا توجد مجموعات بعد. أضف أول مجموعة حج.';

  @override
  String get adminGroupDeleteTitle => 'حذف المجموعة؟';

  @override
  String adminGroupDeleteMessage(String name) {
    return 'حذف \"$name\"؟ سيتم إلغاء ربط الحجاج في هذه المجموعة.';
  }

  @override
  String get adminGroupDeleteConfirm => 'حذف';

  @override
  String get adminGroupDeleteSuccess => 'تم حذف المجموعة';

  @override
  String get adminGroupDeleteError => 'تعذّر حذف المجموعة';

  @override
  String get adminSettingsTitle => 'إعدادات النظام';

  @override
  String get adminSettingsSubtitle =>
      'تهيئة بيانات المؤسسة والميزات وسلوك المنصة.';

  @override
  String get adminSettingsSave => 'حفظ الإعدادات';

  @override
  String get adminSettingsSaveSuccess => 'تم حفظ الإعدادات';

  @override
  String get adminSettingsSaveError => 'تعذّر حفظ الإعدادات. حاول مرة أخرى.';

  @override
  String get adminSettingsLoadError => 'تعذّر تحميل الإعدادات.';

  @override
  String get adminSettingsOrganizationSection => 'المؤسسة';

  @override
  String get adminSettingsOrganizationSectionHint =>
      'الاسم الظاهر للجمهور وبيانات الدعم لموسم الحج.';

  @override
  String get adminSettingsOrganizationName => 'اسم المؤسسة';

  @override
  String get adminSettingsOrganizationNameRequired => 'اسم المؤسسة مطلوب';

  @override
  String get adminSettingsHajjSeason => 'تسمية موسم الحج';

  @override
  String get adminSettingsSupportEmail => 'بريد الدعم';

  @override
  String get adminSettingsSupportPhone => 'هاتف الدعم';

  @override
  String get adminSettingsOperationsSection => 'التشغيل';

  @override
  String get adminSettingsOperationsSectionHint =>
      'التحكم في فتح التسجيل ونوافذ الصيانة.';

  @override
  String get adminSettingsRegistrationOpen => 'التسجيل مفتوح';

  @override
  String get adminSettingsRegistrationOpenHint =>
      'السماح للمشغّلين بتسجيل حجاج جدد.';

  @override
  String get adminSettingsMaintenanceMode => 'وضع الصيانة';

  @override
  String get adminSettingsMaintenanceModeHint =>
      'عرض رسالة صيانة وتقييد إجراءات الموظفين.';

  @override
  String get adminSettingsMaintenanceMessage => 'رسالة الصيانة';

  @override
  String get adminSettingsIntakeSection => 'تسجيل الحجاج';

  @override
  String get adminSettingsIntakeSectionHint =>
      'الإعدادات الافتراضية لسير عمل تسجيل المشغّلين.';

  @override
  String get adminSettingsRequireDocuments => 'اشتراط المستندات عند التسجيل';

  @override
  String get adminSettingsRequireDocumentsHint =>
      'يجب على المشغّلين رفع المستندات المطلوبة عند تسجيل الحجاج.';

  @override
  String get adminSettingsAutoGeneratePassword =>
      'إنشاء كلمات مرور الحجاج تلقائياً';

  @override
  String get adminSettingsAutoGeneratePasswordHint =>
      'إنشاء كلمات مرور آمنة تلقائياً أثناء التسجيل.';

  @override
  String get adminSettingsOperatorSelfRegistration =>
      'السماح بتسجيل المشغّلين الذاتي';

  @override
  String get adminSettingsOperatorSelfRegistrationHint =>
      'السماح للمشغّلين الجدد بطلب حسابات دون موافقة المسؤول.';

  @override
  String get adminSettingsMaxPilgrimsPerGroup =>
      'الحد الأقصى للحجاج في المجموعة';

  @override
  String get adminSettingsMaxPilgrimsPerGroupHint =>
      'اتركه فارغاً لعدم وجود حد.';

  @override
  String get adminSettingsMaxPilgrimsInvalid =>
      'أدخل رقماً موجباً أو اتركه فارغاً.';

  @override
  String get adminSettingsFeaturesSection => 'الميزات';

  @override
  String get adminSettingsFeaturesSectionHint =>
      'تفعيل أو تعطيل الوحدات الرئيسية في التطبيق.';

  @override
  String get adminSettingsPublicContentFeed => 'موجز المحتوى العام';

  @override
  String get adminSettingsPublicContentFeedHint =>
      'عرض الأخبار والفيديوهات في الشاشة الرئيسية للحاج.';

  @override
  String get adminSettingsCompetitions => 'المسابقات';

  @override
  String get adminSettingsCompetitionsHint =>
      'السماح للحجاج بعرض والانضمام إلى مسابقات الحج.';

  @override
  String get adminSettingsRitualTracking => 'تتبع مناسك الحاج';

  @override
  String get adminSettingsRitualTrackingHint =>
      'تتبع وعرض تقدم المناسك للحجاج.';

  @override
  String get adminSettingsNotificationsSection => 'الإشعارات';

  @override
  String get adminSettingsNotificationsSectionHint =>
      'التحكم في الإشعارات داخل التطبيق والإشعارات الفورية.';

  @override
  String get adminSettingsInAppNotifications => 'الإشعارات داخل التطبيق';

  @override
  String get adminSettingsInAppNotificationsHint =>
      'تسليم الإشعارات في صندوق وارد الحاج.';

  @override
  String get adminSettingsPushNotifications => 'الإشعارات الفورية';

  @override
  String get adminSettingsPushNotificationsHint =>
      'إرسال إشعارات Firebase إلى الأجهزة.';

  @override
  String get adminSettingsPushNotificationsUnavailable =>
      'Firebase غير مهيأ. لا يمكن تفعيل الإشعارات الفورية.';

  @override
  String get notificationPermissionTitle => 'ابقَ على اطلاع برحلة حجك';

  @override
  String get notificationPermissionBody =>
      'فعّل الإشعارات لتلقي تحديثات الرحلة والمحتوى الجديد والمسابقات والتنبيهات العاجلة من مشغّلك.';

  @override
  String get notificationPermissionAllow => 'تفعيل الإشعارات';

  @override
  String get notificationPermissionNotNow => 'ليس الآن';

  @override
  String get notificationPermissionDeniedTitle => 'الإشعارات معطّلة';

  @override
  String get notificationPermissionDeniedBody =>
      'يمكنك تفعيل الإشعارات من إعدادات الجهاز لتلقي تحديثات الرحلة والتنبيهات العاجلة.';

  @override
  String get notificationPermissionOpenSettings => 'فتح الإعدادات';

  @override
  String get notificationSettingsTitle => 'تفضيلات الإشعارات';

  @override
  String get notificationSettingsSubtitle =>
      'اختر التنبيهات التي تصل إلى هذا الجهاز.';

  @override
  String get notificationSettingsLoadError => 'تعذر تحميل تفضيلات الإشعارات.';

  @override
  String get notificationSettingsSaveError => 'تعذر حفظ تفضيلات الإشعارات.';

  @override
  String get notificationSettingsPushMaster => 'الإشعارات الفورية';

  @override
  String get notificationSettingsPushMasterHint =>
      'المفتاح الرئيسي للتنبيهات على هذا الجهاز.';

  @override
  String get notificationSettingsCategoryAnnouncements => 'الإعلانات';

  @override
  String get notificationSettingsCategoryContent => 'محتوى جديد';

  @override
  String get notificationSettingsCategoryCompetitions => 'المسابقات';

  @override
  String get notificationSettingsCategoryUrgent => 'تنبيهات عاجلة';

  @override
  String get notificationSettingsCategoryUrgentHint =>
      'النجدة وتحديثات الحالة الميدانية وتنبيهات النظام.';

  @override
  String get notificationSettingsQuietHoursTitle => 'ساعات الهدوء';

  @override
  String get notificationSettingsQuietHoursHint =>
      'كتم التنبيهات غير العاجلة ليلاً. التنبيهات العاجلة (النجدة وتحديثات الحالة) تبقى فعّالة.';

  @override
  String get notificationSettingsQuietHoursEnabled => 'جدولة ساعات الهدوء';

  @override
  String get notificationSettingsQuietHoursStart => 'البداية';

  @override
  String get notificationSettingsQuietHoursEnd => 'النهاية';

  @override
  String get adminPushFailuresTitle => 'سجل تسليم الإشعارات';

  @override
  String get adminPushFailuresSubtitle =>
      'إرسالات FCM التي فشلت بعد إعادة المحاولة التلقائية.';

  @override
  String get adminPushFailuresEmpty =>
      'لا توجد إخفاقات مسجّلة في تسليم الإشعارات.';

  @override
  String get adminPushFailuresLoadError =>
      'تعذر تحميل إخفاقات تسليم الإشعارات.';

  @override
  String adminPushFailuresAttempts(int count) {
    return '$count محاولات';
  }

  @override
  String get adminPushFailuresToken => 'رمز الجهاز';

  @override
  String get adminPushFailuresRetry => 'إعادة الإرسال';

  @override
  String get adminPushFailuresRetryQueued => 'تمت إعادة جدولة الإرسال.';

  @override
  String get adminPushFailuresRetryError => 'تعذرت إعادة جدولة الإرسال.';

  @override
  String get adminSettingsManagementSection => 'اختصارات الإدارة';

  @override
  String get adminSettingsManagementSectionHint =>
      'الانتقال إلى مناطق الإدارة ذات الصلة.';

  @override
  String get adminSettingsIntegrationsSection => 'التكاملات';

  @override
  String get adminSettingsIntegrationsSectionHint =>
      'خدمات الخلفية المهيأة لهذا النشر.';

  @override
  String get adminSettingsSupabaseStatus => 'Supabase';

  @override
  String get adminSettingsFirebaseStatus => 'Firebase';

  @override
  String get adminSettingsStatusConfigured => 'مهيأ';

  @override
  String get adminSettingsStatusNotConfigured => 'غير مهيأ';

  @override
  String adminSettingsLastUpdated(String date) {
    return 'آخر تحديث $date';
  }

  @override
  String get profilePilgrimSubtitle =>
      'بيانات التسجيل التي أدخلها المشغّل عنك.';

  @override
  String get servicesHeroBadge => 'خدمات الحاج';

  @override
  String get servicesHeroTitle => 'مسار الخدمات';

  @override
  String get servicesHeroSubtitle =>
      'رحلة الحج التعليمية والمسابقات في مكان واحد.';

  @override
  String get servicesJourneySubtitle =>
      'تعلّم مناسك الحج خطوة بخطوة مع وسائط تعليمية.';

  @override
  String get servicesCompetitionsSubtitle =>
      'اختبر معلوماتك واجمع النقاط في مسابقات الحج.';

  @override
  String get servicesNotificationsSubtitle =>
      'اطّلع على آخر الإشعارات والتنبيهات.';

  @override
  String get hajjJourneyHeroSubtitle =>
      'اتبع مساراً تعليمياً لمناسك الحج من الإحرام إلى طواف الوداع.';

  @override
  String get hajjJourneyPathTitle => 'مسار المناسك';

  @override
  String get hajjJourneyPathSubtitle =>
      'أكمل كل نسك لفتح التالي — مثل مسار المسابقة.';

  @override
  String get hajjJourneyEmpty => 'لا توجد خطوات متاحة حالياً.';

  @override
  String get hajjJourneyLoadError => 'تعذر تحميل رحلة الحج.';

  @override
  String get hajjJourneyStepLocked => 'أكمل النسك السابق أولاً لفتح هذا النسك.';

  @override
  String get hajjJourneyStepNotFound => 'لم يُعثر على هذا النسك.';

  @override
  String get hajjJourneyContinue => 'تابع نسكك الحالي';

  @override
  String get hajjJourneyAboutRitual => 'عن هذا النسك';

  @override
  String get hajjJourneyMediaTitle => 'وسائط تعليمية';

  @override
  String get hajjJourneyNoMedia => 'لا توجد وسائط لهذا النسك بعد.';

  @override
  String get hajjJourneyMediaVideo => 'فيديو';

  @override
  String get hajjJourneyMediaAudio => 'صوت';

  @override
  String get hajjJourneyMediaImage => 'صورة';

  @override
  String hajjJourneyImageCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get hajjJourneySlideshowStart => 'تشغيل السلايدات';

  @override
  String get hajjJourneySlideshowStop => 'إيقاف السلايدات';

  @override
  String get educationalMediaTitle => 'وسائط تعليمية';

  @override
  String get educationalMediaEmpty => 'لا توجد وسائط متاحة.';

  @override
  String get educationalMediaVideo => 'فيديو';

  @override
  String get educationalMediaAudio => 'صوت';

  @override
  String get educationalMediaImage => 'صورة';

  @override
  String educationalMediaImageCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get educationalMediaSlideshowStart => 'تشغيل السلايدات';

  @override
  String get educationalMediaSlideshowStop => 'إيقاف السلايدات';

  @override
  String get adminContentTopicsManage => 'المواضيع التعليمية';

  @override
  String get adminContentTopicsListTitle => 'مواضيع المحتوى';

  @override
  String get adminContentTopicAdd => 'إضافة موضوع';

  @override
  String get adminContentTopicEmpty => 'لا توجد مواضيع بعد.';

  @override
  String get adminContentTopicMediaItems => 'وسائط';

  @override
  String get adminContentTopicLoadError => 'تعذر تحميل المواضيع.';

  @override
  String get adminContentTopicDeleteTitle => 'حذف الموضوع';

  @override
  String adminContentTopicDeleteMessage(String title) {
    return 'هل تريد حذف «$title»؟';
  }

  @override
  String get adminContentTopicDeleteSuccess => 'تم حذف الموضوع.';

  @override
  String get adminContentTopicDeleteError => 'تعذر حذف الموضوع.';

  @override
  String get adminContentTopicEditTitle => 'تعديل الموضوع';

  @override
  String get adminContentTopicNewTitle => 'موضوع جديد';

  @override
  String get adminContentTopicTitleRequired => 'أدخل عنوان الموضوع.';

  @override
  String get adminContentTopicDescription => 'الوصف';

  @override
  String get adminContentTopicCoverUrl => 'رابط صورة الغلاف';

  @override
  String get adminContentTopicMediaSection => 'سلسلة الوسائط';

  @override
  String get adminContentTopicSaveSuccess => 'تم حفظ الموضوع.';

  @override
  String get adminContentTopicSaveError => 'تعذر حفظ الموضوع.';

  @override
  String get adminContentTopicUploadCover => 'رفع صورة الغلاف';

  @override
  String get adminContentTopicUploadMedia => 'رفع ملف';

  @override
  String get adminContentTopicUploadSuccess => 'تم رفع الملف بنجاح.';

  @override
  String get adminContentTopicUploadError => 'تعذر رفع الملف.';

  @override
  String get adminContentTopicMediaPreview => 'معاينة الوسائط';

  @override
  String uploadErrorTooLarge(int maxMb) {
    return 'حجم الملف كبير جداً. الحد الأقصى المسموح $maxMb ميغابايت.';
  }

  @override
  String uploadErrorUnsupportedType(String types) {
    return 'نوع الملف غير مدعوم. المسموح: $types.';
  }

  @override
  String get uploadErrorEmpty => 'الملف المحدد فارغ أو تعذرت قراءته.';

  @override
  String uploadInProgress(int percent) {
    return 'جاري الرفع… $percent%';
  }

  @override
  String mediaCompressing(int percent) {
    return 'جاري الضغط… $percent%';
  }

  @override
  String get adminContentMediaUploadCover => 'رفع صورة';

  @override
  String get adminContentMediaUploadVideo => 'رفع فيديو';

  @override
  String get adminContentVideoExternalHint =>
      'للفيديوهات الكبيرة أو الطويلة، الصق رابط YouTube/Vimeo بدلاً من رفع الملف.';

  @override
  String get contentOfflineTitle => 'المحتوى دون إنترنت';

  @override
  String get contentOfflineSubtitle =>
      'حمّل المواضيع التعليمية (صوت وصور) للاستماع والمشاهدة بدون اتصال.';

  @override
  String get contentOfflineEnable => 'تفعيل التحميل التلقائي';

  @override
  String get contentOfflineDownloading => 'جاري التحميل في الخلفية…';

  @override
  String contentOfflineCachedCount(int count) {
    return '$count ملف محفوظ محلياً';
  }

  @override
  String get contentOfflineClearCache => 'مسح المحتوى المحفوظ';

  @override
  String get contentTopicOfflineTitle => 'الاستخدام دون إنترنت';

  @override
  String contentTopicOfflineProgress(int cached, int total) {
    return '$cached / $total ملفات جاهزة';
  }

  @override
  String get contentTopicOfflineDownload => 'تحميل';

  @override
  String get contentTopicOfflineStarted => 'بدأ التحميل في الخلفية.';

  @override
  String get contentOfflineWifiOnly => 'التحميل عبر Wi-Fi فقط';

  @override
  String get contentOfflineWifiOnlySubtitle =>
      'تجنّب استهلاك بيانات الجوّال أثناء التحميل.';

  @override
  String get contentOfflineWaitingWifi => 'بانتظار اتصال Wi-Fi…';

  @override
  String contentOfflineStorageUsage(String used, String total) {
    return '$used من $total مُستخدَمة';
  }

  @override
  String get contentTopicOfflineDownloaded => 'متاح دون إنترنت';

  @override
  String get contentTopicOfflineDelete => 'إزالة التحميل';

  @override
  String get contentTopicOfflinePause => 'إيقاف مؤقت';

  @override
  String get contentTopicOfflineResume => 'استئناف';

  @override
  String get contentTopicOfflineRetry => 'إعادة المحاولة';

  @override
  String contentTopicOfflineDownloading(int percent) {
    return 'جارٍ التحميل $percent%';
  }

  @override
  String get contentOfflineBanner =>
      'أنت غير متصل — يُعرض المحتوى المحفوظ حيثما أمكن.';

  @override
  String get contentCatalogCached => 'يُعرض الكتالوج المحفوظ — اسحب للتحديث';

  @override
  String get contentCatalogRefreshing => 'جاري تحديث المحتوى…';

  @override
  String get contentWifiOnboardingTitle => 'وفّر البيانات أثناء التحميل';

  @override
  String get contentWifiOnboardingBody =>
      'يمكن تحميل المواضيع التعليمية تلقائياً للاستخدام دون إنترنت. ننصح بالتحميل عبر Wi-Fi فقط لحماية بيانات الجوال.';

  @override
  String get contentWifiOnboardingConfirm => 'Wi-Fi فقط';

  @override
  String get contentWifiOnboardingLater => 'ليس الآن';

  @override
  String get contentDownloadsTitle => 'تنزيلاتي';

  @override
  String get contentDownloadsEmpty =>
      'لا يوجد محتوى محمّل بعد. فعّل التحميل دون إنترنت من الملف الشخصي.';

  @override
  String contentDownloadsTopicSummary(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ملفات',
      one: 'ملف واحد',
    );
    return '$_temp0 · $size';
  }

  @override
  String get contentSearchTitle => 'بحث في المحتوى المحفوظ';

  @override
  String get contentHubQuickActionsTitle => 'اختصارات التعلّم';

  @override
  String get contentSearchHint => 'ابحث في المواضيع والأخبار والإعلانات…';

  @override
  String get contentSearchPrompt =>
      'ابحث في الكتالوج المحفوظ أثناء عدم الاتصال';

  @override
  String get contentSearchEmpty => 'لا نتائج في المحتوى المحفوظ';

  @override
  String get contentMyLearningTitle => 'تعلّمي';

  @override
  String get contentMyLearningEmpty =>
      'لا يوجد تقدم بعد. ابدأ موضوعاً من المكتبة التعليمية.';

  @override
  String get contentMyLearningInProgress => 'قيد المتابعة';

  @override
  String get contentMyLearningCompleted => 'مكتمل';

  @override
  String get contentMyLearningCompletedLabel => 'مكتمل';

  @override
  String get contentMyLearningResumeHint => 'اضغط للمتابعة';

  @override
  String get contentLessonsListTitle => 'الدروس';

  @override
  String get contentArticleOfflineSave => 'حفظ الغلاف دون إنترنت';

  @override
  String get contentArticleOfflineSaved => 'تم حفظ الغلاف';

  @override
  String get adminContentTitleArLabel => 'العنوان (عربي)';

  @override
  String get adminContentTitleEnLabel => 'العنوان (إنجليزي)';

  @override
  String get adminContentDescriptionArLabel => 'الوصف (عربي)';

  @override
  String get adminContentDescriptionEnLabel => 'الوصف (إنجليزي)';

  @override
  String get adminContentPublicationStatusLabel => 'النشر';

  @override
  String get adminContentPublicationDraft => 'مسودة';

  @override
  String get adminContentPublicationPublished => 'منشور';

  @override
  String get adminContentCoverPreviewLabel => 'معاينة الغلاف';

  @override
  String get adminContentMarkdownPreviewLabel => 'معاينة';

  @override
  String get competitionQuizQueuedOffline =>
      'تم حفظ الإجابة — ستُزامَن عند عودة الاتصال';

  @override
  String get contentLessonMarkComplete => 'إكمال الدرس';

  @override
  String get contentLessonNext => 'الدرس التالي';

  @override
  String contentMyLearningSummaryInProgress(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دروس قيد المتابعة',
      one: 'درس واحد قيد المتابعة',
    );
    return '$_temp0';
  }

  @override
  String contentMyLearningSummaryCompleted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دروس مكتملة',
      one: 'درس واحد مكتمل',
    );
    return '$_temp0';
  }

  @override
  String get contentMyLearningContinueTopic => 'متابعة الموضوع';

  @override
  String get contentLessonInProgress => 'قيد المتابعة';

  @override
  String contentTopicLessonsProgress(int completed, int total) {
    return '$completed من $total دروس';
  }

  @override
  String get contentContinueLearningResume => 'تابع من حيث توقفت';

  @override
  String get contentContinueLearning => 'تابع التعلم';

  @override
  String get contentTopicRequiresInternet =>
      'بعض الفيديوهات تتطلب اتصالاً بالإنترنت (يوتيوب/فيميو).';

  @override
  String get contentDownloadAll => 'تحميل كل المواضيع';

  @override
  String get contentTopicOfflineAvailable => 'دون إنترنت';

  @override
  String contentTopicDownloadSizeEstimate(String size) {
    return 'الحجم التقديري للتحميل: $size ميغابايت';
  }

  @override
  String get educationalMediaVideoError => 'تعذّر تشغيل هذا الفيديو.';

  @override
  String get hajjJourneyMarkComplete => 'تم الإنجاز';

  @override
  String get hajjJourneyAlreadyCompleted => 'مكتمل — العودة للمسار';

  @override
  String get hajjJourneyCompletedSnack => 'بارك الله فيك! تم إنجاز النسك.';

  @override
  String get hajjJourneyNextStepTitle => 'النسك التالي';

  @override
  String get hajjJourneyNextStepBody => 'هل تريد الانتقال إلى النسك التالي؟';

  @override
  String get hajjJourneyStayHere => 'البقاء هنا';

  @override
  String get hajjJourneyGoNext => 'النسك التالي';

  @override
  String get adminManageHajjJourney => 'إدارة رحلة الحج';

  @override
  String get adminHajjJourneyTitle => 'رحلة الحج';

  @override
  String get adminHajjJourneyLoadError => 'تعذر تحميل خطوات رحلة الحج.';

  @override
  String get adminHajjJourneyEmpty =>
      'لا توجد خطوات بعد. طبّق ترحيل قاعدة البيانات.';

  @override
  String adminHajjJourneyMediaCount(int count) {
    return '$count وسائط';
  }

  @override
  String get adminHajjJourneyInactive => 'غير نشط';

  @override
  String get adminHajjJourneyEditTitle => 'تحرير النسك';

  @override
  String get adminHajjJourneyTitleAr => 'العنوان (عربي)';

  @override
  String get adminHajjJourneyTitleEn => 'العنوان (إنجليزي)';

  @override
  String get adminHajjJourneyDescriptionAr => 'الشرح (عربي)';

  @override
  String get adminHajjJourneyDescriptionEn => 'الشرح (إنجليزي)';

  @override
  String get adminHajjJourneySortOrder => 'ترتيب العرض';

  @override
  String get adminHajjJourneyActive => 'نشط';

  @override
  String get adminHajjJourneyMediaSection => 'الوسائط التعليمية';

  @override
  String get adminHajjJourneyMediaType => 'نوع الوسائط';

  @override
  String get adminHajjJourneyMediaTitle => 'عنوان الوسائط';

  @override
  String get adminHajjJourneyMediaUrl => 'رابط الوسائط';

  @override
  String get adminHajjJourneyRemoveMedia => 'إزالة';

  @override
  String get adminHajjJourneyTitleRequired =>
      'العنوان بالعربية والإنجليزية مطلوب.';

  @override
  String get adminHajjJourneySaveSuccess => 'تم حفظ النسك.';

  @override
  String get adminHajjJourneySaveError => 'تعذر حفظ النسك.';

  @override
  String get staffNavTrips => 'الرحلات';

  @override
  String get adminTripsTitle => 'إدارة الرحلات';

  @override
  String get adminTripsSubtitle =>
      'إدارة رحلات الحج والعمرة لكل موسم والمكاتب المشاركة فيها.';

  @override
  String get adminTripAdd => 'إضافة رحلة';

  @override
  String get adminTripsEmpty => 'لا توجد رحلات بعد. أضف أول رحلة حج أو عمرة.';

  @override
  String get adminTripsLoadError => 'تعذر تحميل الرحلات.';

  @override
  String get adminTripNewTitle => 'رحلة جديدة';

  @override
  String get adminTripEditTitle => 'تعديل الرحلة';

  @override
  String get adminTripName => 'اسم الرحلة';

  @override
  String get adminTripNameRequired => 'اسم الرحلة مطلوب';

  @override
  String get adminTripType => 'نوع الرحلة';

  @override
  String get adminTripTypeHajj => 'حج';

  @override
  String get adminTripTypeUmrah => 'عمرة';

  @override
  String get adminTripSeasonYear => 'سنة الموسم';

  @override
  String get adminTripSeasonYearRequired => 'يجب إدخال سنة موسم صحيحة';

  @override
  String get adminTripStatus => 'الحالة';

  @override
  String get adminTripMarkActive => 'تفعيل الرحلة';

  @override
  String get adminTripMarkFinished => 'إنهاء الرحلة';

  @override
  String get adminTripStatusUpdated => 'تم تحديث حالة الرحلة';

  @override
  String get adminTripStatusPlanning => 'قيد التخطيط';

  @override
  String get adminTripStatusActive => 'نشطة';

  @override
  String get adminTripStatusCompleted => 'منتهية';

  @override
  String get adminTripStatusCancelled => 'ملغاة';

  @override
  String get adminTripSave => 'حفظ الرحلة';

  @override
  String get adminTripCreateSuccess => 'تم إنشاء الرحلة';

  @override
  String get adminTripSaveSuccess => 'تم تحديث الرحلة';

  @override
  String get adminTripSaveError => 'تعذر حفظ الرحلة. حاول مجدداً.';

  @override
  String get adminTripDeleteTitle => 'حذف الرحلة؟';

  @override
  String adminTripDeleteMessage(String name) {
    return 'حذف «$name»؟ ستُزال جميع تسجيلات الحجاج في هذه الرحلة.';
  }

  @override
  String get adminTripDeleteConfirm => 'حذف';

  @override
  String get adminTripDeleteSuccess => 'تم حذف الرحلة';

  @override
  String get adminTripDeleteError => 'تعذر حذف الرحلة';

  @override
  String get adminTripManageOffices => 'إدارة المكاتب';

  @override
  String get adminTripOfficesTitle => 'المكاتب المشاركة';

  @override
  String get adminTripOfficesSubtitle =>
      'إضافة أو سحب المكاتب السياحية من هذه الرحلة.';

  @override
  String get adminTripOfficesEmpty => 'لم ينضم أي مكتب لهذه الرحلة بعد.';

  @override
  String get adminTripAddOffice => 'إضافة مكتب';

  @override
  String get adminTripNoAvailableOffices => 'جميع المكاتب منضمة لهذه الرحلة.';

  @override
  String get adminTripOfficeWithdraw => 'سحب';

  @override
  String get adminTripOfficeActivate => 'إعادة تفعيل';

  @override
  String get adminTripOfficeRemove => 'إزالة';

  @override
  String get adminTripOfficeActive => 'نشط';

  @override
  String get adminTripOfficeWithdrawn => 'منسحب';

  @override
  String get adminTripOfficeUpdated => 'تم تحديث المكتب';

  @override
  String get adminTripOfficeAdded => 'تمت إضافة المكتب للرحلة';

  @override
  String get adminTripOfficeError => 'تعذر تحديث المكتب';

  @override
  String get tripSelectorLabel => 'الرحلة النشطة';

  @override
  String get tripSelectorAll => 'كل الرحلات';

  @override
  String get staffNavContacts => 'أرقام التواصل';

  @override
  String get staffNavSos => 'نداءات الاستغاثة';

  @override
  String get servicesContactsSubtitle =>
      'أرقام الطوارئ والخدمات — اتصل أو راسل عبر واتساب.';

  @override
  String get supportContactsTitle => 'المساعدة وأرقام التواصل';

  @override
  String get supportContactsSubtitle =>
      'تواصل مع الجهة المناسبة بسرعة. اتصل أو راسل عبر واتساب.';

  @override
  String get supportContactsEmpty => 'لا توجد أرقام متاحة حالياً.';

  @override
  String get supportContactsError => 'تعذّر تحميل الأرقام. تحقّق من الاتصال.';

  @override
  String get supportContactsCall => 'اتصال';

  @override
  String get supportContactsWhatsapp => 'واتساب';

  @override
  String get supportContactsLaunchFailed => 'تعذّر فتح هذا الرقم.';

  @override
  String get adminSupportContactsTitle => 'أرقام التواصل';

  @override
  String get adminSupportContactsSubtitle =>
      'أرقام الهاتف والواتساب التي تظهر للحجاج.';

  @override
  String get adminSupportContactsEmpty => 'لا توجد أرقام بعد. أضف أول رقم.';

  @override
  String get adminSupportContactAdd => 'إضافة رقم';

  @override
  String get adminSupportContactEditTitle => 'تعديل رقم';

  @override
  String get adminSupportContactNewTitle => 'رقم جديد';

  @override
  String get adminSupportContactDetailsSection => 'تفاصيل الرقم';

  @override
  String get adminSupportContactScopeSection => 'الظهور';

  @override
  String get adminSupportContactLabelAr => 'الاسم (عربي)';

  @override
  String get adminSupportContactLabelEn => 'الاسم (إنجليزي)';

  @override
  String get adminSupportContactLabelRequired => 'الاسمان مطلوبان';

  @override
  String get adminSupportContactDescriptionAr => 'الوصف (عربي)';

  @override
  String get adminSupportContactDescriptionEn => 'الوصف (إنجليزي)';

  @override
  String get adminSupportContactPhone => 'رقم الهاتف';

  @override
  String get adminSupportContactWhatsapp => 'رقم الواتساب';

  @override
  String get adminSupportContactScope => 'الجمهور';

  @override
  String get adminSupportContactScopeGlobal => 'الجميع';

  @override
  String get adminSupportContactScopeGroup => 'مجموعة محددة';

  @override
  String get adminSupportContactGroup => 'المجموعة';

  @override
  String get adminSupportContactGroupRequired => 'اختر مجموعة لهذا الرقم';

  @override
  String get adminSupportContactChannelRequired => 'أضف رقم هاتف أو واتساب';

  @override
  String get adminSupportContactSortOrder => 'ترتيب العرض';

  @override
  String get adminSupportContactActive => 'مُفعّل';

  @override
  String get adminSupportContactActiveHint =>
      'الأرقام غير المفعّلة تُخفى عن الحجاج.';

  @override
  String get adminSupportContactActiveBadge => 'مُفعّل';

  @override
  String get adminSupportContactInactiveBadge => 'مخفي';

  @override
  String get adminSupportContactSaveSuccess => 'تم حفظ الرقم';

  @override
  String get adminSupportContactCreateSuccess => 'تمت إضافة الرقم';

  @override
  String get adminSupportContactSaveError => 'تعذّر حفظ الرقم. حاول مجدداً.';

  @override
  String get adminSupportContactDeleteTitle => 'حذف الرقم';

  @override
  String adminSupportContactDeleteMessage(String label) {
    return 'حذف \"$label\"؟';
  }

  @override
  String get adminSupportContactDeleteConfirm => 'حذف';

  @override
  String get adminSupportContactDeleteSuccess => 'تم حذف الرقم';

  @override
  String get adminSupportContactDeleteError => 'تعذّر حذف الرقم';

  @override
  String get sosTitle => 'استغاثة';

  @override
  String get fieldOperatorNavSos => 'استغاثة';

  @override
  String get sosHomeButton => 'أنا تائه';

  @override
  String get sosHomeSubtitle => 'أرسل موقعك إلى فريقك';

  @override
  String get sosIntro =>
      'إذا تهت أو احتجت مساعدة عاجلة، أرسل نداء استغاثة. سيتم إشعار فريق مجموعتك والمشرفين بموقعك المباشر.';

  @override
  String get sosRaiseButton => 'إرسال نداء استغاثة';

  @override
  String get sosRaiseError => 'تعذّر إرسال النداء. حاول مجدداً.';

  @override
  String get sosLocationPermissionNeeded =>
      'إذن الموقع مطلوب لمشاركة موقعك. تم إرسال النداء بدونه.';

  @override
  String get sosActiveTitle => 'المساعدة في الطريق';

  @override
  String get sosActiveBody =>
      'تم إشعار فريقك والمشرفين. أبقِ هذه الشاشة مفتوحة لمشاركة موقعك المباشر.';

  @override
  String get sosSharingLocation => 'جارٍ مشاركة موقعك المباشر…';

  @override
  String sosLastUpdate(String time) {
    return 'آخر تحديث: $time';
  }

  @override
  String get sosLocationPending => 'جارٍ تحديد موقعك…';

  @override
  String get sosCancelButton => 'أنا بخير الآن';

  @override
  String get sosCancelConfirmTitle => 'إلغاء النداء؟';

  @override
  String get sosCancelConfirmMessage => 'سيُبلّغ فريقك بأنك بخير.';

  @override
  String get sosCancelConfirm => 'نعم، أنا بخير';

  @override
  String get sosCancelError => 'تعذّر إلغاء النداء. حاول مجدداً.';

  @override
  String get sosMonitorTitle => 'نداءات الاستغاثة';

  @override
  String get sosMonitorSubtitle =>
      'الموقع المباشر للحجاج الذين طلبوا المساعدة.';

  @override
  String get sosMonitorEmpty => 'لا توجد نداءات استغاثة نشطة.';

  @override
  String sosMonitorActiveCount(int count) {
    return '$count نشطة';
  }

  @override
  String get sosMonitorError => 'تعذّر تحميل نداءات الاستغاثة.';

  @override
  String get sosMonitorRefresh => 'تحديث';

  @override
  String get sosMonitorLive => 'مباشر';

  @override
  String get sosMonitorSelectHint => 'اضغط على نداء لتتبّعه على الخريطة.';

  @override
  String get sosUnknownPilgrim => 'حاج';

  @override
  String get sosNoGroup => 'بدون مجموعة';

  @override
  String get sosNoLocationYet => 'بانتظار الموقع…';

  @override
  String get sosOpenInMaps => 'فتح في الخرائط';

  @override
  String get sosResolveButton => 'إنهاء';

  @override
  String get sosResolveConfirmTitle => 'إنهاء هذا النداء؟';

  @override
  String sosResolveConfirmMessage(String name) {
    return 'تعليم \"$name\" بأنه وُجد وبأمان.';
  }

  @override
  String get sosResolveConfirm => 'إنهاء';

  @override
  String get sosResolvedSuccess => 'تم إنهاء النداء';

  @override
  String get sosResolveError => 'تعذّر إنهاء النداء.';

  @override
  String sosStartedAt(String time) {
    return 'منذ $time';
  }

  @override
  String get importTitle => 'استيراد الحجاج';

  @override
  String get importSubtitle => 'أضف أو حدّث الحجاج من ملف إكسل أو CSV.';

  @override
  String get importPickTitle => 'استيراد من إكسل / CSV';

  @override
  String get importPickDescription =>
      'اختر ملف ‎.xlsx أو ‎.csv. يجب أن يكون الصف الأول عناوين الأعمدة. تتم مطابقة الحجاج الحاليين برقم الجواز وتحديثهم، وإنشاء الباقي.';

  @override
  String get importPickFile => 'اختيار ملف';

  @override
  String get importMappingTitle => 'مطابقة الأعمدة';

  @override
  String get importMappingDescription =>
      'طابقنا أعمدة ملفك مع حقول الحاج. راجع وصحّح أي مطابقة غير صحيحة.';

  @override
  String get importColumnIgnore => 'تجاهل هذا العمود';

  @override
  String get importFileColumn => 'عمود الملف';

  @override
  String get importMapsTo => 'يطابق';

  @override
  String get importEmailColumnLabel => 'بريد الدخول';

  @override
  String get importPreviewTitle => 'معاينة';

  @override
  String importNewCount(int count) {
    return '$count جديد';
  }

  @override
  String importUpdateCount(int count) {
    return '$count للتحديث';
  }

  @override
  String importErrorCount(int count) {
    return '$count بها أخطاء';
  }

  @override
  String importIgnoredColumns(int count) {
    return 'تم تجاهل $count عمود';
  }

  @override
  String get importColRow => 'الصف';

  @override
  String get importColName => 'الاسم';

  @override
  String get importColAction => 'الإجراء';

  @override
  String get importColIssues => 'الملاحظات';

  @override
  String get importActionCreate => 'جديد';

  @override
  String get importActionUpdate => 'تحديث';

  @override
  String get importActionError => 'خطأ';

  @override
  String importConfirmButton(int count) {
    return 'استيراد $count حاج';
  }

  @override
  String get importCommitting => 'جارٍ الاستيراد…';

  @override
  String get importResultTitle => 'اكتمل الاستيراد';

  @override
  String importResultCreated(int count) {
    return '$count تم إنشاؤه';
  }

  @override
  String importResultUpdated(int count) {
    return '$count تم تحديثه';
  }

  @override
  String importResultFailed(int count) {
    return '$count فشل';
  }

  @override
  String get importResultErrorsTitle => 'الأخطاء';

  @override
  String get importAnother => 'استيراد ملف آخر';

  @override
  String get importChangeFile => 'اختيار ملف مختلف';

  @override
  String get importNoRows => 'لم يتم العثور على صفوف بيانات في الملف.';

  @override
  String get importNothingToImport => 'لا توجد صفوف صالحة للاستيراد.';

  @override
  String get importGenericError =>
      'تعذّر قراءة الملف. تأكد من أنه ملف إكسل أو CSV صالح.';

  @override
  String get importIssueMissingName => 'الاسم الكامل بالعربية مطلوب';

  @override
  String get importIssueInvalidDate => 'تاريخ غير صالح';

  @override
  String get importIssueInvalidGender => 'جنس غير معروف';

  @override
  String get importIssueInvalidBoolean => 'قيمة نعم/لا غير معروفة';

  @override
  String get importIssueDuplicatePassport => 'رقم جواز مكرر في الملف';

  @override
  String get exportButton => 'تصدير';

  @override
  String get exportTemplateButton => 'نموذج';

  @override
  String get exportEmpty => 'لا يوجد حجاج للتصدير.';

  @override
  String get exportDownloadStarted => 'التصدير جاهز — تحقق من التنزيلات.';

  @override
  String exportSavedTo(String path) {
    return 'تم الحفظ في $path';
  }

  @override
  String get exportFailed => 'فشل التصدير. حاول مرة أخرى.';

  @override
  String get bulkEditAction => 'تعديل جماعي';

  @override
  String bulkEditTitle(int count) {
    return 'تعديل جماعي لـ $count حاج';
  }

  @override
  String get bulkEditDescription =>
      'تتغيّر فقط الحقول التي تفعّلها. الحقول غير المفعّلة تبقى بقيمتها الحالية لكل حاج.';

  @override
  String get bulkEditEnableField => 'تحديث هذا الحقل';

  @override
  String get bulkEditNotify => 'إشعار الحجاج بالتعديلات';

  @override
  String get bulkEditNotifyHint =>
      'يصل الحجاج الذين لديهم التطبيق إشعار عند تغيير الفندق أو الرحلة أو غيرها من اللوجستيات.';

  @override
  String bulkEditApply(int count) {
    return 'تطبيق على $count حاج';
  }

  @override
  String get bulkEditNoFields => 'فعّل حقلاً واحداً على الأقل للتحديث.';

  @override
  String bulkEditSuccess(int count) {
    return 'تم تحديث $count حاج';
  }

  @override
  String get bulkEditError => 'تعذّر تطبيق التعديلات. حاول مرة أخرى.';
}
