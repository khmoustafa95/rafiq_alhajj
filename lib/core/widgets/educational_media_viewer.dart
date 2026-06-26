import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdfx/pdfx.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_media_widgets.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// YouTube/Vimeo links are played via their web embeds; everything else
/// (direct/signed MP4 or a decrypted local file) uses the native player.
bool _isExternalVideo(String url) {
  final lower = url.toLowerCase();
  return lower.contains('youtube.com') ||
      lower.contains('youtu.be') ||
      lower.contains('vimeo.com');
}

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

  List<EducationalMediaItem> get _images => widget.media
      .where((m) => m.mediaType == EducationalMediaType.image)
      .toList();

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
      EducationalMediaType.pdf => l10n.contentMediaPdf,
    };
  }
}

class _MediaContent extends ConsumerWidget {
  const _MediaContent({
    required this.media,
    required this.images,
  });

  final EducationalMediaItem media;
  final List<EducationalMediaItem> images;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return switch (media.mediaType) {
      EducationalMediaType.video => _ResolvedVideoEmbed(media: media),
      EducationalMediaType.audio => ResolvedAudioPlayer(media: media),
      EducationalMediaType.pdf => _PdfMedia(media: media),
      EducationalMediaType.image => _StoriesGallery(
          images: images.isEmpty ? [media] : images,
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
    // YouTube/Vimeo embeds keep using the WebView player and never get cached.
    if (_isExternalVideo(media.url)) {
      return _VideoEmbed(url: media.url);
    }

    final urlAsync = ref.watch(
      resolvedMediaPlaybackUrlProvider(media.id, media.url),
    );

    return urlAsync.when(
      loading: () => SizedBox(
        height: 200.h,
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => _NativeVideoPlayer(source: media.url),
      data: (url) => _NativeVideoPlayer(source: url),
    );
  }
}

/// Native player (controls / seek / fullscreen) for a local decrypted file or a
/// direct/signed MP4 URL.
class _NativeVideoPlayer extends StatefulWidget {
  const _NativeVideoPlayer({required this.source});

  final String source;

  @override
  State<_NativeVideoPlayer> createState() => _NativeVideoPlayerState();
}

class _NativeVideoPlayerState extends State<_NativeVideoPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _initialized = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_setUp());
  }

  @override
  void didUpdateWidget(covariant _NativeVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source != widget.source) {
      _disposeControllers();
      _initialized = false;
      _error = null;
      unawaited(_setUp());
    }
  }

  Future<void> _setUp() async {
    try {
      final source = widget.source;
      final controller = source.startsWith('http')
          ? VideoPlayerController.networkUrl(Uri.parse(source))
          : VideoPlayerController.file(File(source));
      _videoController = controller;
      await controller.initialize();
      if (!mounted) {
        return;
      }
      _chewieController = ChewieController(
        videoPlayerController: controller,
        aspectRatio: controller.value.aspectRatio == 0
            ? 16 / 9
            : controller.value.aspectRatio,
      );
      setState(() => _initialized = true);
    } catch (e) {
      if (mounted) {
        setState(() => _error = e);
      }
    }
  }

  void _disposeControllers() {
    _chewieController?.dispose();
    _chewieController = null;
    unawaited(_videoController?.dispose());
    _videoController = null;
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_error != null) {
      return SizedBox(
        height: 200.h,
        child: ColoredBox(
          color: AppColors.surfaceMuted,
          child: Center(
            child: Text(
              l10n.educationalMediaVideoError,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ),
      );
    }
    if (!_initialized || _chewieController == null) {
      return SizedBox(
        height: 200.h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: AspectRatio(
        aspectRatio: _chewieController!.aspectRatio ?? 16 / 9,
        child: Chewie(controller: _chewieController!),
      ),
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
    if (url.contains('vimeo.com/')) {
      if (url.contains('player.vimeo.com')) {
        return url;
      }
      final id = RegExp(r'vimeo\.com/(?:video/)?(\d+)').firstMatch(url)?.group(1);
      if (id != null) {
        return 'https://player.vimeo.com/video/$id';
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

/// Resolves a PDF source (decrypted local file or signed/public URL) and
/// renders a paged viewer via `pdfx`.
class _PdfMedia extends ConsumerWidget {
  const _PdfMedia({required this.media});

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
      error: (_, _) => _PdfViewer(source: media.url),
      data: (url) => _PdfViewer(source: url),
    );
  }
}

class _PdfViewer extends StatefulWidget {
  const _PdfViewer({required this.source});

  final String source;

  @override
  State<_PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<_PdfViewer> {
  PdfController? _controller;
  Object? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  @override
  void didUpdateWidget(covariant _PdfViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source != widget.source) {
      _controller?.dispose();
      _controller = null;
      _error = null;
      unawaited(_load());
    }
  }

  Future<void> _load() async {
    try {
      final source = widget.source;
      // Local decrypted files use openFile; remote/signed URLs are fetched as
      // bytes (also the only path that works on web).
      final Future<PdfDocument> document;
      if (source.startsWith('http')) {
        final response = await Dio().get<List<int>>(
          source,
          options: Options(responseType: ResponseType.bytes),
        );
        document = PdfDocument.openData(
          Uint8List.fromList(response.data ?? const []),
        );
      } else {
        document = PdfDocument.openFile(source);
      }
      final controller = PdfController(document: document);
      if (!mounted) {
        controller.dispose();
        return;
      }
      setState(() => _controller = controller);
    } catch (e) {
      if (mounted) {
        setState(() => _error = e);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_error != null) {
      return SizedBox(
        height: 200.h,
        child: ColoredBox(
          color: AppColors.surfaceMuted,
          child: Center(
            child: Text(
              l10n.educationalMediaPdfError,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ),
      );
    }
    final controller = _controller;
    if (controller == null) {
      return SizedBox(
        height: 200.h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          child: SizedBox(
            height: 420.h,
            child: PdfView(
              controller: controller,
              scrollDirection: Axis.vertical,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.picture_as_pdf_outlined,
              size: 18,
              color: AppColors.textSecondary,
            ),
            SizedBox(width: 6.w),
            PdfPageNumber(
              controller: controller,
              builder: (context, loadingState, page, pagesCount) => Text(
                l10n.educationalMediaImageCounter(page, pagesCount ?? 0),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Social-media "stories" style image viewer: a top segmented progress bar,
/// auto-advance, tap-left/right zones to step, and pause-on-hold.
class _StoriesGallery extends StatefulWidget {
  const _StoriesGallery({
    required this.images,
    required this.l10n,
  });

  final List<EducationalMediaItem> images;
  final AppLocalizations l10n;

  @override
  State<_StoriesGallery> createState() => _StoriesGalleryState();
}

class _StoriesGalleryState extends State<_StoriesGallery>
    with SingleTickerProviderStateMixin {
  static const _slideDuration = Duration(seconds: 4);

  late final AnimationController _progress;
  int _index = 0;

  bool get _hasMultiple => widget.images.length > 1;

  @override
  void initState() {
    super.initState();
    _progress = AnimationController(vsync: this, duration: _slideDuration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _next();
        }
      });
    if (_hasMultiple) {
      unawaited(_progress.forward());
    }
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  void _restartTimer() {
    if (!_hasMultiple) {
      return;
    }
    _progress.reset();
    unawaited(_progress.forward());
  }

  void _next() {
    if (!mounted) {
      return;
    }
    setState(() => _index = (_index + 1) % widget.images.length);
    _restartTimer();
  }

  void _prev() {
    if (!mounted) {
      return;
    }
    setState(
      () => _index =
          (_index - 1 + widget.images.length) % widget.images.length,
    );
    _restartTimer();
  }

  void _pause() {
    if (_progress.isAnimating) {
      _progress.stop();
    }
  }

  void _resume() {
    if (_hasMultiple && !_progress.isAnimating) {
      unawaited(_progress.forward());
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = widget.images[_index.clamp(0, widget.images.length - 1)];

    return Column(
      children: [
        if (_hasMultiple) ...[
          Row(
            children: [
              for (var i = 0; i < widget.images.length; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: i == widget.images.length - 1 ? 0 : 4.w,
                    ),
                    child: _StorySegment(
                      controller: _progress,
                      state: i < _index
                          ? _SegmentState.done
                          : i == _index
                              ? _SegmentState.active
                              : _SegmentState.pending,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ResolvedTopicImage(
                  key: ValueKey(current.id),
                  media: current,
                  fit: BoxFit.cover,
                ),
                if (_hasMultiple)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: _prev,
                          onLongPress: _pause,
                          onLongPressUp: _resume,
                          onTapDown: (_) => _pause(),
                          onTapUp: (_) => _resume(),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: _next,
                          onLongPress: _pause,
                          onLongPressUp: _resume,
                          onTapDown: (_) => _pause(),
                          onTapUp: (_) => _resume(),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        if (_hasMultiple) ...[
          SizedBox(height: 8.h),
          Text(
            widget.l10n.educationalMediaImageCounter(
              _index + 1,
              widget.images.length,
            ),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ],
    );
  }
}

enum _SegmentState { done, active, pending }

class _StorySegment extends StatelessWidget {
  const _StorySegment({
    required this.controller,
    required this.state,
  });

  final AnimationController controller;
  final _SegmentState state;

  @override
  Widget build(BuildContext context) {
    final track = AppColors.textSecondary.withValues(alpha: 0.25);
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.r),
      child: SizedBox(
        height: 3.h,
        child: switch (state) {
          _SegmentState.done => const ColoredBox(color: AppColors.primary),
          _SegmentState.pending => ColoredBox(color: track),
          _SegmentState.active => AnimatedBuilder(
              animation: controller,
              builder: (context, _) => LinearProgressIndicator(
                value: controller.value,
                backgroundColor: track,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
        },
      ),
    );
  }
}
