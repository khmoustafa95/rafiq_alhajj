import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/data/adhkar_data.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/models/adhkar_entry.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdhkarScreen extends StatelessWidget {
  const AdhkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.toolsAdhkarTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.toolsAdhkarMorning),
              Tab(text: l10n.toolsAdhkarEvening),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _AdhkarList(
              entries: AdhkarData.morning,
              isArabic: isArabic,
              repeatLabel: l10n.toolsAdhkarRepeat,
            ),
            _AdhkarList(
              entries: AdhkarData.evening,
              isArabic: isArabic,
              repeatLabel: l10n.toolsAdhkarRepeat,
            ),
          ],
        ),
      ),
    );
  }
}

class _AdhkarList extends StatelessWidget {
  const _AdhkarList({
    required this.entries,
    required this.isArabic,
    required this.repeatLabel,
  });

  final List<AdhkarEntry> entries;
  final bool isArabic;
  final String repeatLabel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16.w),
      itemCount: entries.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Card(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isArabic ? entry.titleAr : entry.titleEn,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 8.h),
                Text(
                  entry.textAr,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                      ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '$repeatLabel: ${entry.repeatCount}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
