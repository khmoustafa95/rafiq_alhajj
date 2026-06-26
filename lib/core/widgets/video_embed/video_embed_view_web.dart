import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// Web implementation: `webview_flutter` has no web platform, so embed the
/// player in a native HTML `<iframe>` surfaced through [HtmlElementView].
Widget buildVideoEmbedView(String embedUrl) =>
    _IframeVideoEmbed(embedUrl: embedUrl);

/// Tracks which view types have already been registered (re-registering the
/// same view type throws).
final Set<String> _registeredViewTypes = <String>{};

class _IframeVideoEmbed extends StatelessWidget {
  const _IframeVideoEmbed({required this.embedUrl});

  final String embedUrl;

  @override
  Widget build(BuildContext context) {
    final viewType = 'video-embed-${embedUrl.hashCode}';

    if (_registeredViewTypes.add(viewType)) {
      ui_web.platformViewRegistry.registerViewFactory(
        viewType,
        (int viewId) {
          final iframe = web.HTMLIFrameElement()
            ..src = embedUrl
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '100%'
            ..allow = 'autoplay; fullscreen; picture-in-picture; encrypted-media'
            ..allowFullscreen = true;
          return iframe;
        },
      );
    }

    return HtmlElementView(viewType: viewType);
  }
}
