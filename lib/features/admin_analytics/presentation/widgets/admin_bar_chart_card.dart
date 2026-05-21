import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/chart_slice.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/utils/chart_label_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminBarChartCard extends StatelessWidget {
  const AdminBarChartCard({
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

    final maxValue = slices.map((s) => s.value).reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 16.h),
            SizedBox(
              height: 220.h,
              child: BarChart(
                BarChartData(
                  maxY: maxValue.toDouble() + 1,
                  barGroups: [
                    for (var i = 0; i < slices.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: slices[i].value.toDouble(),
                            color: colorScheme.primary,
                            width: 20.w,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(4.r),
                            ),
                          ),
                        ],
                      ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= slices.length) {
                            return const SizedBox.shrink();
                          }
                          final label = chartSliceLabel(
                            l10n,
                            slices[index].label,
                          );
                          return Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              label.length > 10
                                  ? '${label.substring(0, 10)}…'
                                  : label,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
