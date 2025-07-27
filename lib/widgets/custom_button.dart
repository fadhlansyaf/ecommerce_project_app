import 'package:demo_project_app/widgets/text_style/custom_text_style.dart';
import 'package:demo_project_app/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.textOnButton = '',
      this.widgetOnButton,
      required this.onPressed,
      this.width = double.infinity,
      this.horizontalPadding,
      this.backgroundColor,
      this.height,
      this.verticalPadding,
      this.textColor,
      this.elevation});

  final String textOnButton;
  final Widget? widgetOnButton;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: elevation,
            padding: EdgeInsets.symmetric(
                vertical: verticalPadding ?? 10.h,
                horizontal: horizontalPadding ?? 0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            backgroundColor:
                backgroundColor ?? Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary),
        child: widgetOnButton ??
            CustomText(
              value: textOnButton,
              style: CustomTextStyle.sm.semiBold,
              color: textColor ?? Colors.white,
            ),
      ),
    );
  }
}
