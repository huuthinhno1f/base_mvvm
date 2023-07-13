import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import 'widget_my_loading.dart';

typedef DataRequesterWrap = Future<List> Function(int offset);
typedef InitRequesterWrap = Future<List> Function();
typedef ItemBuilderWrap = Widget Function(List data, BuildContext context, int index);

class WidgetLoadMoreWrapVertical<T> extends StatefulWidget {
  const WidgetLoadMoreWrapVertical.build(
      {Key? key,
      required this.itemBuilder,
      required this.dataRequester,
      required this.initRequester,
      this.padding,
      this.spacing,
      this.runSpacing,
      this.styleError,
      this.widgetLoading,
      this.loadingColor,
      this.loadingColorBackground,
      this.physics,
      this.widgetError})
      : super(key: key);

  final TextStyle? styleError;
  final ItemBuilderWrap itemBuilder;
  final DataRequesterWrap dataRequester;
  final InitRequesterWrap initRequester;
  final EdgeInsets? padding;
  final double? spacing;
  final double? runSpacing;
  final Color? loadingColor;
  final Color? loadingColorBackground;
  final Widget? widgetLoading;
  final Widget? widgetError;
  final ScrollPhysics? physics;

  @override
  State createState() => WidgetLoadMoreWrapVerticalState<T>();
}

class WidgetLoadMoreWrapVerticalState<T> extends State<WidgetLoadMoreWrapVertical> {
  bool isPerformingRequest = false;
  final ScrollController _controller = ScrollController();
  List<T>? _dataList;
  List<Widget>? children;

  @override
  void initState() {
    super.initState();
    this.onRefresh();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    children = _dataList
        ?.map((e) => widget.itemBuilder(_dataList!, context, _dataList!.indexOf(e)))
        .toList();
    return this._dataList == null
        ? widget.widgetLoading ?? const MyLoading()
        : (this._dataList!.isNotEmpty
            ? RefreshIndicator(
                backgroundColor: Colors.white,
                color: widget.loadingColor ?? primary,
                onRefresh: this.onRefresh,
                child: SingleChildScrollView(
                  physics: widget.physics,
                  controller: _controller,
                  padding: widget.padding ?? EdgeInsets.zero,
                  child: Wrap(
                    spacing: widget.spacing ?? 8 * AppValues.scale,
                    runSpacing: widget.runSpacing ?? 8 * AppValues.scale,
                    children: children! + [opacityLoadingProgress(isPerformingRequest)],
                  ),
                ),
              )
            : RefreshIndicator(
                backgroundColor: Colors.white,
                color: widget.loadingColor ?? primary,
                onRefresh: this.onRefresh,
                child: Stack(
                  children: [
                    ListView(),
                    Center(child: widget.widgetError ?? const Text("Không có dữ liệu")),
                  ],
                ),
              ));
  }

  Future<void> onRefresh() async {
    if (mounted) setState(() => this._dataList = null);
    List initDataList = await widget.initRequester();
    if (mounted) setState(() => this._dataList = initDataList as List<T>);
    return;
  }

  _loadMore() async {
    if (mounted) {
      setState(() => isPerformingRequest = true);
      int currentSize = 0;
      if (_dataList != null) currentSize = _dataList!.length;

      List<T> newDataList = await widget.dataRequester(currentSize) as List<T>;
      if (newDataList.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom =
            _controller.position.maxScrollExtent - _controller.position.pixels;
        if (offsetFromBottom < edge) {
          _controller.animateTo(_controller.offset - (edge - offsetFromBottom),
              duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
        }
      } else {
        _dataList!.addAll(newDataList);
      }
      if (mounted) setState(() => isPerformingRequest = false);
    }
  }

  Widget opacityLoadingProgress(isPerformingRequest) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: const MyLoading(),
        ),
      ),
    );
  }
}
