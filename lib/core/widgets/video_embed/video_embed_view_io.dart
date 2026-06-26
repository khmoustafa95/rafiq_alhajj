import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Mobile/desktop implementation: play the embed URL in a [WebViewWidget].
Widget buildVideoEmbedView(String embedUrl) =>
    _WebViewVideoEmbed(embedUrl: embedUrl);

class _WebViewVideoEmbed extends StatefulWidget {
  const _WebViewVideoEmbed({required this.embedUrl});

  final String embedUrl;

  @override
  State<_WebViewVideoEmbed> createState() => _WebViewVideoEmbedState();
}

class _WebViewVideoEmbedState extends State<_WebViewVideoEmbed> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    unawaited(
      _controller.setJavaScriptMode(JavaScriptMode.unrestricted).then(
            (_) => _controller.loadRequest(Uri.parse(widget.embedUrl)),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
