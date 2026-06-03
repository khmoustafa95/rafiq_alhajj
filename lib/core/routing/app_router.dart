import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/router_refresh_notifier.dart';
import 'package:rafiq_alhajj/core/routing/widgets/route_not_found_screen.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_dashboard_screen.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_login_screen.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_content_edit_screen.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_content_list_screen.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/auth/presentation/widgets/login_screen.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/admin_competition_edit_screen.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/admin_competitions_list_screen.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_detail_screen.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competitions_list_screen.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_detail_screen.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_home_screen.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_login_screen.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_pilgrim_screen.dart';
import 'package:rafiq_alhajj/features/home/presentation/widgets/home_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/adhkar_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/islamic_tools_hub_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/prayer_times_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/qibla_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/quran_surah_detail_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/quran_surah_list_screen.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_list_screen.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_intake_screen.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_login_screen.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_detail_screen.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_list_screen.dart';
import 'package:rafiq_alhajj/features/pilgrim/presentation/widgets/pilgrim_dashboard_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final refresh = ref.watch(appRouterRefreshProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation:
        AppPlatform.isWeb ? AppRoutes.operatorLogin : AppRoutes.home,
    refreshListenable: refresh,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final sessionAsync = ref.read(authSessionProvider);
      final location = state.matchedLocation;

      final accessMode = sessionAsync.maybeWhen(
        data: (session) => session.accessMode,
        orElse: () => AppAccessMode.guest,
      );

      final isPilgrim = accessMode == AppAccessMode.pilgrim;
      final isOperator = accessMode == AppAccessMode.operator;
      final isAdmin = accessMode == AppAccessMode.admin;
      final isAdminRoute = location.startsWith('/admin');
      final isFieldOperatorRoute = location.startsWith('/operator/field');
      final isOperatorWebRoute =
          location.startsWith('/operator') && !isFieldOperatorRoute;

      if (location == AppRoutes.notifications) {
        if (accessMode == AppAccessMode.guest) {
          if (AppPlatform.isWeb) {
            return AppRoutes.operatorLogin;
          }
          return AppRoutes.login;
        }
        return null;
      }

      if (AppPlatform.isWeb) {
        if (isFieldOperatorRoute) {
          return AppRoutes.operatorLogin;
        }

        if (location.startsWith('/competitions')) {
          return null;
        }

        if (isAdmin) {
          if (!isAdminRoute || location == AppRoutes.adminLogin) {
            return AppRoutes.adminDashboard;
          }
          return null;
        }

        if (isOperator) {
          if (!isOperatorWebRoute || location == AppRoutes.operatorLogin) {
            return AppRoutes.operatorIntake;
          }
          return null;
        }

        if (isAdminRoute && location != AppRoutes.adminLogin) {
          return AppRoutes.adminLogin;
        }
        if (isOperatorWebRoute && location != AppRoutes.operatorLogin) {
          return AppRoutes.operatorLogin;
        }

        if (!isAdminRoute && !isOperatorWebRoute) {
          return AppRoutes.operatorLogin;
        }

        return null;
      }

      if (isAdmin) {
        if (!isAdminRoute || location == AppRoutes.adminLogin) {
          return AppRoutes.adminDashboard;
        }
        return null;
      }

      if (isOperator) {
        if (!isFieldOperatorRoute ||
            location == AppRoutes.fieldOperatorLogin) {
          return AppRoutes.fieldOperatorHome;
        }
        return null;
      }

      if (isAdminRoute && location != AppRoutes.adminLogin) {
        return AppRoutes.adminLogin;
      }

      if (isFieldOperatorRoute &&
          location != AppRoutes.fieldOperatorLogin) {
        return AppRoutes.fieldOperatorLogin;
      }

      if (isPilgrim && location == AppRoutes.login) {
        return AppRoutes.home;
      }

      if (!isPilgrim && location == AppRoutes.pilgrimDashboard) {
        return AppRoutes.login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        name: 'notifications',
        builder: (context, state) => const NotificationListScreen(),
      ),
      GoRoute(
        path: AppRoutes.contentDetail,
        name: 'contentDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ContentDetailScreen(contentId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.pilgrimDashboard,
        name: 'pilgrimDashboard',
        builder: (context, state) => const PilgrimDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.operatorLogin,
        name: 'operatorLogin',
        builder: (context, state) => const OperatorLoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.operatorIntake,
        name: 'operatorIntake',
        builder: (context, state) => const OperatorIntakeScreen(),
      ),
      GoRoute(
        path: AppRoutes.operatorPilgrims,
        name: 'operatorPilgrims',
        builder: (context, state) => const OperatorPilgrimListScreen(),
      ),
      GoRoute(
        path: AppRoutes.operatorPilgrimDetail,
        name: 'operatorPilgrimDetail',
        builder: (context, state) {
          final profileId = state.pathParameters['profileId']!;
          return OperatorPilgrimDetailScreen(profileId: profileId);
        },
      ),
      GoRoute(
        path: AppRoutes.adminLogin,
        name: 'adminLogin',
        builder: (context, state) => const AdminLoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminDashboard,
        name: 'adminDashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminContent,
        name: 'adminContent',
        builder: (context, state) => const AdminContentListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminContentNew,
        name: 'adminContentNew',
        builder: (context, state) => const AdminContentEditScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminContentEdit,
        name: 'adminContentEdit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminContentEditScreen(contentId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.adminCompetitions,
        name: 'adminCompetitions',
        builder: (context, state) => const AdminCompetitionsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminCompetitionNew,
        name: 'adminCompetitionNew',
        builder: (context, state) => const AdminCompetitionEditScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminCompetitionEdit,
        name: 'adminCompetitionEdit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminCompetitionEditScreen(competitionId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.competitions,
        name: 'competitions',
        builder: (context, state) => const CompetitionsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.competitionDetail,
        name: 'competitionDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CompetitionDetailScreen(competitionId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.fieldOperatorLogin,
        name: 'fieldOperatorLogin',
        builder: (context, state) => const FieldOperatorLoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.fieldOperatorHome,
        name: 'fieldOperatorHome',
        builder: (context, state) => const FieldOperatorHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.fieldOperatorPilgrim,
        name: 'fieldOperatorPilgrim',
        builder: (context, state) {
          final profileId = state.pathParameters['profileId']!;
          return FieldOperatorPilgrimScreen(profileId: profileId);
        },
      ),
      GoRoute(
        path: AppRoutes.tools,
        name: 'tools',
        builder: (context, state) => const IslamicToolsHubScreen(),
        routes: [
          GoRoute(
            path: 'prayer-times',
            name: 'prayerTimes',
            builder: (context, state) => const PrayerTimesScreen(),
          ),
          GoRoute(
            path: 'qibla',
            name: 'qibla',
            builder: (context, state) => const QiblaScreen(),
          ),
          GoRoute(
            path: 'quran',
            name: 'quran',
            builder: (context, state) => const QuranSurahListScreen(),
            routes: [
              GoRoute(
                path: ':surahNumber',
                name: 'quranSurah',
                builder: (context, state) {
                  final surahNumber =
                      int.parse(state.pathParameters['surahNumber']!);
                  return QuranSurahDetailScreen(surahNumber: surahNumber);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'adhkar',
            name: 'adhkar',
            builder: (context, state) => const AdhkarScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => RouteNotFoundScreen(
      location: state.uri.toString(),
    ),
  );
}
