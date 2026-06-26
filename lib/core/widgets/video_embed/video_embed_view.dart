import 'package:flutter/widgets.dart';
import 'package:rafiq_alhajj/core/widgets/video_embed/video_embed_view_io.dart'
    if (dart.library.js_interop) 'package:rafiq_alhajj/core/widgets/video_embed/video_embed_view_web.dart'
    as impl;

/// Renders an embedded video player for a YouTube/Vimeo (or other) embed URL.
///
/// On mobile this uses `webview_flutter`; on web (where `webview_flutter` has no
/// implementation) it renders a native HTML `<iframe>` via `HtmlElementView`.
Widget buildVideoEmbedView(String embedUrl) => impl.buildVideoEmbedView(embedUrl);
