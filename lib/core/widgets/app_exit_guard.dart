import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// On mobile, confirms before the system back action would exit the app.
class AppExitGuard extends StatelessWidget {
  const AppExitGuard({required this.child, super.key});

  final Widget child;

  Future<void> _confirmExit(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.appExitTitle),
        content: Text(l10n.appExitMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.appExitConfirm),
          ),
        ],
      ),
    );

    if (shouldExit == true) {
      await SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (AppPlatform.isWeb) {
      return child;
    }

    return PopScope(
      canPop: Navigator.of(context).canPop(),
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        await _confirmExit(context);
      },
      child: child,
    );
  }
}
