import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/push_navigation_resolver.dart';

void main() {
  group('resolvePushNavigationTarget', () {
    test('maps content route with id to detail push', () {
      final target = resolvePushNavigationTarget({
        'route': 'content',
        'id': 'abc',
      });

      expect(target.kind, PushNavigationKind.push);
      expect(target.path, AppRoutes.contentDetailPath('abc'));
    });

    test('maps contentTopic route with id to topic detail push', () {
      final target = resolvePushNavigationTarget({
        'route': 'contentTopic',
        'id': 'topic-1',
      });

      expect(target.kind, PushNavigationKind.push);
      expect(target.path, AppRoutes.contentTopicDetailPath('topic-1'));
    });

    test('maps competition route with id to competition detail push', () {
      final target = resolvePushNavigationTarget({
        'route': 'competition',
        'id': 'comp-1',
      });

      expect(target.kind, PushNavigationKind.push);
      expect(target.path, AppRoutes.competitionDetailPath('comp-1'));
    });

    test('maps sos route to sos target', () {
      final target = resolvePushNavigationTarget({'route': 'sos'});

      expect(target.kind, PushNavigationKind.sos);
      expect(target.path, isNull);
    });

    test('defaults unknown routes to notifications inbox', () {
      final target = resolvePushNavigationTarget({'route': 'unknown'});

      expect(target.kind, PushNavigationKind.go);
      expect(target.path, AppRoutes.notifications);
    });
  });

  group('pushOpenDedupeKey', () {
    test('prefers messageId when present', () {
      expect(
        pushOpenDedupeKey(
          messageId: 'msg-1',
          data: const {'notification_id': 'n-2', 'id': 'n-3'},
        ),
        'msg-1',
      );
    });

    test('falls back to notification_id then id', () {
      expect(
        pushOpenDedupeKey(data: const {'notification_id': 'n-2', 'id': 'n-3'}),
        'n-2',
      );
      expect(pushOpenDedupeKey(data: const {'id': 'n-3'}), 'n-3');
      expect(pushOpenDedupeKey(data: const {}), isNull);
    });
  });
}
