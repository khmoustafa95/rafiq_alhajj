import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/chart_slice.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/utils/chart_label_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminPieChartCard extends StatelessWidget {
  const AdminPieChartCard({
    required this.title,
    required this.slices,
    required this.l10n,
    super.key,
  });

  final String title;
  final List<ChartSlice> slices;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (slices.isEmpty) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 8.h),
              Text(l10n.adminChartEmpty),
            ],
          ),
        ),
      );
    }

    final total = slices.fold<int>(0, (sum, s) => sum + s.value);
    final palette = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.tertiary,
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.error,
    ];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8.h),
            SizedBox(
              height: 200.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 32.r,
                        sections: [
                          for (var i = 0; i < slices.length; i++)
                            PieChartSectionData(
                              value: slices[i].value.toDouble(),
                              color: palette[i % palette.length],
                              title:
                                  '${(slices[i].value / total * 100).round()}%',
                              radius: 56.r,
                              titleStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: colorScheme.onPrimary),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < slices.length; i++)
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: Row(
                              children: [
                                Container(
                                  width: 10.w,
                                  height: 10.w,
                                  color: palette[i % palette.length],
                                ),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: Text(
                                    '${chartSliceLabel(l10n, slices[i].label)} (${slices[i].value})',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
