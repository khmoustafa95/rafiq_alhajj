import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_card.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({
    required this.title,
    required this.items,
    required this.onItemTap,
    required this.emptyMessage,
    super.key,
  });

  final String title;
  final List<ContentItem> items;
  final void Function(ContentItem item) onItemTap;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        if (items.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              emptyMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          )
        else
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: ContentCard(
                item: item,
                onTap: () => onItemTap(item),
              ),
            ),
          ),
      ],
    );
  }
}
