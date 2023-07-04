import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../presentation.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  /*
    child, childDesktop, childMobile, childTablet:
    Its widget not listen on consumer
    Use to paint to widget not change(Appbar, background....)
   */
  final Widget? child;
  final Widget? childDesktop;
  final Widget? childMobile;
  final Widget? childTablet;

  final Widget Function(BuildContext context, T viewModel, Widget? child) builder;
  final T viewModel;
  final Function(T viewModel)? onViewModelReady;

  BaseWidget({
    Key? key,
    required this.builder,
    required this.viewModel,
    this.child,
    this.childDesktop,
    this.childMobile,
    this.childTablet,
    this.onViewModelReady,
  }) : super(key: key) {
    Get.put(viewModel);
  }

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> with ResponsiveWidget {
  T? viewModel;

  @override
  void initState() {
    viewModel = widget.viewModel;
    if (widget.onViewModelReady != null) {
      widget.onViewModelReady!(viewModel!);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<T>();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => viewModel!..setContext(context),
      child: KeyboardDismisser(
        child: Consumer<T>(
          builder: (_, viewModel, child) => WidgetLoadingFullScreen(
            loading: viewModel.loadingSubject,
            child: widget.builder(_, viewModel, child),
          ),
          child: buildUi(context, defaultWidget: widget.child),
        ),
      ),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return widget.childDesktop ?? widget.child ?? const SizedBox();
  }

  @override
  Widget buildMobile(BuildContext context) {
    return widget.childMobile ?? widget.child ?? const SizedBox();
  }

  @override
  Widget buildTablet(BuildContext context) {
    return widget.childDesktop ?? widget.child ?? const SizedBox();
  }
}

abstract class ResponsiveWidget {
  static dynamic valueByWidth(context, value, {desktop, tablet, mobile}) {
    if (MediaQuery.of(context).size.width > 1024) return desktop ?? value;
    if (MediaQuery.of(context).size.width > 600) return tablet ?? value;
    return mobile ?? value;
  }

  static dynamic valueByType(DeviceScreenType type, {desktop, tablet, mobile}) {
    switch (type) {
      case DeviceScreenType.desktop:
        return desktop;
      case DeviceScreenType.tablet:
        return tablet;
      case DeviceScreenType.mobile:
        return mobile;
      default:
        return mobile;
    }
  }

  Widget buildDesktop(BuildContext context);

  Widget buildTablet(BuildContext context);

  Widget buildMobile(BuildContext context);

  Widget buildUi(BuildContext context, {Widget? defaultWidget}) {
    return ResponsiveBuilder(builder: (context, sizeInfo) {
      if (sizeInfo.deviceScreenType == DeviceScreenType.desktop) {
        return buildDesktop(context);
      } else if (sizeInfo.deviceScreenType == DeviceScreenType.tablet) {
        return buildTablet(context);
      } else if (sizeInfo.deviceScreenType == DeviceScreenType.mobile) {
        return buildMobile(context);
      }
      return defaultWidget ?? const SizedBox();
    });
  }
}
