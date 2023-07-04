import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../configs/configs.dart';

class MyLoading extends StatelessWidget {
  final bool opacity;
  final Color? color;
  final double? size;

  const MyLoading({Key? key, this.opacity = true, this.color, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: opacity
            ? Center(
                child: SpinKitCircle(color: color ?? PRIMARY, size: size ?? 50 * AppValues.scale))
            : SizedBox(height: 50 * AppValues.scale, width: 50 * AppValues.scale));
  }
}
