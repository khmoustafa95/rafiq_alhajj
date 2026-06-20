import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/operator_login_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/utils/auth_error_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FieldOperatorLoginScreen extends ConsumerStatefulWidget {
  const FieldOperatorLoginScreen({super.key});

  @override
  ConsumerState<FieldOperatorLoginScreen> createState() =>
      _FieldOperatorLoginScreenState();
}

class _FieldOperatorLoginScreenState
    extends ConsumerState<FieldOperatorLoginScreen> {
  late final FormGroup _form;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'email': FormControl<String>(value: ''),
      'password': FormControl<String>(value: ''),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final success = await ref
        .read(operatorLoginControllerProvider.notifier)
        .signIn(
          email: _form.control('email').value as String,
          password: _form.control('password').value as String,
        );
    if (!mounted) {
      return;
    }
    if (success) {
      context.go(AppRoutes.fieldOperatorHome);
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

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.fieldOperatorLoginTitle),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400.w),
              child: ReactiveForm(
                formGroup: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.engineering_outlined,
                      size: 56.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      l10n.fieldOperatorLoginTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      l10n.fieldOperatorLoginSubtitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    ReactiveTextField<String>(
                      formControlName: 'email',
                      decoration:
                          InputDecoration(labelText: l10n.loginEmailLabel),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h),
                    ReactiveTextField<String>(
                      formControlName: 'password',
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: l10n.loginPasswordLabel,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(
                                () => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                      onSubmitted: (_) => _submit(),
                    ),
                    SizedBox(height: 24.h),
                    FilledButton(
                      onPressed: isLoading ? null : _submit,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.loginSubmit),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
