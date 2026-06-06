import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart' as quran;
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class QuranSurahDetailScreen extends StatelessWidget {
  const QuranSurahDetailScreen({
    required this.surahNumber,
    super.key,
  });

  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final nameAr = quran.getSurahNameArabic(surahNumber);
    final nameEn = quran.getSurahName(surahNumber);
    final ayahCount = quran.getVerseCount(surahNumber);
    final primaryName = isArabic ? nameAr : nameEn;
    final secondaryName = isArabic ? nameEn : nameAr;

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(
          primaryName,
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
        itemCount: ayahCount + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    secondaryName,
                    textDirection:
                        isArabic ? TextDirection.ltr : TextDirection.rtl,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    l10n.toolsQuranSurahMeta(ayahCount),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    l10n.toolsQuranOfflineNote,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            );
          }

          final ayahNumber = index;
          final text = quran.getVerse(surahNumber, ayahNumber);

          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: RichText(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.8,
                    ),
                children: [
                  TextSpan(
                    text: '﴿$ayahNumber﴾ ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: text),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
