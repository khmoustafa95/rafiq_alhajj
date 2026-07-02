import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Minimal MaterialApp + ScreenUtil + l10n wrapper for widget tests.
Widget wrapTestApp(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(AppConfig.designWidth, AppConfig.designHeight),
    minTextAdapt: true,
    builder: (context, _) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: child),
      );
    },
  );
}

void setLargeTestViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 1.0;
}

void resetTestViewport(WidgetTester tester) {
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}
