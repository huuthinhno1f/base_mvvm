import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../configs/configs.dart';

class WidgetLoadingFullScreen extends StatelessWidget {
  final Widget child;
  final Stream<bool> loading;

  const WidgetLoadingFullScreen({Key? key, required this.child, required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        StreamBuilder<bool>(
            stream: loading,
            builder: (_, snapshot) {
              bool status = snapshot.data ?? false;
              return status ? _LoadingWidget() : Container();
            }),
      ],
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black38,
        constraints: const BoxConstraints.expand(),
        alignment: Alignment.center,
        child: const Center(
            child: SpinKitCircle(
          color: brand_01,
          size: 55,
        )));
  }
}
