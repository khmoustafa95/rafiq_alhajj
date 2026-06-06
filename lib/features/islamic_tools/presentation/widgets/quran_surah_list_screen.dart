import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quran/quran.dart' as quran;
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class QuranSurahListScreen extends StatelessWidget {
  const QuranSurahListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.toolsQuranTitle),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: 114,
        itemBuilder: (context, index) {
          final surahNumber = index + 1;
          final nameAr = quran.getSurahNameArabic(surahNumber);
          final nameEn = quran.getSurahName(surahNumber);
          final ayahCount = quran.getVerseCount(surahNumber);
          final displayName = isArabic ? nameAr : nameEn;
          final secondaryName = isArabic ? nameEn : nameAr;

          return ListTile(
            leading: CircleAvatar(
              child: Text('$surahNumber'),
            ),
            title: Text(
              displayName,
              textDirection:
                  isArabic ? TextDirection.rtl : TextDirection.ltr,
            ),
            subtitle: Text(
              l10n.toolsQuranSurahSubtitle(
                secondaryName,
                ayahCount,
                l10n.toolsQuranAyahs,
              ),
              textDirection:
                  isArabic ? TextDirection.ltr : TextDirection.rtl,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => unawaited(
              context.push(AppRoutes.quranSurahPath(surahNumber)),
            ),
          );
        },
      ),
    );
  }
}
