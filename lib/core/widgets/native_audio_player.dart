import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NativeAudioPlayer extends StatefulWidget {
  const NativeAudioPlayer({
    required this.url,
    this.title,
    super.key,
  });

  final String url;
  final String? title;

  @override
  State<NativeAudioPlayer> createState() => _NativeAudioPlayerState();
}

class _NativeAudioPlayerState extends State<NativeAudioPlayer> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  bool get _useNative =>
      !AppPlatform.isWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  void initState() {
    super.initState();
    if (!_useNative) {
      return;
    }

    _player.onDurationChanged.listen((value) {
      if (!mounted) {
        return;
      }
      setState(() => _duration = value);
    });
    _player.onPositionChanged.listen((value) {
      if (!mounted) {
        return;
      }
      setState(() => _position = value);
    });
    _player.onPlayerComplete.listen((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });
  }

  @override
  void didUpdateWidget(covariant NativeAudioPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_useNative && oldWidget.url != widget.url) {
      unawaited(_player.stop());
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
        _duration = Duration.zero;
      });
    }
  }

  @override
  void dispose() {
    unawaited(_player.dispose());
    super.dispose();
  }

  Future<void> _togglePlayback() async {
    if (_isPlaying) {
      await _player.pause();
      setState(() => _isPlaying = false);
      return;
    }

    final source = _sourceForUrl(widget.url);
    await _player.play(source);
    setState(() => _isPlaying = true);
  }

  Source _sourceForUrl(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return UrlSource(url);
    }
    return DeviceFileSource(url);
  }

  @override
  Widget build(BuildContext context) {
    if (!_useNative) {
      return _WebAudioFallback(url: widget.url, title: widget.title);
    }

    final maxMs = _duration.inMilliseconds <= 0
        ? 1.0
        : _duration.inMilliseconds.toDouble();

    return DecoratedBox(
      decoration: AppDecorations.card(color: AppColors.surfaceMuted),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.title != null && widget.title!.isNotEmpty)
              Text(
                widget.title!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            if (widget.title != null && widget.title!.isNotEmpty)
              SizedBox(height: 8.h),
            Row(
              children: [
                IconButton.filled(
                  onPressed: _togglePlayback,
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                ),
                Expanded(
                  child: Slider(
                    value: _position.inMilliseconds
                        .clamp(0, _duration.inMilliseconds)
                        .toDouble(),
                    max: maxMs,
                    onChanged: _duration == Duration.zero
                        ? null
                        : (value) async {
                            final position =
                                Duration(milliseconds: value.round());
                            await _player.seek(position);
                            setState(() => _position = position);
                          },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WebAudioFallback extends StatefulWidget {
  const _WebAudioFallback({required this.url, this.title});

  final String url;
  final String? title;

  @override
  State<_WebAudioFallback> createState() => _WebAudioFallbackState();
}

class _WebAudioFallbackState extends State<_WebAudioFallback> {
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
