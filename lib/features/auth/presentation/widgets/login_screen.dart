import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/login_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/utils/auth_error_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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

    final success = await ref.read(loginControllerProvider.notifier).signIn(
          email: _form.control('email').value as String,
          password: _form.control('password').value as String,
        );

    if (!mounted) {
      return;
    }

    if (success) {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isLoading = ref.watch(
      loginControllerProvider.select((state) => state.isLoading),
    );

    ref.listen(loginControllerProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        final message = authErrorMessage(l10n, next.error!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    });

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.loginTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: ReactiveForm(
            formGroup: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 56.sp,
                  color: colorScheme.primary,
                ),
                SizedBox(height: 16.h),
                Text(
                  l10n.loginSubtitle,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                if (!AppConfig.hasSupabase) ...[
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        l10n.authErrorSupabaseUnavailable,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.error,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
                ReactiveTextField<String>(
                  formControlName: 'email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.username],
                  decoration: InputDecoration(
                    labelText: l10n.loginEmailLabel,
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) => l10n.loginEmailRequired,
                    ValidationMessage.email: (_) => l10n.loginEmailInvalid,
                  },
                ),
                SizedBox(height: 16.h),
                ReactiveTextField<String>(
                  formControlName: 'password',
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  onSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: l10n.loginPasswordLabel,
                    prefixIcon: const Icon(Icons.key_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        l10n.loginPasswordRequired,
                  },
                ),
                SizedBox(height: 32.h),
                FilledButton(
                  onPressed: isLoading || !AppConfig.hasSupabase
                      ? null
                      : _submit,
                  child: isLoading
                      ? SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colorScheme.onPrimary,
                          ),
                        )
                      : Text(l10n.loginSubmit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
