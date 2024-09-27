import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DatePickerTheme with DiagnosticableTreeMixin {
  final Widget? iconCancel;
  final double titleHeight;
  final String? title;
  final TextStyle itemStyle;
  final TextStyle titleStyle;
  final Color backgroundColor;
  final Color? headerColor;
  final bool showButton;
  final Color? buttonColor;
  final Color? buttonColorBorder;
  final String? buttonTitle;
  final TextStyle? buttonTitleStyle;

  final double containerHeight;
  final double itemHeight;

  const DatePickerTheme({
    this.iconCancel,
    this.title,
    this.titleHeight = 44,
    this.itemStyle = const TextStyle(color: Color(0xFF000046), fontSize: 18),
    this.titleStyle = const TextStyle(color: Color(0xFF000046), fontSize: 18),
    this.backgroundColor = Colors.white,
    this.headerColor,
    this.buttonColor,
    this.buttonColorBorder,
    this.containerHeight = 210.0,
    this.itemHeight = 36.0,
    this.showButton = true,
    this.buttonTitle,
    this.buttonTitleStyle,
  });
}
