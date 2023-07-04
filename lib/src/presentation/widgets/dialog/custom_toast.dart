import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';

enum CustomToastType {
  neutral,
  information,
  success,
  warning,
  error,
}

class CustomToast extends StatelessWidget {
  final CustomToastType type;
  final String message;
  const CustomToast({Key? key, this.type = CustomToastType.neutral, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: Get.width,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: getColor(),
          ),
          child: Text(
            message.tr,
            textAlign: TextAlign.left,
            style: styleSmall.copyWith(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Color getColor() {
    switch (type) {
      case CustomToastType.neutral:
        return GREY_05;
      case CustomToastType.information:
        return const Color(0xFF1697F4);
      case CustomToastType.success:
        return const Color(0xFF5AC926);
      case CustomToastType.warning:
        return const Color(0xFFF6B100);
      case CustomToastType.error:
        return const Color(0xFFFF5238);
    }
  }
}
