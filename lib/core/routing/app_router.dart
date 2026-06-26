import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/root_navigator_key.dart';
import 'package:rafiq_alhajj/core/routing/router_refresh_notifier.dart';
import 'package:rafiq_alhajj/core/routing/widgets/route_not_found_screen.dart';
import 'package:rafiq_alhajj/core/widgets/pilgrim_shell_screen.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_shell.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_dashboard_screen.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_login_screen.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_content_edit_screen.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_content_list_screen.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_content_topic_edit_screen.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_content_topics_list_screen.dart';
import 'package:rafiq_alhajj/features/admin_groups/presentation/widgets/admin_group_edit_screen.dart';
import 'package:rafiq_alhajj/features/admin_groups/presentation/widgets/admin_groups_list_screen.dart';
import 'package:rafiq_alhajj/features/admin_operators/presentation/widgets/admin_operator_edit_screen.dart';
import 'package:rafiq_alhajj/features/admin_operators/presentation/widgets/admin_operators_list_screen.dart';
import 'package:rafiq_alhajj/features/admin_settings/presentation/widgets/admin_settings_screen.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/auth/presentation/widgets/login_screen.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/admin_competition_edit_screen.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/admin_competitions_list_screen.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_detail_screen.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_quiz_screen.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competitions_list_screen.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_detail_screen.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_list_screen.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_topic_detail_screen.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_topics_list_screen.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_dashboard_screen.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_login_screen.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_pilgrim_screen.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_pilgrims_screen.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_shell_screen.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/widgets/admin_hajj_journey_edit_screen.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/widgets/admin_hajj_journey_list_screen.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/widgets/hajj_journey_path_screen.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/widgets/hajj_ritual_detail_screen.dart';
import 'package:rafiq_alhajj/features/home/presentation/widgets/home_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/adhkar_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/islamic_tools_hub_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/prayer_times_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/qibla_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/quran_surah_detail_screen.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/quran_surah_list_screen.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/admin_notification_broadcast_screen.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_list_screen.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_intake_screen.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_login_screen.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_detail_screen.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_list_screen.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_import_screen.dart';
import 'package:rafiq_alhajj/features/profile/presentation/widgets/profile_screen.dart';
import 'package:rafiq_alhajj/features/services/presentation/widgets/services_hub_screen.dart';
import 'package:rafiq_alhajj/features/sos/presentation/widgets/sos_monitor_screen.dart';
import 'package:rafiq_alhajj/features/sos/presentation/widgets/sos_screen.dart';
import 'package:rafiq_alhajj/features/support_contacts/presentation/widgets/admin_support_contact_edit_screen.dart';
import 'package:rafiq_alhajj/features/support_contacts/presentation/widgets/admin_support_contacts_screen.dart';
import 'package:rafiq_alhajj/features/support_contacts/presentation/widgets/support_contacts_screen.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/admin_trip_offices_screen.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/admin_trips_list_screen.dart';
import 'package:rafiq_alhajj/features/virtual_tour/presentation/widgets/virtual_tour_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// Tool detail routes rendered above the pilgrim shell (no bottom nav bar).
///
/// They are nested under `/tools` for path semantics but pinned to the root
/// navigator so the bottom navigation bar and home FAB are hidden on them.
List<RouteBase> _toolsChildRoutes() => [
      GoRoute(
        path: 'prayer-times',
        name: 'prayerTimes',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const PrayerTimesScreen(),
      ),
      GoRoute(
        path: 'qibla',
        name: 'qibla',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const QiblaScreen(),
      ),
      GoRoute(
        path: 'quran',
        name: 'quran',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const QuranSurahListScreen(),
        routes: [
          GoRoute(
            path: ':surahNumber',
            name: 'quranSurah',
            parentNavigatorKey: rootNavigatorKey,
            builder: (context, state) {
              final surahNumber = int.parse(
                state.pathParameters['surahNumber']!,
              );
              return QuranSurahDetailScreen(surahNumber: surahNumber);
            },
          ),
        ],
      ),
      GoRoute(
        path: 'adhkar',
        name: 'adhkar',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const AdhkarScreen(),
      ),
      GoRoute(
        path: 'virtual-tour',
        name: 'virtualTour',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const VirtualTourScreen(),
      ),
    ];

StatefulShellRoute _fieldOperatorShellRoute() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return FieldOperatorShellScreen(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.fieldOperatorHome,
            name: 'fieldOperatorHome',
            builder: (context, state) => const FieldOperatorDashboardScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.fieldOperatorPilgrims,
            name: 'fieldOperatorPilgrims',
            builder: (context, state) => const FieldOperatorPilgrimsScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.fieldOperatorSos,
            name: 'fieldOperatorSos',
            builder: (context, state) => const SosMonitorScreen(),
          ),
        ],
      ),
    ],
  );
}

StatefulShellRoute _pilgrimShellRoute() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return PilgrimShellScreen(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.tools,
            name: 'tools',
            builder: (context, state) => const IslamicToolsHubScreen(),
            routes: _toolsChildRoutes(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.services,
            name: 'services',
            builder: (context, state) => const ServicesHubScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.notifications,
            name: 'notifications',
            builder: (context, state) => const NotificationListScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}

List<RouteBase> _mobilePilgrimRoutes() => [
      _pilgrimShellRoute(),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.contentVideosList,
        name: 'contentVideosList',
        redirect: (context, state) => AppRoutes.contentTopicsList,
      ),
      GoRoute(
        path: AppRoutes.contentTopicsList,
        name: 'contentTopicsList',
        builder: (context, state) => const ContentTopicsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.contentTopicDetail,
        name: 'contentTopicDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ContentTopicDetailScreen(topicId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.contentNewsList,
        name: 'contentNewsList',
        builder: (context, state) => const ContentListScreen(
          category: ContentListCategory.news,
        ),
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
        redirect: (context, state) => AppRoutes.hajjJourney,
      ),
      GoRoute(
        path: AppRoutes.hajjJourney,
        name: 'hajjJourney',
        builder: (context, state) => const HajjJourneyPathScreen(),
      ),
      GoRoute(
        path: AppRoutes.hajjRitualDetail,
        name: 'hajjRitualDetail',
        builder: (context, state) {
          final ritualKey = state.pathParameters['ritualKey']!;
          return HajjRitualDetailScreen(ritualKey: ritualKey);
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
        path: AppRoutes.competitionQuiz,
        name: 'competitionQuiz',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CompetitionQuizScreen(competitionId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.fieldOperatorLogin,
        name: 'fieldOperatorLogin',
        builder: (context, state) => const FieldOperatorLoginScreen(),
      ),
      _fieldOperatorShellRoute(),
      GoRoute(
        path: AppRoutes.fieldOperatorPilgrim,
        name: 'fieldOperatorPilgrim',
        builder: (context, state) {
          final profileId = state.pathParameters['profileId']!;
          return FieldOperatorPilgrimScreen(profileId: profileId);
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
        path: AppRoutes.adminNotificationSend,
        name: 'adminNotificationSend',
        builder: (context, state) => const AdminNotificationBroadcastScreen(),
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
        path: AppRoutes.adminContentTopics,
        name: 'adminContentTopics',
        builder: (context, state) => const AdminContentTopicsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminContentTopicNew,
        name: 'adminContentTopicNew',
        builder: (context, state) => const AdminContentTopicEditScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminContentTopicEdit,
        name: 'adminContentTopicEdit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminContentTopicEditScreen(topicId: id);
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
        path: AppRoutes.adminHajjJourney,
        name: 'adminHajjJourney',
        builder: (context, state) => const AdminHajjJourneyListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminHajjJourneyEdit,
        name: 'adminHajjJourneyEdit',
        builder: (context, state) {
          final ritualKey = state.pathParameters['ritualKey']!;
          return AdminHajjJourneyEditScreen(ritualKey: ritualKey);
        },
      ),
      GoRoute(
        path: AppRoutes.adminOperators,
        name: 'adminOperators',
        builder: (context, state) => const AdminOperatorsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminOperatorNew,
        name: 'adminOperatorNew',
        builder: (context, state) => const AdminOperatorEditScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminOperatorEdit,
        name: 'adminOperatorEdit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminOperatorEditScreen(operatorId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.adminGroups,
        name: 'adminGroups',
        builder: (context, state) => const AdminGroupsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminGroupNew,
        name: 'adminGroupNew',
        builder: (context, state) => const AdminGroupEditScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminGroupEdit,
        name: 'adminGroupEdit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminGroupEditScreen(groupId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.adminTrips,
        name: 'adminTrips',
        builder: (context, state) => const AdminTripsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminTripOffices,
        name: 'adminTripOffices',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminTripOfficesScreen(tripId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.adminSettings,
        name: 'adminSettings',
        builder: (context, state) => const AdminSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.supportContacts,
        name: 'supportContacts',
        builder: (context, state) => const SupportContactsScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminSupportContacts,
        name: 'adminSupportContacts',
        builder: (context, state) => const AdminSupportContactsScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminSupportContactNew,
        name: 'adminSupportContactNew',
        builder: (context, state) => const AdminSupportContactEditScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminSupportContactEdit,
        name: 'adminSupportContactEdit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminSupportContactEditScreen(contactId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.sos,
        name: 'sos',
        builder: (context, state) => const SosScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminSos,
        name: 'adminSos',
        builder: (context, state) => const SosMonitorScreen(),
      ),
    ];

ShellRoute _staffWebShellRoute() {
  return ShellRoute(
    builder: (context, state, child) {
      return StaffWebShell(child: child);
    },
    routes: [
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
        path: AppRoutes.operatorPilgrimsImport,
        name: 'operatorPilgrimsImport',
        builder: (context, state) => const PilgrimImportScreen(),
      ),
      GoRoute(
        path: AppRoutes.operatorPilgrimDetail,
        name: 'operatorPilgrimDetail',
        builder: (context, state) {
          final pilgrimId = state.pathParameters['pilgrimId']!;
          return OperatorPilgrimDetailScreen(pilgrimId: pilgrimId);
        },
      ),
      GoRoute(
        path: AppRoutes.adminDashboard,
        name: 'adminDashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        name: 'staffNotifications',
        builder: (context, state) => const NotificationListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminNotificationSend,
        name: 'adminNotificationSend',
        builder: (context, state) =>
            const AdminNotificationBroadcastScreen(),
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
        path: AppRoutes.adminContentTopics,
        name: 'adminContentTopics',
        builder: (context, state) => const AdminContentTopicsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminContentTopicNew,
        name: 'adminContentTopicNew',
        builder: (context, state) => const AdminContentTopicEditScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminContentTopicEdit,
        name: 'adminContentTopicEdit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminContentTopicEditScreen(topicId: id);
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
        path: AppRoutes.adminHajjJourney,
        name: 'adminHajjJourneyWeb',
        builder: (context, state) => const AdminHajjJourneyListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminHajjJourneyEdit,
        name: 'adminHajjJourneyEditWeb',
        builder: (context, state) {
          final ritualKey = state.pathParameters['ritualKey']!;
          return AdminHajjJourneyEditScreen(ritualKey: ritualKey);
        },
      ),
      GoRoute(
        path: AppRoutes.adminOperators,
        name: 'adminOperators',
        builder: (context, state) => const AdminOperatorsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminOperatorNew,
        name: 'adminOperatorNew',
        builder: (context, state) => const AdminOperatorEditScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminOperatorEdit,
        name: 'adminOperatorEdit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminOperatorEditScreen(operatorId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.adminGroups,
        name: 'adminGroups',
        builder: (context, state) => const AdminGroupsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminGroupNew,
        name: 'adminGroupNew',
        builder: (context, state) => const AdminGroupEditScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminGroupEdit,
        name: 'adminGroupEdit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminGroupEditScreen(groupId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.adminTrips,
        name: 'adminTrips',
        builder: (context, state) => const AdminTripsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminTripOffices,
        name: 'adminTripOffices',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminTripOfficesScreen(tripId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.adminSettings,
        name: 'adminSettings',
        builder: (context, state) => const AdminSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminSupportContacts,
        name: 'adminSupportContactsWeb',
        builder: (context, state) => const AdminSupportContactsScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminSupportContactNew,
        name: 'adminSupportContactNewWeb',
        builder: (context, state) => const AdminSupportContactEditScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminSupportContactEdit,
        name: 'adminSupportContactEditWeb',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AdminSupportContactEditScreen(contactId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.adminSos,
        name: 'adminSosWeb',
        builder: (context, state) => const SosMonitorScreen(),
      ),
    ],
  );
}

/// Admin staff portal on web: `/admin/*` plus shared pilgrim registry routes.
bool _isAdminStaffWebRoute(String location) {
  if (location.startsWith('/admin') && location != AppRoutes.adminLogin) {
    return true;
  }
  return location == AppRoutes.operatorPilgrims ||
      location.startsWith('${AppRoutes.operatorPilgrims}/') ||
      location == AppRoutes.operatorIntake;
}

List<RouteBase> _webRoutes() => [
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
        path: AppRoutes.contentVideosList,
        name: 'contentVideosListWeb',
        redirect: (context, state) => AppRoutes.contentTopicsList,
      ),
      GoRoute(
        path: AppRoutes.contentTopicsList,
        name: 'contentTopicsListWeb',
        builder: (context, state) => const ContentTopicsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.contentTopicDetail,
        name: 'contentTopicDetailWeb',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ContentTopicDetailScreen(topicId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.contentNewsList,
        name: 'contentNewsListWeb',
        builder: (context, state) => const ContentListScreen(
          category: ContentListCategory.news,
        ),
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
        redirect: (context, state) => AppRoutes.hajjJourney,
      ),
      GoRoute(
        path: AppRoutes.hajjJourney,
        name: 'hajjJourneyWeb',
        builder: (context, state) => const HajjJourneyPathScreen(),
      ),
      GoRoute(
        path: AppRoutes.hajjRitualDetail,
        name: 'hajjRitualDetailWeb',
        builder: (context, state) {
          final ritualKey = state.pathParameters['ritualKey']!;
          return HajjRitualDetailScreen(ritualKey: ritualKey);
        },
      ),
      GoRoute(
        path: AppRoutes.operatorLogin,
        name: 'operatorLogin',
        builder: (context, state) => const OperatorLoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminLogin,
        name: 'adminLogin',
        builder: (context, state) => const AdminLoginScreen(),
      ),
      _staffWebShellRoute(),
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
        path: AppRoutes.competitionQuiz,
        name: 'competitionQuiz',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CompetitionQuizScreen(competitionId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.tools,
        name: 'tools',
        builder: (context, state) => const IslamicToolsHubScreen(),
        routes: _toolsChildRoutes(),
      ),
      GoRoute(
        path: AppRoutes.supportContacts,
        name: 'supportContactsWeb',
        builder: (context, state) => const SupportContactsScreen(),
      ),
    ];

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = ref.watch(appRouterRefreshProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppPlatform.isWeb
        ? AppRoutes.operatorLogin
        : AppRoutes.home,
    refreshListenable: refresh,
    debugLogDiagnostics: AppConfig.routerDebugLogDiagnostics,
    redirect: (context, state) {
      final sessionAsync = ref.read(authSessionProvider);
      if (sessionAsync.isLoading) {
        return null;
      }
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

      if (AppPlatform.isWeb) {
        if (isFieldOperatorRoute) {
          return AppRoutes.operatorLogin;
        }

        if (location.startsWith('/competitions')) {
          return null;
        }

        if (isAdmin) {
          if (location == AppRoutes.adminLogin) {
            return AppRoutes.adminDashboard;
          }
          if (location == AppRoutes.notifications ||
              _isAdminStaffWebRoute(location)) {
            return null;
          }
          return AppRoutes.adminDashboard;
        }

        if (isOperator) {
          if (location == AppRoutes.notifications) {
            return null;
          }
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
        if (location == AppRoutes.adminLogin) {
          return AppRoutes.adminDashboard;
        }
        if (location == AppRoutes.notifications ||
            _isAdminStaffWebRoute(location)) {
          return null;
        }
        return AppRoutes.adminDashboard;
      }

      if (isOperator) {
        if (location == AppRoutes.notifications) {
          return null;
        }
        if (!isFieldOperatorRoute || location == AppRoutes.fieldOperatorLogin) {
          return AppRoutes.fieldOperatorHome;
        }
        return null;
      }

      if (isAdminRoute && location != AppRoutes.adminLogin) {
        return AppRoutes.adminLogin;
      }

      if (isFieldOperatorRoute && location != AppRoutes.fieldOperatorLogin) {
        return AppRoutes.home;
      }

      if (isPilgrim && location == AppRoutes.login) {
        return AppRoutes.home;
      }

      if (!isPilgrim &&
          (location == AppRoutes.pilgrimDashboard ||
              location == AppRoutes.hajjJourney ||
              location.startsWith('${AppRoutes.hajjJourney}/'))) {
        return AppRoutes.login;
      }

      return null;
    },
    routes: AppPlatform.isWeb ? _webRoutes() : _mobilePilgrimRoutes(),
    errorBuilder: (context, state) =>
        RouteNotFoundScreen(location: state.uri.toString()),
  );
}
