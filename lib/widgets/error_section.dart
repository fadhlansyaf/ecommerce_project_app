import 'package:demo_project_app/widgets/custom_button.dart';
import 'package:demo_project_app/widgets/text_style/custom_text_style.dart';
import 'package:demo_project_app/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorSection extends StatelessWidget {
  const ErrorSection({
    super.key,
    this.onTapRefresh,
    this.usePadding = true,
    this.errorMessage,
  });

  final void Function()? onTapRefresh;
  final bool usePadding;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWidthUnbounded = constraints.maxWidth == double.infinity;
        bool isHeightUnbounded = constraints.maxHeight == double.infinity;

        return SizedBox(
          width: isWidthUnbounded
              ? 300.w
              : double.infinity, // Fallback width if unbounded
          height: isHeightUnbounded
              ? 400.h
              : double.infinity, // Fallback height if unbounded
          child: Padding(
            padding: usePadding
                ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h)
                : EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.bus_alert),
                CustomText(
                  value: "Ooops, Something went wrong",
                  style: CustomTextStyle.base.bold,
                ),
                CustomText(
                  value: errorMessage ??
                      "Check your internet connection and restart the app",
                  style: CustomTextStyle.sm.regular,
                  color: Theme.of(context).colorScheme.onSurface,
                  textAlign: TextAlign.center,
                ),
                if (onTapRefresh != null) ...[
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomButton(
                    onPressed: onTapRefresh,
                    textOnButton: "Refresh Page",
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
