import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../configs/configs.dart';

class WidgetPickerImage extends StatelessWidget {
  WidgetPickerImage({Key? key}) : super(key: key);

  final ImagePicker picker = ImagePicker();

  changeImage(bool fromGallery, BuildContext context) async {
    // if (!await Get.find<NavigationViewModel>().checkPermission(fromGallery)) return;
    try {
      final image = await picker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 70,
        maxWidth: 720,
      );
      if (image != null) {
        final imageTemporary = File(image.path);
        Get.back(result: imageTemporary);
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15 * AppValues.scale),
            topRight: Radius.circular(15 * AppValues.scale),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 16 * AppValues.scale, horizontal: 23 * AppValues.scale),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 18 * AppValues.scale),
                Text('Thêm hình ảnh'.tr, style: styleMedium),
                GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.clear, color: GREY_03, size: 18 * AppValues.scale))
              ],
            ),
          ),
          const Divider(height: 1, color: GREY_06, thickness: 0),
          SizedBox(height: 24 * AppValues.scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => changeImage(false, context),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                        height: 100 * AppValues.scale,
                        child: Image.asset(AppImages.png('img_picker_camera'))),
                    Positioned(
                      bottom: 20 * AppValues.scale,
                      child: Text(
                        'Chụp ảnh'.tr,
                        style: styleSmall.copyWith(fontSize: 12 * AppValues.scale, color: GREY_02),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 60 * AppValues.scale),
              GestureDetector(
                onTap: () => changeImage(true, context),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                        height: 100 * AppValues.scale,
                        child: Image.asset(AppImages.png('img_picker_store'))),
                    Positioned(
                      bottom: 20 * AppValues.scale,
                      child: Text(
                        'Thư viện'.tr,
                        style: styleSmall.copyWith(fontSize: 12 * AppValues.scale, color: GREY_02),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 48 * AppValues.scale)
        ],
      ),
    );
  }
}
