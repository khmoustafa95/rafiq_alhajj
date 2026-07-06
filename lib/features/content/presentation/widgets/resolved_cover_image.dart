import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      loading: () => _placeholder(context, height),
      error: (_, _) => _placeholder(context, height),
      data: (url) => _buildImage(context, url, height),
    );

    if (borderRadius != null) {
      child = ClipRRect(borderRadius: borderRadius!, child: child);
    }
    return child;
  }

  int? _cacheWidth(BuildContext context, double? height) {
    if (height == null) {
      return null;
    }
    return (height * MediaQuery.devicePixelRatioOf(context)).round();
  }

  Widget _buildImage(BuildContext context, String url, double? height) {
    final cacheWidth = _cacheWidth(context, height);
    final image = (!url.startsWith('http'))
        ? Image.file(
            File(url),
            fit: fit,
            cacheWidth: cacheWidth,
            errorBuilder: (_, _, _) => _placeholder(context, height),
          )
        : Image.network(
            url,
            fit: fit,
            cacheWidth: cacheWidth,
            loadingBuilder: (context, child, progress) =>
                progress == null ? child : _placeholder(context, height),
            errorBuilder: (_, _, _) => _placeholder(context, height),
          );

    if (height != null) {
      return SizedBox(height: height, width: double.infinity, child: image);
    }
    return image;
  }

  Widget _placeholder(BuildContext context, double? height) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ColoredBox(
        color: colorScheme.surfaceContainerHighest,
        child: Icon(
          Icons.image_outlined,
          size: 40.sp,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
