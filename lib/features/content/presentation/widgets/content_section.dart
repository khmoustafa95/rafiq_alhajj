import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_card.dart';

enum ContentSectionLayout { compact, featured }

class ContentSection extends StatelessWidget {
  const ContentSection({
    required this.title,
    required this.items,
    required this.onItemTap,
    required this.emptyMessage,
    this.seeAllLabel,
    this.layout = ContentSectionLayout.compact,
    super.key,
  });

  final String title;
  final List<ContentItem> items;
  final void Function(ContentItem item) onItemTap;
  final String emptyMessage;
  final String? seeAllLabel;
  final ContentSectionLayout layout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              if (seeAllLabel != null && items.isNotEmpty)
                Text(
                  seeAllLabel!,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                ),
            ],
          ),
        ),
        if (items.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              emptyMessage,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        else
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final cardLayout = layout == ContentSectionLayout.featured
                ? (index == 0
                    ? ContentCardLayout.featured
                    : ContentCardLayout.horizontal)
                : ContentCardLayout.compact;

            return Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
              child: ContentCard(
                item: item,
                layout: cardLayout,
                onTap: () => onItemTap(item),
              ),
            );
          }),
      ],
    );
  }
}
