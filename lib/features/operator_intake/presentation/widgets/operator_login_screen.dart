import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_login_scaffold.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/operator_login_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/utils/auth_error_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class OperatorLoginScreen extends ConsumerStatefulWidget {
  const OperatorLoginScreen({super.key});

  @override
  ConsumerState<OperatorLoginScreen> createState() =>
      _OperatorLoginScreenState();
}

class _OperatorLoginScreenState extends ConsumerState<OperatorLoginScreen> {
  late final FormGroup _form;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'email': FormControl<String>(
        value: '',
        validators: [
          Validators.delegate((control) {
            final trimmed = (control.value as String?)?.trim() ?? '';
            if (trimmed.isEmpty) {
              return {ValidationMessage.required: true};
            }
            if (!trimmed.contains('@')) {
              return {ValidationMessage.email: true};
            }
            return null;
          }),
        ],
      ),
      'password': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }

    final success = await ref.read(operatorLoginControllerProvider.notifier).signIn(
          email: _form.control('email').value as String,
          password: _form.control('password').value as String,
        );
    if (!mounted) {
      return;
    }
    if (success) {
      context.go(AppRoutes.operatorIntake);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isLoading = ref.watch(
      operatorLoginControllerProvider.select((state) => state.isLoading),
    );

    ref.listen(operatorLoginControllerProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authErrorMessage(l10n, next.error!))),
        );
      }
    });

    return StaffWebLoginScaffold(
      title: l10n.operatorLoginTitle,
      subtitle: l10n.operatorLoginSubtitle,
      icon: Icons.groups_outlined,
      highlights: [
        StaffLoginHighlight(
          icon: Icons.person_add_alt_1_outlined,
          label: l10n.staffLoginHighlightRegistration,
        ),
        StaffLoginHighlight(
          icon: Icons.folder_shared_outlined,
          label: l10n.staffLoginHighlightDocuments,
        ),
        StaffLoginHighlight(
          icon: Icons.sync_outlined,
          label: l10n.staffLoginHighlightRegistry,
        ),
      ],
      form: ReactiveForm(
        formGroup: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReactiveTextField<String>(
              formControlName: 'email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.username],
              decoration: InputDecoration(
                labelText: l10n.loginEmailLabel,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              validationMessages: {
                ValidationMessage.required: (_) => l10n.loginEmailRequired,
                ValidationMessage.email: (_) => l10n.loginEmailInvalid,
              },
            ),
            const SizedBox(height: 16),
            ReactiveTextField<String>(
              formControlName: 'password',
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: l10n.loginPasswordLabel,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
              validationMessages: {
                ValidationMessage.required: (_) => l10n.loginPasswordRequired,
              },
            ),
            const SizedBox(height: 28),
            FilledButton(
              onPressed: isLoading ? null : _submit,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l10n.loginSubmit),
            ),
          ],
        ),
      ),
      footer: Column(
        children: [
          const Divider(),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => context.go(AppRoutes.adminLogin),
            icon: const Icon(Icons.analytics_outlined),
            label: Text(l10n.operatorGoAdminLogin),
          ),
        ],
      ),
    );
  }
}
