import 'dart:async';

import 'package:get/get.dart';

import '../presentation.dart';

class SplashViewModel extends BaseViewModel {
  init() async {
    Timer(const Duration(seconds: 2), () => Get.toNamed(Routers.navigation));
  }
}
