import 'package:flutter/material.dart';

typedef DataRequester<T> = Future<List<T>> Function(int offset);
typedef InitRequester<T> = Future<List<T>> Function();
typedef ItemBuilder<T> = Widget Function(List<T> data, BuildContext context, int index);

/*

    ===== View =====
    WidgetLoadMoreWrapVertical<ForumPostModel>.build(
      key: _viewModel.keyListView,
      padding: const EdgeInsets.only(
          bottom: NavigationScreen.HEIGHT_BOTTOM_NAV_TOTAL + 10,
          top: 10),
      itemBuilder: _buildItemForum,
      dataRequester: _viewModel.dataRequester,
      initRequester: _viewModel.initRequester)

    ===== ViewModel =====
    //Key for manage state in widget
    final GlobalKey<WidgetLoadMoreWrapVerticalState> keyLoadMoreWrapVertical = GlobalKey();

    Future<List<ForumPostModel>> initRequester() async {
      return await getForumPosts(0);
    }

    Future<List<ForumPostModel>> dataRequester(int offset) async {
      return await getForumPosts(offset);
    }

    getForumPosts(int offset) async {
      List<ForumPostModel> data = List<ForumPostModel>();
      NetworkState<List<ForumPostModel>> networkState =
          await forumRepository.getForumPostByCategory(
              offset: offset,
              categoryID: currentCategorySubject.value?.loaikynangId);
      if (networkState.isSuccess && networkState.data != null)
        data = networkState.data;
      await Future.delayed(Duration(milliseconds: 500));
      return data;
    }
 */

class WidgetLoadMoreVertical<T> extends StatefulWidget {
  const WidgetLoadMoreVertical.build(
      {Key? key,
      required this.itemBuilder,
      required this.dataRequester,
      required this.initRequester,
      this.styleError,
      this.loadingColor,
      this.widgetError})
      : super(key: key);

  final TextStyle? styleError;
  final ItemBuilder itemBuilder;
  final DataRequester dataRequester;
  final InitRequester initRequester;
  final Color? loadingColor;
  final Widget? widgetError;

  @override
  State createState() => WidgetLoadMoreVerticalState<T>();
}

class WidgetLoadMoreVerticalState<T> extends State<WidgetLoadMoreVertical> {
  bool isPerformingRequest = false;
  final ScrollController _controller = ScrollController();
  List<T>? _dataList;

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
    Color loadingColor = widget.loadingColor ?? Theme.of(context).primaryColor;
    return this._dataList == null
        ? loadingProgress(loadingColor)
        : (this._dataList!.isNotEmpty
            ? RefreshIndicator(
                color: loadingColor,
                onRefresh: this.onRefresh,
                child: ListView.builder(
                  itemCount: _dataList!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _dataList!.length) {
                      return opacityLoadingProgress(
                          isPerformingRequest, loadingColor);
                    } else {
                      return widget.itemBuilder(_dataList!, context, index);
                    }
                  },
                  controller: _controller,
                  padding: const EdgeInsets.all(0),
                ),
              )
            : RefreshIndicator(
                color: loadingColor,
                onRefresh: this.onRefresh,
                child: Stack(
                  children: [
                    ListView(),
                    Center(
                        child: widget.widgetError ??
                            const Text(
                              "Không có dữ liệu",
                            )),
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

  Widget loadingProgress(loadingColor) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
      ),
    );
  }

  Widget opacityLoadingProgress(isPerformingRequest, loadingColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
          ),
        ),
      ),
    );
  }
}
