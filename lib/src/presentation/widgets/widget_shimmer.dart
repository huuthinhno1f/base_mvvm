import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WidgetShimmer extends StatelessWidget {
  final Widget child;

  const WidgetShimmer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: child,
    );
  }
}
