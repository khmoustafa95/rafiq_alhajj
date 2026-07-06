import 'package:rafiq_alhajj/core/routing/app_routes.dart';

/// Resolves the parent list route for staff web sub-pages opened via [GoRouter.go].
///
/// Returns `null` for top-level staff pages where the sidebar is the primary nav.
String? staffBackFallbackRoute(String location) {
  final path = (Uri.tryParse(location)?.path ?? location).split('?').first;

  if (path == AppRoutes.operatorPilgrimsImport) {
    return AppRoutes.operatorPilgrims;
  }
  if (path.startsWith('${AppRoutes.operatorPilgrims}/') &&
      path != AppRoutes.operatorPilgrims) {
    return AppRoutes.operatorPilgrims;
  }

  if (path == AppRoutes.adminPushFailures) {
    return AppRoutes.adminNotificationSend;
  }

  if (path == AppRoutes.adminContentNew) {
    return AppRoutes.adminContent;
  }
  if (RegExp(r'^/admin/content/[^/]+/edit$').hasMatch(path) &&
      !path.startsWith('${AppRoutes.adminContentTopics}/')) {
    return AppRoutes.adminContent;
  }

  if (path == AppRoutes.adminContentTopicNew) {
    return AppRoutes.adminContentTopics;
  }
  if (RegExp(r'^/admin/content/topics/[^/]+/edit$').hasMatch(path)) {
    return AppRoutes.adminContentTopics;
  }

  if (path == AppRoutes.adminCompetitionNew) {
    return AppRoutes.adminCompetitions;
  }
  if (RegExp(r'^/admin/competitions/[^/]+/edit$').hasMatch(path)) {
    return AppRoutes.adminCompetitions;
  }

  if (path == AppRoutes.adminOperatorNew) {
    return AppRoutes.adminOperators;
  }
  if (RegExp(r'^/admin/operators/[^/]+/edit$').hasMatch(path)) {
    return AppRoutes.adminOperators;
  }

  if (path == AppRoutes.adminGroupNew) {
    return AppRoutes.adminGroups;
  }
  if (RegExp(r'^/admin/groups/[^/]+/edit$').hasMatch(path)) {
    return AppRoutes.adminGroups;
  }

  if (path == AppRoutes.adminSupportContactNew) {
    return AppRoutes.adminSupportContacts;
  }
  if (RegExp(r'^/admin/support-contacts/[^/]+/edit$').hasMatch(path)) {
    return AppRoutes.adminSupportContacts;
  }

  if (RegExp(r'^/admin/trips/[^/]+/offices$').hasMatch(path)) {
    return AppRoutes.adminTrips;
  }

  if (RegExp(r'^/admin/hajj-journey/[^/]+/edit$').hasMatch(path)) {
    return AppRoutes.adminHajjJourney;
  }

  return null;
}
