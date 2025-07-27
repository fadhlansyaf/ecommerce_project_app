import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_font_weight.dart';
import 'custom_text_style_scheme.dart';

class CustomTextStyle {
  CustomTextStyle._(); // prevent instantiation

  static const Map<String, double> _fontSizes = {
    'xs': 12.0,
    'sm': 14.0,
    'base': 16.0,
    'lg': 18.0,
    'xl': 20.0,
    'x2l': 24.0,
    'x3l': 30.0,
    'x4l': 36.0,
    'x5l': 48.0,
    'x6l': 60.0,
    'x7l': 72.0,
    'x8l': 96.0,
    'x9l': 128.0,
  };

  static CustomTextStyleScheme get xs => _makeScheme(_fontSizes['xs']!);
  static CustomTextStyleScheme get sm => _makeScheme(_fontSizes['sm']!);
  static CustomTextStyleScheme get base => _makeScheme(_fontSizes['base']!);
  static CustomTextStyleScheme get lg => _makeScheme(_fontSizes['lg']!);
  static CustomTextStyleScheme get xl => _makeScheme(_fontSizes['xl']!);
  static CustomTextStyleScheme get x2l => _makeScheme(_fontSizes['x2l']!);
  static CustomTextStyleScheme get x3l => _makeScheme(_fontSizes['x3l']!);
  static CustomTextStyleScheme get x4l => _makeScheme(_fontSizes['x4l']!);
  static CustomTextStyleScheme get x5l => _makeScheme(_fontSizes['x5l']!);
  static CustomTextStyleScheme get x6l => _makeScheme(_fontSizes['x6l']!);
  static CustomTextStyleScheme get x7l => _makeScheme(_fontSizes['x7l']!);
  static CustomTextStyleScheme get x8l => _makeScheme(_fontSizes['x8l']!);
  static CustomTextStyleScheme get x9l => _makeScheme(_fontSizes['x9l']!);

  static CustomTextStyleScheme _makeScheme(double size) {
    return CustomTextStyleScheme(
      thin: _style(size, CustomFontWeight.thin),
      extraLight: _style(size, CustomFontWeight.extraLight),
      light: _style(size, CustomFontWeight.light),
      regular: _style(size, CustomFontWeight.regular),
      medium: _style(size, CustomFontWeight.medium),
      semiBold: _style(size, CustomFontWeight.semiBold),
      bold: _style(size, CustomFontWeight.bold),
      extraBold: _style(size, CustomFontWeight.extraBold),
      black: _style(size, CustomFontWeight.black),
    );
  }

  static TextStyle _style(double size, FontWeight weight) {
    return TextStyle(
      fontWeight: weight,
      fontSize: size.sp,
      fontFamily: 'Inter',
    );
  }
}