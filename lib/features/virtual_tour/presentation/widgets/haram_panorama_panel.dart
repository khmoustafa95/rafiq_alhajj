import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HaramPanoramaPanel extends StatefulWidget {
  const HaramPanoramaPanel({super.key});

  @override
  State<HaramPanoramaPanel> createState() => _HaramPanoramaPanelState();
}

class _HaramPanoramaPanelState extends State<HaramPanoramaPanel> {
  static const _assetPath = 'assets/virtual_tour/panorama.html';

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
    await _controller.setBackgroundColor(const Color(0xFF111827));
    await _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (_) {
          if (mounted) setState(() => _isLoading = false);
        },
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
          child: Text(
            l10n.toolsVirtualTourPanoramaHint,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 0),
          child: Text(
            l10n.toolsVirtualTourPanoramaCredit,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10.sp,
                ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              if (!_hasError) WebViewWidget(controller: _controller),
              if (_isLoading && !_hasError)
                const Center(child: CircularProgressIndicator()),
              if (_hasError)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.toolsVirtualTourLoadError,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),
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
        ),
      ],
    );
  }
}
