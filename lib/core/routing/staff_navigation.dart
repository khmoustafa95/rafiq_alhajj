import 'package:flutter/widgets.dart';
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
