import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_refresh_notifier.g.dart';

/// Notifies [GoRouter] when auth session changes.
@Riverpod(keepAlive: true)
AppRouterRefresh appRouterRefresh(Ref ref) {
  final notifier = AppRouterRefresh();
  ref.listen(authSessionProvider, (_, _) => notifier.refresh());
  ref.onDispose(notifier.dispose);
  return notifier;
}

class AppRouterRefresh extends ChangeNotifier {
  void refresh() => notifyListeners();
}
