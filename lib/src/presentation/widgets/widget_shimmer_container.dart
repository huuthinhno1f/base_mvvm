import 'package:flutter/material.dart';

class WidgetShimmerContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final BorderRadius? borderRadius;

  const WidgetShimmerContainer({Key? key, this.width, this.height, this.radius, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 99)),
    );
  }
}
