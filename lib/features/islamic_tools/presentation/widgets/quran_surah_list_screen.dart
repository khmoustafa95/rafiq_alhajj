import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quran/quran.dart' as quran;
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class QuranSurahListScreen extends StatelessWidget {
  const QuranSurahListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
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

          return ListTile(
            leading: CircleAvatar(
              child: Text('$surahNumber'),
            ),
            title: Text(nameAr, textDirection: TextDirection.rtl),
            subtitle: Text('$nameEn · $ayahCount ${l10n.toolsQuranAyahs}'),
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
