import '../constanst/app_values.dart';

extension ScaleExtensions on num {
  double get sc => this * AppValues.scale;
}
