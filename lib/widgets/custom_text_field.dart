import 'package:demo_project_app/widgets/text_style/custom_text_style.dart';
import 'package:demo_project_app/widgets/texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    required this.controller,
    this.suffixIcon,
    this.isRequired = true,
    this.enabled = true,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.errorText,
    this.onSubmitted,
    this.obscureText = false,
    this.suffix,
    this.isRupiah = false,
    this.verticalMargin,
    this.textAlign,
    this.maxLines = 1,
    this.onChanged,
  });

  final String? label;
  final String? hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool isRequired;
  final bool enabled;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Function(String)? onSubmitted;
  final String? errorText;
  final bool obscureText;
  final Widget? suffix;
  final bool isRupiah;
  final double? verticalMargin;
  final TextAlign? textAlign;
  final int? maxLines;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    // If isRupiah is true, add a listener to the controller
    if (isRupiah) {
      controller.addListener(() {
        String input = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
        if (input.isEmpty) {
          controller.value = TextEditingValue(
            text: '',
            selection: TextSelection.collapsed(offset: 0),
          );
          return;
        }
        final formatter = NumberFormat.currency(
          locale: 'id_ID',
          symbol: 'Rp',
          decimalDigits: 0,
        );
        String formatted = formatter.format(int.parse(input));
        controller.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      });
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin ?? 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[
            Row(
              children: [
                CustomText(
                  value: label!,
                  style: CustomTextStyle.sm.medium,
                ),
                SizedBox(
                  width: 2.w,
                ),
                if (isRequired)
                  CustomText(
                    value: '*',
                    style: CustomTextStyle.sm.medium.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    color: Theme.of(context).colorScheme.error,
                  ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
          TextField(
            controller: controller,
            obscureText: obscureText,
            textAlign: textAlign ?? TextAlign.start,
            maxLines: maxLines,
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: !enabled,
              enabled: enabled,
              fillColor:
                  enabled ? null : Theme.of(context).colorScheme.outlineVariant,
              hintText: hintText,
              hintStyle: CustomTextStyle.base.light,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              suffixIcon: suffixIcon,
              suffix: suffix,
              errorText: errorText,
              errorStyle: CustomTextStyle.sm.medium.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            textInputAction: textInputAction,
            keyboardType: isRupiah
                ? TextInputType.number
                : textInputType, // Force numeric keyboard if Rupiah
            onSubmitted: onSubmitted,
          ),
        ],
      ),
    );
  }
}
