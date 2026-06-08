import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
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
          padding: EdgeInsets.all(sw(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: sh(8)),
              Text(l10n.adminChartEmpty),
            ],
          ),
        ),
      );
    }

    final maxValue = slices.map((s) => s.value).reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(sw(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: sh(16)),
            SizedBox(
              height: sh(220),
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
                            width: sw(20),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(sr(4)),
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
                            padding: EdgeInsets.only(top: sh(8)),
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
