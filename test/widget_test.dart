import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/core/widgets/app_root.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/auth_session_state.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/public_content_feed_provider.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/models/prayer_times_schedule.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/providers/prayer_times_provider.dart';

void main() {
  testWidgets('AppRoot shows guest home with bottom navigation', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authSessionProvider.overrideWith(
            (ref) => Stream.value(const AuthSessionState.guest()),
          ),
          homeContentFeedProvider(AppAccessMode.guest).overrideWith(
            (ref) async => const PublicContentFeed(
              announcements: [],
              news: [],
              topics: [],
            ),
          ),
          prayerTimesScheduleProvider.overrideWith(
            (ref) async => PrayerTimesSchedule(
              date: DateTime(2026, 6, 6),
              fajr: '5:00 AM',
              sunrise: '6:15 AM',
              dhuhr: '12:14 PM',
              asr: '3:30 PM',
              maghrib: '6:45 PM',
              isha: '8:00 PM',
              latitude: 21.4225,
              longitude: 39.8262,
              fromCachedLocation: true,
            ),
          ),
        ],
        child: const AppRoot(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byIcon(Icons.home_rounded), findsOneWidget);
  });
}
