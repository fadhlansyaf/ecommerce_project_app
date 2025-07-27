import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import '../text_style/custom_text_style.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.value,
    required this.style,
    this.color,
    this.maxLines,
    this.textDecoration,
    this.overflow,
    this.textAlign,
    this.fontSize,
    this.opacity,
    this.useAnimatedOverflow = false,
  });

  final String value;
  final TextStyle? style;
  final Color? color;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? fontSize;
  final double? opacity;
  final bool useAnimatedOverflow;

  Color getColor(BuildContext context) {
    if (color == null) return Theme.of(context).colorScheme.onSurface;
    return color!;
  }

  TextStyle _getTextStyle(BuildContext context) {
    return style?.copyWith(
          color: opacity == null
              ? getColor(context)
              : getColor(context).withOpacity(opacity!),
          fontSize: fontSize,
        ) ??
        CustomTextStyle.base.regular.copyWith(
          color: opacity == null
              ? getColor(context)
              : getColor(context).withOpacity(opacity!),
          fontSize: fontSize,
        );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = _getTextStyle(context);

    if (useAnimatedOverflow) {
      return ClipRect(
        child: SizedBox(
          width: double.infinity,
          child: Marquee(
            text: value,
            style: textStyle,
            blankSpace: 20.0,
            pauseAfterRound: const Duration(seconds: 3),
            startAfter: const Duration(seconds: 2),
          ),
        ),
      );
    }

    return Text(
      value,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: textStyle,
    );
  }
}
