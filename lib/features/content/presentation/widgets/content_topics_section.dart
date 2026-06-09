import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/widgets/section_header.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_topic_card.dart';

class ContentTopicsSection extends StatelessWidget {
  const ContentTopicsSection({
    required this.title,
    required this.topics,
    required this.onTopicTap,
    required this.emptyMessage,
    this.seeAllLabel,
    this.onSeeAll,
    this.maxItems,
    super.key,
  });

  final String title;
  final List<ContentTopic> topics;
  final void Function(ContentTopic topic) onTopicTap;
  final String emptyMessage;
  final String? seeAllLabel;
  final VoidCallback? onSeeAll;
  final int? maxItems;

  @override
  Widget build(BuildContext context) {
    final limit = maxItems ?? topics.length;
    final visibleTopics = topics.take(limit).toList();
    final hasMore = topics.length > visibleTopics.length;
    final textScale = MediaQuery.textScalerOf(context).scale(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          seeAllLabel: hasMore ? seeAllLabel : null,
          onSeeAll: hasMore ? onSeeAll : null,
        ),
        if (visibleTopics.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              emptyMessage,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        else if (visibleTopics.length == 1)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ContentTopicCard(
              topic: visibleTopics.first,
              layout: ContentTopicCardLayout.featured,
              onTap: () => onTopicTap(visibleTopics.first),
            ),
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final listHeight = math.max(
                220.h,
                (130.h + 88.h * textScale).clamp(220.h, 300.h),
              );

              return SizedBox(
                height: listHeight,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: visibleTopics.length,
                  separatorBuilder: (_, _) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    final topic = visibleTopics[index];
                    final cardWidth = math.min(
                      280.w,
                      constraints.maxWidth * 0.78,
                    );
                    return SizedBox(
                      width: cardWidth,
                      child: ContentTopicCard(
                        topic: topic,
                        onTap: () => onTopicTap(topic),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
