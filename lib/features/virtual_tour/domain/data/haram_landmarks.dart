import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class HaramLandmark {
  const HaramLandmark({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.summaryAr,
    required this.summaryEn,
    required this.ritualAr,
    required this.ritualEn,
    required this.stepsAr,
    required this.stepsEn,
    required this.tipsAr,
    required this.tipsEn,
    required this.location,
    required this.icon,
    required this.color,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String summaryAr;
  final String summaryEn;
  final String ritualAr;
  final String ritualEn;
  final List<String> stepsAr;
  final List<String> stepsEn;
  final List<String> tipsAr;
  final List<String> tipsEn;
  final LatLng location;
  final IconData icon;
  final Color color;

  String titleFor(String languageCode) =>
      languageCode == 'ar' ? titleAr : titleEn;

  String summaryFor(String languageCode) =>
      languageCode == 'ar' ? summaryAr : summaryEn;

  String ritualFor(String languageCode) =>
      languageCode == 'ar' ? ritualAr : ritualEn;

  List<String> stepsFor(String languageCode) =>
      languageCode == 'ar' ? stepsAr : stepsEn;

  List<String> tipsFor(String languageCode) =>
      languageCode == 'ar' ? tipsAr : tipsEn;
}

/// Kaaba coordinates — OpenStreetMap / Wikimedia.
const kaabaLatLng = LatLng(21.422487, 39.826206);

const haramLandmarks = [
  HaramLandmark(
    id: 'kaaba',
    titleAr: 'الكعبة المشرفة',
    titleEn: 'The Holy Kaaba',
    summaryAr:
        'قبلة المسلمين وقلب المسجد الحرام. يستحب استحضار عظمة البيت وتواضع النفس عند الاقتراب.',
    summaryEn:
        'The qibla of Muslims and the heart of Al-Masjid al-Haram. Approach with humility and presence of heart.',
    ritualAr: 'الطواف',
    ritualEn: 'Tawaf',
    stepsAr: [
      'استأذن الدخول واضبط نيتك للطواف.',
      'ابدأ من الحجر الأسود إن تيسر (استلام أو إشارة).',
      'طُف حول الكعبة سبعة أشواط باتجاه عقارب الساعة.',
      'صلّ ركعتين خلف مقام إبراهيم إن أمكن.',
    ],
    stepsEn: [
      'Enter with intention for tawaf.',
      'Begin at the Black Stone if possible (kiss or gesture).',
      'Circle the Kaaba seven times counter-clockwise.',
      'Pray two rak\'ahs behind Maqam Ibrahim if possible.',
    ],
    tipsAr: [
      'تجنّب أوقات الذروة إن استطعت.',
      'احترم ازدحام الحجاج ولا تدفع.',
      'اشرب ماءً وخذ فترات راحة قصيرة.',
    ],
    tipsEn: [
      'Avoid peak crowd times when possible.',
      'Respect fellow pilgrims — do not push.',
      'Stay hydrated and take short breaks.',
    ],
    location: kaabaLatLng,
    icon: Icons.mosque_rounded,
    color: Color(0xFF065F46),
  ),
  HaramLandmark(
    id: 'tawaf',
    titleAr: 'المطاف',
    titleEn: 'Mataaf (Tawaf area)',
    summaryAr:
        'الساحة المحيطة بالكعبة حيث يُؤدّى الطواف. المسار دائري حول البيت.',
    summaryEn:
        'The courtyard around the Kaaba where tawaf is performed — a circular path.',
    ritualAr: 'الطواف',
    ritualEn: 'Tawaf',
    stepsAr: [
      'حافظ على اتجاه واحد (مع عقارب الساعة).',
      'أكمل سبعة أشواط متصلة دون انقطاع إن أمكن.',
      'الدعاء والذكر في كل شوط مستحب.',
    ],
    stepsEn: [
      'Keep one direction (counter-clockwise).',
      'Complete seven continuous circuits when possible.',
      'Du\'a and dhikr each circuit are recommended.',
    ],
    tipsAr: [
      'إن شعرت بدوخة توقّف جانباً ثم أكمل.',
      'اتبع تعليمات مرشدي مركزك في الازدحام.',
    ],
    tipsEn: [
      'If dizzy, step aside and resume when ready.',
      'Follow your center guides in heavy crowds.',
    ],
    location: LatLng(21.42265, 39.82645),
    icon: Icons.loop_rounded,
    color: Color(0xFFD4AF37),
  ),
  HaramLandmark(
    id: 'safa',
    titleAr: 'الصفا',
    titleEn: 'Safa',
    summaryAr: 'جبل الصفا — بداية السعي منه في الشوط الأول.',
    summaryEn: 'Mount Safa — the starting point of sa\'i for the first lap.',
    ritualAr: 'السعي',
    ritualEn: "Sa'i",
    stepsAr: [
      'اصعد أو اقترب من الصفا واستحضر دعاء البدء.',
      'اتجه نحو المروة في الشوط الأول.',
      'سبعة أشواط كاملة بين الصفا والمروة.',
    ],
    stepsEn: [
      'Ascend or approach Safa with the opening du\'a.',
      'Walk toward Marwah on the first lap.',
      'Complete seven full laps between Safa and Marwah.',
    ],
    tipsAr: [
      'المنطقة مكيّفة ومؤشّرة — اتبع اللوحات.',
      'الهرولة في المسافة الخضراء للرجال عند القدرة.',
    ],
    tipsEn: [
      'The area is marked and air-conditioned — follow signs.',
      'Men may jog the green-lit section when able.',
    ],
    location: LatLng(21.42295, 39.82738),
    icon: Icons.directions_walk_rounded,
    color: Color(0xFF312E81),
  ),
  HaramLandmark(
    id: 'marwah',
    titleAr: 'المروة',
    titleEn: 'Marwah',
    summaryAr: 'جبل المروة — نهاية كل شوط والعودة إلى الصفا.',
    summaryEn: 'Mount Marwah — end of each lap before returning to Safa.',
    ritualAr: 'السعي',
    ritualEn: "Sa'i",
    stepsAr: [
      'عند المروة استرح قليلاً إن احتجت.',
      'ارجع إلى الصفا لبدء الشوط التالي.',
      'يُكمل السعي عند الشوط السابع عند المروة.',
    ],
    stepsEn: [
      'Pause briefly at Marwah if needed.',
      'Return to Safa to begin the next lap.',
      'The seventh lap ends at Marwah.',
    ],
    tipsAr: [
      'احمل ماءً معك.',
      'لا تتعجل — السعي عبادة لا سباق.',
    ],
    tipsEn: [
      'Carry water with you.',
      'Do not rush — sa\'i is worship, not a race.',
    ],
    location: LatLng(21.42272, 39.82852),
    icon: Icons.directions_run_rounded,
    color: Color(0xFF14B8A6),
  ),
  HaramLandmark(
    id: 'zamzam',
    titleAr: 'زمزم',
    titleEn: 'Zamzam',
    summaryAr: 'ماء زمزم المبارك — يُستحب الشرب والدعاء عند الشرب.',
    summaryEn: 'Blessed Zamzam water — drink and make du\'a when drinking.',
    ritualAr: 'عام',
    ritualEn: 'General',
    stepsAr: [
      'توجّه لمنطقة توزيع زمزم المحددة.',
      'اشرب وارفع رأسك بين الرشفات.',
      'ادعُ بما شئت بعد الشرب.',
    ],
    stepsEn: [
      'Go to the designated Zamzam distribution area.',
      'Drink and pause between sips.',
      'Make du\'a after drinking.',
    ],
    tipsAr: [
      'لا تُراقب الماء عند الشرب.',
      'احترم الطوابير واترك مكاناً للآخرين.',
    ],
    tipsEn: [
      'Do not drink while standing (per common guidance).',
      'Respect queues and leave space for others.',
    ],
    location: LatLng(21.42235, 39.82655),
    icon: Icons.water_drop_rounded,
    color: Color(0xFF3B82F6),
  ),
];
