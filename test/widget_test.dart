import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/core/widgets/app_root.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/auth_session_state.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/public_content_feed_provider.dart';

void main() {
  testWidgets('AppRoot shows guest home with content sections', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authSessionProvider.overrideWith(
            (ref) => Stream.value(const AuthSessionState.guest()),
          ),
          homeContentFeedProvider(AppAccessMode.guest).overrideWith(
            (ref) async => const PublicContentFeed(
              videos: [],
              newsAndAnnouncements: [],
            ),
          ),
        ],
        child: const AppRoot(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byIcon(Icons.mosque_outlined), findsOneWidget);
  });
}
