import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/utils/staff_error_message.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Consistent staff error state with optional retry and network hint.
class StaffErrorView extends StatelessWidget {
  const StaffErrorView({
    required this.message,
    this.error,
    this.icon = Icons.error_outline,
    this.onRetry,
    super.key,
  });

  factory StaffErrorView.fromError(
    AppLocalizations l10n, {
    required Object error,
    VoidCallback? onRetry,
  }) {
    final isNetwork = isStaffNetworkError(error);
    return StaffErrorView(
      message: staffErrorMessage(l10n, error),
      error: error,
      icon: isNetwork ? Icons.wifi_off_rounded : Icons.error_outline,
      onRetry: onRetry,
    );
  }

  final String message;
  final Object? error;
  final IconData icon;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return StaffEmptyState(
      message: message,
      icon: icon,
      actionLabel: onRetry != null ? l10n.retry : null,
      onAction: onRetry,
    );
  }
}
