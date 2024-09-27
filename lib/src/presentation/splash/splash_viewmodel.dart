import 'dart:async';
import 'package:get/get.dart';
import '../../configs/configs.dart';
import '../presentation.dart';

class SplashViewModel extends BaseViewModel {
  init() async {
    AppValues().init();
    Timer(const Duration(seconds: 2), () => Get.toNamed(Routers.navigation));
  }
}
