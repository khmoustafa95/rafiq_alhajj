import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/l10n/app_locale_settings.dart';
import 'package:rafiq_alhajj/core/l10n/locale_controller.dart';
import 'package:rafiq_alhajj/core/routing/app_router.dart';
import 'package:rafiq_alhajj/core/theme/app_theme.dart';
import 'package:rafiq_alhajj/core/widgets/push_notification_starter.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_toast_host.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Root widget: Riverpod, ScreenUtil, theme, l10n, and [GoRouter].
class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeControllerProvider);

    return ScreenUtilInit(
      designSize: const Size(AppConfig.designWidth, AppConfig.designHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          locale: locale,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            if (deviceLocale == null) return AppLocaleSettings.defaultLocale;

            // البحث عن تطابق لغة جهاز المستخدم مع اللغات التي يدعمها التطبيق
            return supportedLocales.firstWhere(
              (supported) =>
                  supported.languageCode == deviceLocale.languageCode,
              orElse: () => AppLocaleSettings.defaultLocale,
            );
          },
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocaleSettings.supportedLocales,
          routerConfig: router,
          builder: (context, routerChild) {
            return PushNotificationStarter(
              child: NotificationToastHost(child: routerChild),
            );
          },
        );
      },
    );
  }
}
