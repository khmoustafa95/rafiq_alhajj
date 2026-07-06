import 'package:rafiq_alhajj/core/routing/app_routes.dart';

enum PushNavigationKind { go, push, sos }

class PushNavigationTarget {
  const PushNavigationTarget({
    required this.kind,
    this.path,
  });

  const PushNavigationTarget.go(String path)
      : this(kind: PushNavigationKind.go, path: path);

  const PushNavigationTarget.push(String path)
      : this(kind: PushNavigationKind.push, path: path);

  const PushNavigationTarget.sos() : this(kind: PushNavigationKind.sos);

  final PushNavigationKind kind;
  final String? path;
}

/// Resolves a push `data` payload to a navigation target without needing
/// [BuildContext]. SOS still needs role-aware routing at execution time.
PushNavigationTarget resolvePushNavigationTarget(Map<String, dynamic> data) {
  final route = data['route'] as String?;
  final id = data['id'] as String?;

  switch (route) {
    case 'content':
      if (id != null && id.isNotEmpty) {
        return PushNavigationTarget.push(AppRoutes.contentDetailPath(id));
      }
    case 'contentTopic':
      if (id != null && id.isNotEmpty) {
        return PushNavigationTarget.push(AppRoutes.contentTopicDetailPath(id));
      }
    case 'competition':
      if (id != null && id.isNotEmpty) {
        return PushNavigationTarget.push(AppRoutes.competitionDetailPath(id));
      }
    case 'pilgrim':
      return const PushNavigationTarget.push(AppRoutes.pilgrimDashboard);
    case 'competitions':
      return const PushNavigationTarget.push(AppRoutes.competitions);
    case 'sos':
      return const PushNavigationTarget.sos();
    case 'home':
      return const PushNavigationTarget.go(AppRoutes.home);
    case 'notifications':
      return const PushNavigationTarget.go(AppRoutes.notifications);
  }

  return const PushNavigationTarget.go(AppRoutes.notifications);
}

/// Stable id for deduplicating opened push messages across cold-start paths.
String? pushOpenDedupeKey({
  String? messageId,
  Map<String, dynamic>? data,
}) {
  return messageId ??
      data?['notification_id'] as String? ??
      data?['id'] as String?;
}
