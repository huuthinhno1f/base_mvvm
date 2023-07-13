import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppValues {
  static const String appName = "EROS_PALACE";

  static const double defaultPadding = 15;
  static const double heightFlatButton = 45;

  static const double originalWidth = 375; // width device dùng để xây dựng app
  static const double originalHeight = 812; // height device dùng để xây dựng app

  static late double scaleWidth;
  static late double scaleHeight;

  void init() {
    DeviceScreenType deviceScreenType = SizingInformation(
      deviceScreenType: getDeviceType(Get.size),
      refinedSize: getRefinedSize(
        Get.size,
      ),
      screenSize: Get.size,
      localWidgetSize: Get.size,
    ).deviceScreenType;

    scaleWidth = Get.width / originalWidth;
    scaleHeight = Get.height / originalHeight;
    fontScale = deviceScreenType == DeviceScreenType.mobile ? scale : scaleHeight;
  }

  static double scale = scaleWidth < scaleHeight ? scaleWidth : scaleHeight;
  static double? scaleVertical = scaleHeight;
  static double? scaleHorizontal = scaleWidth;
  static double fontScale = 1;
}
