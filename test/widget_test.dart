import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/core/widgets/app_root.dart';

void main() {
  testWidgets('AppRoot shows home welcome message', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: AppRoot(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byIcon(Icons.mosque_outlined), findsOneWidget);
  });
}
