import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Pops when the stack allows it; otherwise [GoRouter.go] to [fallbackRoute].
///
/// Staff web list pages open edit screens with [GoRouter.go], so [GoRouter.pop]
/// throws when cancel/back is pressed on those routes.
void staffNavigateBack(
  BuildContext context, {
  required String fallbackRoute,
}) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go(fallbackRoute);
  }
}

/// Back control for staff web sub-routes (edit/detail pages).
class StaffBackButton extends StatelessWidget {
  const StaffBackButton({required this.fallbackRoute, super.key});

  final String fallbackRoute;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () =>
          staffNavigateBack(context, fallbackRoute: fallbackRoute),
    );
  }
}
