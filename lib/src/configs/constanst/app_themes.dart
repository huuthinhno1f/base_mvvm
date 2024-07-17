import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'constants.dart';

normalTheme(BuildContext context) {
  return ThemeData(
    fontFamily: fontFamilyRoboto,
    brightness: AppUtils.valueByMode(values: [Brightness.dark, Brightness.light]),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: Colors.black),
    ),
  );
}
