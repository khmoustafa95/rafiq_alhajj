/// Bundled Hajj ritual steps (offline, US-04).
class RitualStepDefinition {
  const RitualStepDefinition({
    required this.key,
    required this.titleAr,
    required this.titleEn,
    required this.order,
  });

  final String key;
  final String titleAr;
  final String titleEn;
  final int order;
}

abstract final class HajjRitualSteps {
  static const List<RitualStepDefinition> all = [
    RitualStepDefinition(
      key: 'ihram',
      titleAr: 'الإحرام',
      titleEn: 'Ihram',
      order: 1,
    ),
    RitualStepDefinition(
      key: 'tawaf',
      titleAr: 'الطواف',
      titleEn: 'Tawaf',
      order: 2,
    ),
    RitualStepDefinition(
      key: 'sai',
      titleAr: 'السعي',
      titleEn: "Sa'i",
      order: 3,
    ),
    RitualStepDefinition(
      key: 'mina',
      titleAr: 'اليوم في منى',
      titleEn: 'Day at Mina',
      order: 4,
    ),
    RitualStepDefinition(
      key: 'arafat',
      titleAr: 'الوقوف بعرفة',
      titleEn: 'Standing at Arafat',
      order: 5,
    ),
    RitualStepDefinition(
      key: 'muzdalifah',
      titleAr: 'المبيت بمزدلفة',
      titleEn: 'Muzdalifah',
      order: 6,
    ),
    RitualStepDefinition(
      key: 'ramy',
      titleAr: 'رمي الجمرات',
      titleEn: 'Stoning the Jamarat',
      order: 7,
    ),
    RitualStepDefinition(
      key: 'hady',
      titleAr: 'الهدي',
      titleEn: 'Sacrifice (Hady)',
      order: 8,
    ),
    RitualStepDefinition(
      key: 'halq',
      titleAr: 'الحلق أو التقصير',
      titleEn: 'Halq or Taqsir',
      order: 9,
    ),
    RitualStepDefinition(
      key: 'farewell_tawaf',
      titleAr: 'طواف الوداع',
      titleEn: 'Farewell Tawaf',
      order: 10,
    ),
  ];
}
