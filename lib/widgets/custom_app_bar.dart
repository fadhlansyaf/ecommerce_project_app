import 'package:flutter/material.dart';
import 'text_style/custom_text_style.dart';
import 'texts/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final String title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;

  const CustomAppBar({
    Key? key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title = '',
    this.titleWidget,
    this.actions,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: titleWidget ??
          CustomText(
            value: title,
            style: CustomTextStyle.base.semiBold,
          ),
      actions: actions,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      elevation: elevation ?? 0,
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
