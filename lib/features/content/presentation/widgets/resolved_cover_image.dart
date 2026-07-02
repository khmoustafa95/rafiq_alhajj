import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';

/// Cover image that resolves through the offline media cache when available.
class ResolvedCoverImage extends ConsumerWidget {
  const ResolvedCoverImage({
    required this.cacheMediaId,
    required this.remoteUrl,
    required this.fit,
    this.height,
    this.borderRadius,
    super.key,
  });

  final String cacheMediaId;
  final String remoteUrl;
  final BoxFit fit;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlAsync = ref.watch(
      resolvedMediaPlaybackUrlProvider(cacheMediaId, remoteUrl),
    );

    Widget child = urlAsync.when(
      loading: () => _placeholder(height),
      error: (_, _) => _placeholder(height),
      data: (url) => _buildImage(url, height),
    );

    if (borderRadius != null) {
      child = ClipRRect(borderRadius: borderRadius!, child: child);
    }
    return child;
  }

  Widget _buildImage(String url, double? height) {
    final image = (!url.startsWith('http'))
        ? Image.file(
            File(url),
            fit: fit,
            errorBuilder: (_, _, _) => _placeholder(height),
          )
        : Image.network(
            url,
            fit: fit,
            loadingBuilder: (context, child, progress) =>
                progress == null ? child : _placeholder(height),
            errorBuilder: (_, _, _) => _placeholder(height),
          );

    if (height != null) {
      return SizedBox(height: height, width: double.infinity, child: image);
    }
    return image;
  }

  Widget _placeholder(double? height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ColoredBox(
        color: AppColors.surfaceMuted,
        child: Icon(Icons.image_outlined, size: 40.sp),
      ),
    );
  }
}
