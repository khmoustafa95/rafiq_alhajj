import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/bootstrap/app_bootstrap.dart';
import 'package:rafiq_alhajj/core/telemetry/crash_reporter.dart';
import 'package:rafiq_alhajj/core/widgets/app_root.dart';
import 'package:rafiq_alhajj/core/widgets/bootstrap_failure_app.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      await _launchApp();
    },
    (error, stackTrace) {
      unawaited(CrashReporter.instance.recordError(error, stackTrace));
      _runBootstrapFailureApp(error, onRetry: _launchApp);
    },
  );
}

Future<void> _launchApp() async {
  try {
    final container = await AppBootstrap.initialize();

    runApp(
      UncontrolledProviderScope(
        container: container,
        child: const AppRoot(),
      ),
    );
  } on BootstrapException catch (e) {
    _runBootstrapFailureApp(e, onRetry: _launchApp);
  } catch (e) {
    _runBootstrapFailureApp(e, onRetry: _launchApp);
  }
}

void _runBootstrapFailureApp(
  Object error, {
  Future<void> Function()? onRetry,
}) {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BootstrapFailureApp(
      error: error,
      onRetry: onRetry,
    ),
  );
}
