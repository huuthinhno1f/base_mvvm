import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';

class WidgetDialogRequiresLogin extends StatelessWidget {
  const WidgetDialogRequiresLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: Get.width - 56 * AppValues.scale,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16 * AppValues.scale)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20 * AppValues.scale),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40 * AppValues.scale),
                  child:
                      Text('notification'.tr, style: styleLargeBold, textAlign: TextAlign.center)),
              Column(
                children: [
                  SizedBox(height: 15 * AppValues.scale),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36 * AppValues.scale),
                    child: Text('confirm_sign_in'.tr,
                        style: styleSmall.copyWith(color: grey_03), textAlign: TextAlign.center),
                  )
                ],
              ),
              SizedBox(height: 32 * AppValues.scale),
              const Divider(thickness: 1, color: Color(0xFFE9EAED), height: 0),
              Row(
                children: [
                  _buildItemButton('cancel'.tr),
                  Container(width: 1, height: 44 * AppValues.scale, color: const Color(0xFFE9EAED)),
                  _buildItemButton('yes'.tr, onTap: () => Get.back()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemButton(String title, {VoidCallback? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap ?? () => Get.back(),
        child: SizedBox(
          height: 40 * AppValues.scale,
          child: Center(
            child: Text(title,
                style: styleMediumBold.copyWith(
                  color: onTap != null ? blue : grey_03,
                )),
          ),
        ),
      ),
    );
  }
}
