import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/bootstrap/bootstrap_localizations.dart';
import 'package:rafiq_alhajj/core/theme/app_theme.dart';

/// Minimal app shown when [AppBootstrap.initialize] fails.
class BootstrapFailureApp extends StatelessWidget {
  const BootstrapFailureApp({
    required this.error,
    this.onRetry,
    super.key,
  });

  final Object error;
  final Future<void> Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = resolveBootstrapLocalizations();
    final textDirection = l10n.localeName.startsWith('ar')
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: _BootstrapFailureScreen(
          error: error,
          onRetry: onRetry,
        ),
      ),
    );
  }
}

class _BootstrapFailureScreen extends StatefulWidget {
  const _BootstrapFailureScreen({
    required this.error,
    this.onRetry,
  });

  final Object error;
  final Future<void> Function()? onRetry;

  @override
  State<_BootstrapFailureScreen> createState() =>
      _BootstrapFailureScreenState();
}

class _BootstrapFailureScreenState extends State<_BootstrapFailureScreen> {
  late Object _error = widget.error;
  bool _isRetrying = false;

  Future<void> _handleRetry() async {
    final retry = widget.onRetry;
    if (retry == null || _isRetrying) {
      return;
    }

    setState(() => _isRetrying = true);

    try {
      await retry();
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e;
          _isRetrying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = resolveBootstrapLocalizations();
    final theme = AppTheme.light;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.error_outline,
                size: 56,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                l10n.bootstrapErrorTitle,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.bootstrapErrorMessage,
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              if (widget.onRetry != null) ...[
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: _isRetrying ? null : _handleRetry,
                  child: _isRetrying
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.retry),
                ),
              ],
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _error.toString(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
