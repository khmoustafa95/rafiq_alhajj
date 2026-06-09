import 'package:flutter/material.dart';

/// Centers pilgrim competition content and caps width on tablet / desktop web.
class CompetitionPageConstraint extends StatelessWidget {
  const CompetitionPageConstraint({
    required this.child,
    this.maxWidth = 720,
    super.key,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
