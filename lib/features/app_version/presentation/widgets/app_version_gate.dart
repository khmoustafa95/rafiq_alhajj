import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/version_check_result.dart';
import 'package:rafiq_alhajj/features/app_version/presentation/providers/app_version_providers.dart';
import 'package:rafiq_alhajj/features/app_version/presentation/widgets/force_update_screen.dart';
import 'package:rafiq_alhajj/features/app_version/presentation/widgets/optional_update_dialog.dart';
import 'package:rafiq_alhajj/features/app_version/presentation/widgets/version_update_launcher.dart';

/// Checks remote version policy on launch / resume and blocks or prompts users.
class AppVersionGate extends ConsumerStatefulWidget {
  const AppVersionGate({required this.child, super.key});

  final Widget? child;

  @override
  ConsumerState<AppVersionGate> createState() => _AppVersionGateState();
}

class _AppVersionGateState extends ConsumerState<AppVersionGate>
    with WidgetsBindingObserver {
  String? _optionalPromptVersion;
  bool _dialogOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_refreshCheck());
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_refreshCheck());
    }
  }

  Future<void> _refreshCheck() async {
    ref.invalidate(appVersionCheckProvider);
    await ref.read(appVersionCheckProvider.future);
  }

  Future<void> _showOptionalDialog(VersionCheckResult result) async {
    final policy = result.policy;
    if (policy == null || _dialogOpen) {
      return;
    }
    if (_optionalPromptVersion == policy.latestVersion) {
      return;
    }

    _optionalPromptVersion = policy.latestVersion;
    _dialogOpen = true;

    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) => OptionalUpdateDialog(
        currentVersion: result.currentVersion,
        policy: policy,
        onUpdate: () {
          Navigator.of(context).pop();
          unawaited(VersionUpdateLauncher.open(policy));
        },
        onLater: () async {
          Navigator.of(context).pop();
          await ref
              .read(appVersionServiceProvider)
              .dismissOptionalUpdate(policy);
          ref.invalidate(appVersionCheckProvider);
        },
      ),
    );

    _dialogOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    final checkAsync = ref.watch(appVersionCheckProvider);

    return checkAsync.when(
      loading: () => widget.child ?? const SizedBox.shrink(),
      error: (_, _) => widget.child ?? const SizedBox.shrink(),
      data: (result) {
        if (result.requiresForceUpdate && result.policy != null) {
          return ForceUpdateScreen(
            currentVersion: result.currentVersion,
            policy: result.policy!,
            onUpdate: () => VersionUpdateLauncher.open(result.policy!),
          );
        }

        if (result.hasOptionalUpdate) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            unawaited(_showOptionalDialog(result));
          });
        }

        return widget.child ?? const SizedBox.shrink();
      },
    );
  }
}
