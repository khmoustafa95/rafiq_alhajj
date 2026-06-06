import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/l10n/locale_controller.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VirtualTourScreen extends ConsumerStatefulWidget {
  const VirtualTourScreen({super.key});

  @override
  ConsumerState<VirtualTourScreen> createState() => _VirtualTourScreenState();
}

class _VirtualTourScreenState extends ConsumerState<VirtualTourScreen> {
  static const _assetPath = 'assets/virtual_tour/index.html';

  final WebViewController _controller = WebViewController();
  var _isLoading = true;
  var _hasError = false;

  @override
  void initState() {
    super.initState();
    unawaited(_initWebView());
  }

  Future<void> _initWebView() async {
    await _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    await _controller.setBackgroundColor(AppColors.background);
    await _controller.addJavaScriptChannel(
      'RafiqTour',
      onMessageReceived: (_) {},
    );
    await _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: _onPageFinished,
        onWebResourceError: (_) {
          if (mounted) {
            setState(() {
              _hasError = true;
              _isLoading = false;
            });
          }
        },
      ),
    );
    await _controller.loadFlutterAsset(_assetPath);
  }

  Future<void> _onPageFinished(String url) async {
    final locale = ref.read(localeControllerProvider);
    await _controller.runJavaScript(
      "setLocale('${locale.languageCode}')",
    );
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _reload() async {
    setState(() {
      _hasError = false;
      _isLoading = true;
    });
    await _controller.loadFlutterAsset(_assetPath);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    ref.listen(localeControllerProvider, (previous, next) {
      if (previous?.languageCode != next.languageCode) {
        unawaited(
          _controller.runJavaScript("setLocale('${next.languageCode}')"),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RafiqAppBar(title: Text(l10n.toolsVirtualTourTitle)),
      body: Stack(
        children: [
          if (!_hasError) WebViewWidget(controller: _controller),
          if (_isLoading && !_hasError)
            const Center(child: CircularProgressIndicator()),
          if (_hasError)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.toolsVirtualTourLoadError,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _reload,
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
