import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rxdart/rxdart.dart';

import '../../resource/resource.dart';
import '../presentation.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BuildContext? _context;

  BuildContext get context => _context!;

  setContext(BuildContext value) {
    _context = value;
  }

  final loadingSubject = BehaviorSubject<bool>.seeded(false);
  final errorSubject = BehaviorSubject<String>();

  void setLoading(bool loading) {
    if (loading != isLoading) loadingSubject.add(loading);
  }

  bool get isLoading => loadingSubject.value;

  void setError(String message) {
    errorSubject.add(message);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  final AuthRepository authRepository = AuthRepository();
  final OtherRepository otherRepository = OtherRepository();
  final FirebaseRepository firebaseRepository = FirebaseRepository();

  @override
  void dispose() async {
    await loadingSubject.drain();
    loadingSubject.close();
    await errorSubject.drain();
    errorSubject.close();
    super.dispose();
  }

  void unFocus() {
    FocusScope.of(context).unfocus();
  }

  Future<bool?> confirm(String title, String content, VoidCallback onTap) async {
    return await Get.dialog(
        WidgetDialogConfirm(title: title, content: content, onTapConfirm: onTap));
  }

  Future<dynamic> bottomSheet(Widget child, {bool isDismissible = true}) async {
    return await showMaterialModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      builder: (context) => child,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
    );
  }
}
