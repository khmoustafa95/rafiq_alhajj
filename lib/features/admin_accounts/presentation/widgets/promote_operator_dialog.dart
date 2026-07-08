import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/admin_accounts/presentation/providers/admin_accounts_providers.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_account.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class PromoteOperatorDialog extends ConsumerStatefulWidget {
  const PromoteOperatorDialog({
    required this.operator,
    super.key,
  });

  final OperatorAccount operator;

  @override
  ConsumerState<PromoteOperatorDialog> createState() =>
      _PromoteOperatorDialogState();
}

class _PromoteOperatorDialogState extends ConsumerState<PromoteOperatorDialog> {
  bool _submitting = false;

  Future<void> _confirm() async {
    if (_submitting) {
      return;
    }
    setState(() => _submitting = true);

    final ok = await ref
        .read(adminAccountPromoteProvider.notifier)
        .promoteOperator(widget.operator.id);

    if (!mounted) {
      return;
    }

    if (ok) {
      Navigator.of(context).pop(true);
      return;
    }

    setState(() => _submitting = false);
    final error = ref.read(adminAccountPromoteProvider).error;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error?.toString() ?? l10n.adminAccountPromoteError,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final operator = widget.operator;

    return AlertDialog(
      title: Text(l10n.adminAccountPromoteTitle),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.adminAccountPromoteMessage(operator.fullName, operator.email),
            ),
            SizedBox(height: 12.h),
            Text(
              l10n.adminAccountPromoteHint,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(false),
          child: Text(l10n.dialogCancel),
        ),
        FilledButton(
          onPressed: _submitting ? null : _confirm,
          child: _submitting
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : Text(l10n.adminAccountPromoteConfirm),
        ),
      ],
    );
  }
}

Future<bool?> showPromoteOperatorDialog(
  BuildContext context,
  OperatorAccount operator,
) {
  return showDialog<bool>(
    context: context,
    builder: (context) => PromoteOperatorDialog(operator: operator),
  );
}
