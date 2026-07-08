import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/widgets/native_audio_player.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:shimmer/shimmer.dart';

class ResolvedTopicImage extends ConsumerWidget {
  const ResolvedTopicImage({
    required this.media,
    required this.fit,
    this.height,
    super.key,
  });

  final EducationalMediaItem media;
  final BoxFit fit;
  final double? height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlAsync = ref.watch(
      resolvedMediaPlaybackUrlProvider(media.id, media.url),
    );

    return urlAsync.when(
      loading: () => SizedBox(
        height: height,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => _errorPlaceholder(context, height),
      data: (url) => _buildImage(context, url, height),
    );
  }

  Widget _buildImage(BuildContext context, String url, double? height) {
    final child = (!url.startsWith('http'))
        ? Image.file(
            File(url),
            fit: fit,
            errorBuilder: (_, _, _) => _errorPlaceholder(context, height),
          )
        : Image.network(
            url,
            fit: fit,
            loadingBuilder: (context, child, progress) {
              if (progress == null) {
                return child;
              }
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (_, _, _) => _errorPlaceholder(context, height),
          );

    if (height != null) {
      return SizedBox(height: height, width: double.infinity, child: child);
    }
    return child;
  }

  Widget _errorPlaceholder(BuildContext context, double? height) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ColoredBox(
        color: colorScheme.surfaceContainerHighest,
        child: Icon(Icons.broken_image_outlined, size: 48.sp),
      ),
    );
  }
}

class ContentTopicsSectionSkeleton extends StatelessWidget {
  const ContentTopicsSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: colorScheme.surfaceContainerHigh,
      highlightColor: colorScheme.surfaceContainerHighest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 22.h,
              width: 160.w,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 230.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (_, _) => SizedBox(width: 12.w),
              itemBuilder: (_, _) => Container(
                width: 260.w,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

class ResolvedAudioPlayer extends ConsumerWidget {
  const ResolvedAudioPlayer({
    required this.media,
    super.key,
  });

  final EducationalMediaItem media;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlAsync = ref.watch(
      resolvedMediaPlaybackUrlProvider(media.id, media.url),
    );

    return urlAsync.when(
      loading: () => SizedBox(
        height: 100.h,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => NativeAudioPlayer(url: media.url, title: media.title),
      data: (url) => NativeAudioPlayer(url: url, title: media.title),
    );
  }
}
