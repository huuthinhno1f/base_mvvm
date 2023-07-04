import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class WidgetKeyboardDismiss extends StatelessWidget {
  final Widget child;

  const WidgetKeyboardDismiss({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(child: child);
  }
}
