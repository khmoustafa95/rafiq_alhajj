import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/language_switcher.dart';

/// App bar with the language switcher appended to [actions].
class RafiqAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RafiqAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.centerTitle,
    this.bottom,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
  });

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final bool? centerTitle;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;

  @override
  Size get preferredSize {
    return Size.fromHeight(
      kToolbarHeight + (bottom?.preferredSize.height ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      bottom: bottom,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      actions: [
        ...?actions,
        const LanguageSwitcherAppBarAction(compact: true),
      ],
    );
  }
}
