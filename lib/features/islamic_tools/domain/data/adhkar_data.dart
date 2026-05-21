import 'package:rafiq_alhajj/features/islamic_tools/domain/models/adhkar_entry.dart';

/// Offline adhkar bundled in the app (US-02).
abstract final class AdhkarData {
  static const List<AdhkarEntry> morning = [
    AdhkarEntry(
      titleAr: 'آية الكرسي',
      titleEn: 'Ayat al-Kursi',
      textAr:
          'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ...',
      repeatCount: 1,
    ),
    AdhkarEntry(
      titleAr: 'سورة الإخلاص والمعوذتين',
      titleEn: 'Al-Ikhlas & Al-Mu\'awwidhatayn',
      textAr:
          'قُلْ هُوَ اللَّهُ أَحَدٌ ... قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ... قُلْ أَعُوذُ بِرَبِّ النَّاسِ',
      repeatCount: 3,
    ),
    AdhkarEntry(
      titleAr: 'سبحان الله وبحمده',
      titleEn: 'Subhan Allah wa bihamdihi',
      textAr: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
      repeatCount: 100,
    ),
  ];

  static const List<AdhkarEntry> evening = [
    AdhkarEntry(
      titleAr: 'أمسينا وأمسى الملك لله',
      titleEn: 'Evening remembrance',
      textAr:
          'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ',
      repeatCount: 1,
    ),
    AdhkarEntry(
      titleAr: 'اللهم بك أمسينا',
      titleEn: 'Allahumma bika amsayna',
      textAr:
          'اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ الْمَصِيرُ',
      repeatCount: 1,
    ),
  ];
}
