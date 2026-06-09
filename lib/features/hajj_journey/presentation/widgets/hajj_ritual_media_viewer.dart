import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HajjRitualMediaViewer extends StatefulWidget {
  const HajjRitualMediaViewer({
    required this.media,
    super.key,
  });

  final List<HajjJourneyMedia> media;

  @override
  State<HajjRitualMediaViewer> createState() => _HajjRitualMediaViewerState();
}

class _HajjRitualMediaViewerState extends State<HajjRitualMediaViewer> {
  int _selectedIndex = 0;
  int _imageIndex = 0;
  bool _slideshowActive = false;
  Timer? _slideshowTimer;
  static const _slideshowInterval = Duration(seconds: 4);

  List<HajjJourneyMedia> get _images =>
      widget.media.where((m) => m.mediaType == HajjMediaType.image).toList();

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
                  l10n.hajjJourneyNoMedia,
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

    final selected = widget.media[_selectedIndex.clamp(0, widget.media.length - 1)];

    return DecoratedBox(
      decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.hajjJourneyMediaTitle,
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
                                _mediaTypeLabel(l10n, widget.media[i].mediaType),
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

  String _mediaTypeLabel(AppLocalizations l10n, HajjMediaType type) {
    return switch (type) {
      HajjMediaType.video => l10n.hajjJourneyMediaVideo,
      HajjMediaType.audio => l10n.hajjJourneyMediaAudio,
      HajjMediaType.image => l10n.hajjJourneyMediaImage,
    };
  }
}

class _MediaContent extends StatelessWidget {
  const _MediaContent({
    required this.media,
    required this.images,
    required this.imageIndex,
    required this.slideshowActive,
    this.onImagePrev,
    this.onImageNext,
    this.onToggleSlideshow,
  });

  final HajjJourneyMedia media;
  final List<HajjJourneyMedia> images;
  final int imageIndex;
  final bool slideshowActive;
  final VoidCallback? onImagePrev;
  final VoidCallback? onImageNext;
  final VoidCallback? onToggleSlideshow;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return switch (media.mediaType) {
      HajjMediaType.video => _VideoEmbed(url: media.url),
      HajjMediaType.audio => _AudioEmbed(url: media.url, title: media.title),
      HajjMediaType.image => _ImageGallery(
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

class _AudioEmbed extends StatefulWidget {
  const _AudioEmbed({required this.url, this.title});

  final String url;
  final String? title;

  @override
  State<_AudioEmbed> createState() => _AudioEmbedState();
}

class _AudioEmbedState extends State<_AudioEmbed> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final html = '''
<!DOCTYPE html>
<html><body style="margin:0;padding:16px;font-family:sans-serif;background:#f5f5f5;">
  <p style="margin:0 0 8px;font-weight:600;">${widget.title ?? ''}</p>
  <audio controls style="width:100%;">
    <source src="${widget.url}" type="audio/mpeg">
  </audio>
</body></html>
''';
    _controller = WebViewController();
    unawaited(
      _controller.setJavaScriptMode(JavaScriptMode.unrestricted).then(
        (_) => _controller.loadHtmlString(html),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: SizedBox(
        height: 100.h,
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

  final List<HajjJourneyMedia> images;
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
            child: Image.network(
              current.url,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  return child;
                }
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (_, _, _) => ColoredBox(
                color: AppColors.surfaceMuted,
                child: Icon(Icons.broken_image_outlined, size: 48.sp),
              ),
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
                l10n.hajjJourneyImageCounter(index + 1, images.length),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              IconButton(
                onPressed: onNext,
                icon: const Icon(Icons.chevron_right_rounded),
              ),
              IconButton(
                onPressed: onToggleSlideshow,
                tooltip: slideshowActive
                    ? l10n.hajjJourneySlideshowStop
                    : l10n.hajjJourneySlideshowStart,
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
