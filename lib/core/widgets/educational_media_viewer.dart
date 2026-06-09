import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_media_widgets.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EducationalMediaViewer extends StatefulWidget {
  const EducationalMediaViewer({
    required this.media,
    this.sectionTitle,
    this.emptyMessage,
    super.key,
  });

  final List<EducationalMediaItem> media;
  final String? sectionTitle;
  final String? emptyMessage;

  @override
  State<EducationalMediaViewer> createState() => _EducationalMediaViewerState();
}

class _EducationalMediaViewerState extends State<EducationalMediaViewer> {
  int _selectedIndex = 0;
  int _imageIndex = 0;
  bool _slideshowActive = false;
  Timer? _slideshowTimer;
  static const _slideshowInterval = Duration(seconds: 4);

  List<EducationalMediaItem> get _images => widget.media
      .where((m) => m.mediaType == EducationalMediaType.image)
      .toList();

  @override
  void dispose() {
    _stopSlideshow();
    super.dispose();
  }

  void _stopSlideshow() {
    _slideshowTimer?.cancel();
    _slideshowTimer = null;
    _slideshowActive = false;
  }

  void _toggleSlideshow() {
    if (_images.length < 2) {
      return;
    }

    if (_slideshowActive) {
      _stopSlideshow();
    } else {
      _slideshowActive = true;
      _slideshowTimer = Timer.periodic(_slideshowInterval, (_) {
        if (!mounted) {
          return;
        }
        setState(() {
          _imageIndex = (_imageIndex + 1) % _images.length;
        });
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (widget.media.isEmpty) {
      return DecoratedBox(
        decoration: AppDecorations.card(color: AppColors.surfaceMuted),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              const Icon(Icons.perm_media_outlined, color: AppColors.textSecondary),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  widget.emptyMessage ?? l10n.educationalMediaEmpty,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final selected =
        widget.media[_selectedIndex.clamp(0, widget.media.length - 1)];

    return DecoratedBox(
      decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.sectionTitle ?? l10n.educationalMediaTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            SizedBox(height: 12.h),
            if (widget.media.length > 1)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < widget.media.length; i++)
                      Padding(
                        padding: EdgeInsetsDirectional.only(end: 8.w),
                        child: ChoiceChip(
                          label: Text(
                            widget.media[i].title ??
                                _mediaTypeLabel(
                                  l10n,
                                  widget.media[i].mediaType,
                                ),
                          ),
                          selected: _selectedIndex == i,
                          onSelected: (_) {
                            _stopSlideshow();
                            setState(() => _selectedIndex = i);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            SizedBox(height: 12.h),
            _MediaContent(
              media: selected,
              images: _images,
              imageIndex: _imageIndex,
              slideshowActive: _slideshowActive,
              onImagePrev: _images.length > 1
                  ? () {
                      _stopSlideshow();
                      setState(() {
                        _imageIndex =
                            (_imageIndex - 1 + _images.length) % _images.length;
                      });
                    }
                  : null,
              onImageNext: _images.length > 1
                  ? () {
                      _stopSlideshow();
                      setState(() {
                        _imageIndex = (_imageIndex + 1) % _images.length;
                      });
                    }
                  : null,
              onToggleSlideshow: _images.length > 1 ? _toggleSlideshow : null,
            ),
          ],
        ),
      ),
    );
  }

  String _mediaTypeLabel(AppLocalizations l10n, EducationalMediaType type) {
    return switch (type) {
      EducationalMediaType.video => l10n.educationalMediaVideo,
      EducationalMediaType.audio => l10n.educationalMediaAudio,
      EducationalMediaType.image => l10n.educationalMediaImage,
    };
  }
}

class _MediaContent extends ConsumerWidget {
  const _MediaContent({
    required this.media,
    required this.images,
    required this.imageIndex,
    required this.slideshowActive,
    this.onImagePrev,
    this.onImageNext,
    this.onToggleSlideshow,
  });

  final EducationalMediaItem media;
  final List<EducationalMediaItem> images;
  final int imageIndex;
  final bool slideshowActive;
  final VoidCallback? onImagePrev;
  final VoidCallback? onImageNext;
  final VoidCallback? onToggleSlideshow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return switch (media.mediaType) {
      EducationalMediaType.video => _ResolvedVideoEmbed(media: media),
      EducationalMediaType.audio => ResolvedAudioPlayer(media: media),
      EducationalMediaType.image => _ImageGallery(
          images: images.isEmpty ? [media] : images,
          index: images.isEmpty ? 0 : imageIndex,
          slideshowActive: slideshowActive,
          onPrev: onImagePrev,
          onNext: onImageNext,
          onToggleSlideshow: onToggleSlideshow,
          l10n: l10n,
        ),
    };
  }
}

class _ResolvedVideoEmbed extends ConsumerWidget {
  const _ResolvedVideoEmbed({required this.media});

  final EducationalMediaItem media;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlAsync = ref.watch(
      resolvedMediaPlaybackUrlProvider(media.id, media.url),
    );

    return urlAsync.when(
      loading: () => SizedBox(
        height: 200.h,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => _VideoEmbed(url: media.url),
      data: (url) => _VideoEmbed(url: url),
    );
  }
}

class _VideoEmbed extends StatefulWidget {
  const _VideoEmbed({required this.url});

  final String url;

  @override
  State<_VideoEmbed> createState() => _VideoEmbedState();
}

class _VideoEmbedState extends State<_VideoEmbed> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final embedUrl = _toEmbedUrl(widget.url);
    _controller = WebViewController();
    unawaited(
      _controller.setJavaScriptMode(JavaScriptMode.unrestricted).then(
        (_) => _controller.loadRequest(Uri.parse(embedUrl)),
      ),
    );
  }

  String _toEmbedUrl(String url) {
    if (!url.startsWith('http')) {
      return Uri.file(url).toString();
    }
    if (url.contains('youtube.com/embed')) {
      return url;
    }
    if (url.contains('youtu.be/')) {
      final id = url.split('youtu.be/').last.split('?').first;
      return 'https://www.youtube.com/embed/$id';
    }
    if (url.contains('watch?v=')) {
      final id = Uri.parse(url).queryParameters['v'];
      if (id != null) {
        return 'https://www.youtube.com/embed/$id';
      }
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: SizedBox(
        height: 200.h,
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  const _ImageGallery({
    required this.images,
    required this.index,
    required this.slideshowActive,
    required this.l10n,
    this.onPrev,
    this.onNext,
    this.onToggleSlideshow,
  });

  final List<EducationalMediaItem> images;
  final int index;
  final bool slideshowActive;
  final AppLocalizations l10n;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final VoidCallback? onToggleSlideshow;

  @override
  Widget build(BuildContext context) {
    final current = images[index.clamp(0, images.length - 1)];

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: ResolvedTopicImage(
              media: current,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (images.length > 1) ...[
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onPrev,
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              Text(
                l10n.educationalMediaImageCounter(index + 1, images.length),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              IconButton(
                onPressed: onNext,
                icon: const Icon(Icons.chevron_right_rounded),
              ),
              IconButton(
                onPressed: onToggleSlideshow,
                tooltip: slideshowActive
                    ? l10n.educationalMediaSlideshowStop
                    : l10n.educationalMediaSlideshowStart,
                icon: Icon(
                  slideshowActive
                      ? Icons.pause_circle_outline
                      : Icons.slideshow_outlined,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
