import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';

class NotificationInboxGroupHeader extends StatelessWidget {
  const NotificationInboxGroupHeader({
    required this.label,
    required this.count,
    super.key,
  });

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw(4)),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
              fontSize: ss(13),
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(width: sw(8)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: sw(7), vertical: sh(1)),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(sr(20)),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
                fontSize: ss(11),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
