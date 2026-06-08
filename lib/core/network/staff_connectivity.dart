import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'staff_connectivity.g.dart';

@Riverpod(keepAlive: true)
class StaffConnectivity extends _$StaffConnectivity {
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  bool build() {
    unawaited(_subscription?.cancel());
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      state = _isOnline(results);
    });

    ref.onDispose(() {
      unawaited(_subscription?.cancel());
    });

    unawaited(_refresh());
    return true;
  }

  bool _isOnline(List<ConnectivityResult> results) {
    return results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.vpn,
    );
  }

  Future<void> _refresh() async {
    final results = await Connectivity().checkConnectivity();
    state = _isOnline(results);
  }

  Future<void> refresh() => _refresh();
}
