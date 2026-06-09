import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/ritual_step_definition.dart';

/// Offline fallback when Supabase CMS is unavailable.
abstract final class HajjJourneyFallbackData {
  static const _descriptionsAr = <String, String>{
    'ihram':
        'الإحرام هو نية الدخول في النسك وتجسيدها بلباس مخصص للرجال واجتناب محظورات الإحرام. يبدأ الإحرام من الميقات أو قبله، ويستحب التلبية: لبيك اللهم لبيك.',
    'tawaf':
        'الطواف هو الدوران حول الكعبة المشرفة سبعة أشواط، يبدأ من الحجر الأسود وينتهي عنده. يستحب استلام الحجر أو الإشارة إليه في كل شوط إن أمكن.',
    'sai':
        'السعي بين الصفا والمروة سبعة أشواط، يبدأ من الصفا وينتهي عند المروة. يستحب الركض بين العلمين الأخضرين للرجال.',
    'mina':
        'يوم التروية هو اليوم الثامن من ذي الحجة، يقضيه الحاج في منى ويستعد للوقوف بعرفة في اليوم التاسع.',
    'arafat':
        'الوقوف بعرفة ركن الحج الأعظم، وهو اليوم التاسع من ذي الحجة من زوال الشمس إلى غروبها. قال النبي ﷺ: «الحج عرفة».',
    'muzdalifah':
        'بعد غروب شمس يوم عرفة ينفر الحاج إلى مزدلفة ويصلي المغرب والعشاء جمعاً وقصراً، ويبيت بها حتى الفجر.',
    'ramy':
        'رمي الجمرات بسبع حصيات لكل جمرة في أيام التشريق، يبدأ بالجمرة الصغرى ثم الوسطى ثم الكبرى.',
    'hady':
        'الهدي هو ذبح البدنة أو البقرة أو الشاة في يوم العيد وأيام التشريق، وهو واجب على القارن والمفرد.',
    'halq':
        'الحلق أو التقصير يحرر الحاج من محظورات الإحرام بعد رمي جمرة العقبة يوم العيد.',
    'farewell_tawaf':
        'طواف الوداع آخر ما يفعله الحاج قبل مغادرة مكة، وهو واجب على من أراد الخروج من مكة بعد إتمام المناسك.',
  };

  static const _descriptionsEn = <String, String>{
    'ihram':
        'Ihram is the intention to enter Hajj or Umrah, marked by special dress and avoiding ihram prohibitions. It begins at the miqat.',
    'tawaf':
        'Tawaf is circling the Kaaba seven times, beginning and ending at the Black Stone.',
    'sai':
        "Sa'i is walking between Safa and Marwa seven times. Men jog between the green markers.",
    'mina':
        'Yawm al-Tarwiyah is the 8th of Dhul Hijjah spent in Mina, preparing for Arafat.',
    'arafat':
        'Standing at Arafat is the greatest pillar of Hajj on the 9th of Dhul Hijjah until sunset.',
    'muzdalifah':
        'After Arafat, pilgrims proceed to Muzdalifah, pray Maghrib and Isha combined, and stay until Fajr.',
    'ramy':
        'Stoning the Jamarat with seven pebbles per pillar during the days of Tashriq.',
    'hady':
        'Hady is sacrificing an animal on Eid and the days of Tashriq for Qiran and Ifrad pilgrims.',
    'halq':
        'Halq or taqsir releases the pilgrim from ihram after stoning Jamrat al-Aqaba on Eid.',
    'farewell_tawaf':
        'The farewell tawaf is the last act before leaving Makkah after completing the rites.',
  };

  static List<HajjJourneyStep> steps() {
    return HajjRitualSteps.all.map((def) {
      return HajjJourneyStep(
        id: def.key,
        ritualKey: def.key,
        sortOrder: def.order,
        titleAr: def.titleAr,
        titleEn: def.titleEn,
        descriptionAr: _descriptionsAr[def.key] ?? def.titleAr,
        descriptionEn: _descriptionsEn[def.key] ?? def.titleEn,
        media: [],
      );
    }).toList();
  }
}
