import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/configs.dart';
import 'widget_animation_staggered_item.dart';

class WidgetAppbar extends StatelessWidget {
  final String? title;
  final VoidCallback? onTapIconBack;
  final Widget? action;
  final Widget? leading;
  final Color? bgColor;
  final TextStyle? style;
  final bool? titleCenter;

  const WidgetAppbar({
    Key? key,
    this.title,
    this.action,
    this.leading,
    this.style,
    this.bgColor,
    this.titleCenter = true,
    this.onTapIconBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetAnimationStaggeredItem(
      index: 1,
      type: AnimationStaggeredType.topToBottom,
      child: Container(
        padding: EdgeInsets.all(16 * AppValues.scale)
            .copyWith(top: 16 * AppValues.scale + Get.mediaQuery.viewPadding.top),
        color: bgColor ?? PRIMARY,
        child: Row(
          children: [
            leading ??
                InkWell(
                  onTap: onTapIconBack ?? () => Get.back(),
                  child: Container(
                    color: PRIMARY,
                    width: 24 * AppValues.scale,
                    height: 24 * AppValues.scale,
                    child: Icon(
                      Icons.keyboard_backspace,
                      color: Colors.white,
                      size: 26 * AppValues.scale,
                    ),
                  ),
                ),
            Expanded(
              child: titleCenter == true
                  ? Center(
                      child: Text(
                        (title ?? "").tr,
                        textAlign: TextAlign.center,
                        style: style ??
                            styleLargeBold.copyWith(
                                fontSize: 18 * AppValues.scale, color: Colors.white),
                      ),
                    )
                  : Text(
                      (title ?? "").tr,
                      style: style ??
                          styleLargeBold.copyWith(
                              fontSize: 18 * AppValues.scale, color: Colors.white),
                    ),
            ),
            action ??
                SizedBox(
                  width: 24 * AppValues.scale,
                  height: 24 * AppValues.scale,
                ),
          ],
        ),
      ),
    );
  }
}
