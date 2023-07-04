import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../configs/constanst/constants.dart';
import '../widget_button.dart';

class WidgetDialogConfirm extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onTapConfirm;
  final VoidCallback? onTapCancel;
  final bool reversalButton;

  const WidgetDialogConfirm(
      {Key? key,
      required this.title,
      required this.content,
      required this.onTapConfirm,
      this.reversalButton = false,
      this.onTapCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width - 30 * AppValues.scale,
        padding: EdgeInsets.all(16 * AppValues.scale),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10 * AppValues.scale)),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 24 * AppValues.scale),
                  Text(title, style: styleLargeBold),
                  InkWell(
                      onTap: () => Get.back(),
                      child: Icon(Icons.clear, size: 24 * AppValues.scale, color: GREY_04))
                ],
              ),
              SizedBox(height: 8 * AppValues.scale),
              Text(content,
                  style: styleSmall.copyWith(color: GREY_04, fontSize: 13),
                  textAlign: TextAlign.center),
              SizedBox(height: 24 * AppValues.scale),
              reversalButton
                  ? Row(
                      children: [
                        Expanded(
                          child: WidgetButton(
                            padding: 11 * AppValues.scale,
                            text: 'yes'.tr,
                            onTap: onTapConfirm,
                            color: Colors.white,
                            borderColor: Colors.white,
                            colorText: PRIMARY,
                          ),
                        ),
                        SizedBox(width: 10 * AppValues.scale),
                        Expanded(
                          child: WidgetButton(
                            padding: 11 * AppValues.scale,
                            text: 'cancel'.tr,
                            onTap: onTapCancel ?? () => Get.back(),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: WidgetButton(
                            padding: 11 * AppValues.scale,
                            text: 'cancel'.tr,
                            onTap: onTapCancel ?? () => Get.back(),
                            color: Colors.white,
                            borderColor: Colors.white,
                            colorText: PRIMARY,
                          ),
                        ),
                        SizedBox(width: 10 * AppValues.scale),
                        Expanded(
                          child: WidgetButton(
                            padding: 11 * AppValues.scale,
                            text: 'yes'.tr,
                            onTap: onTapConfirm,
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
