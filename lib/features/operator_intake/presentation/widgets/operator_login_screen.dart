import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/operator_login_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/utils/auth_error_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class OperatorLoginScreen extends ConsumerStatefulWidget {
  const OperatorLoginScreen({super.key});

  @override
  ConsumerState<OperatorLoginScreen> createState() =>
      _OperatorLoginScreenState();
}

class _OperatorLoginScreenState extends ConsumerState<OperatorLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final success = await ref.read(operatorLoginControllerProvider.notifier).signIn(
          email: _emailController.text,
          password: _passwordController.text,
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

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.operatorLoginTitle),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 420.w),
          child: Card(
            margin: EdgeInsets.all(24.w),
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.operatorLoginTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    l10n.operatorLoginSubtitle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: l10n.loginEmailLabel),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: _passwordController,
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
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                  SizedBox(height: 24.h),
                  FilledButton(
                    onPressed: isLoading ? null : _submit,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Text(l10n.loginSubmit),
                  ),
                  SizedBox(height: 12.h),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.adminLogin),
                    child: Text(l10n.operatorGoAdminLogin),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
