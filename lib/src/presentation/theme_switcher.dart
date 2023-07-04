import 'package:flutter/material.dart';

class ThemeSwitcher extends InheritedWidget {
  final _ThemeSwitcherWidgetState data;

  const ThemeSwitcher({Key? key, required this.data, required Widget child})
      : super(child: child, key: key);

  static _ThemeSwitcherWidgetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeSwitcher>()!.data;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return this != oldWidget;
  }
}

class ThemeSwitcherWidget extends StatefulWidget {
  final Widget child;
  final ThemeData initialThemeData;

  const ThemeSwitcherWidget(
      {Key? key, required this.child, required this.initialThemeData})
      : super(key: key);

  @override
  _ThemeSwitcherWidgetState createState() => _ThemeSwitcherWidgetState();
}

class _ThemeSwitcherWidgetState extends State<ThemeSwitcherWidget> {
  ThemeData? themeData;

  void switchMode({ThemeData? themeData}) {
    setState(() {
      if (themeData != null) this.themeData = themeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    themeData = themeData ?? widget.initialThemeData;
    return ThemeSwitcher(
      data: this,
      child: widget.child,
    );
  }
}
