import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/configs.dart';

class WidgetEmpty extends StatelessWidget {
  const WidgetEmpty({Key? key, required this.image, required this.title, this.content})
      : super(key: key);
  final String image;
  final String title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 74 * AppValues.scale),
          Image.asset(AppImages.png(image),
              width: 250 * AppValues.scale, height: 187 * AppValues.scale),
          Padding(
            padding: EdgeInsets.only(top: 32 * AppValues.scale, bottom: 7 * AppValues.scale),
            child: Text(title.tr,
                style: styleLargeBold.copyWith(fontSize: 19 * AppValues.scale, color: grey_02)),
          ),
          if (content != null)
            Text(content!.tr,
                style: styleSmall.copyWith(fontSize: 14 * AppValues.scale, color: grey_03))
        ],
      ),
    );
  }
}
