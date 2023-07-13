import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

import '../configs/configs.dart';
import '../presentation/widgets/dialog/custom_toast.dart';
import 'app_prefs.dart';

export '../presentation/widgets/dialog/custom_toast.dart';

class AppUtils {
  AppUtils._();
  static const MethodChannel _channel = MethodChannel('com.huesoft/sland');

  static void toast(String? message,
      {Duration? duration,
      NotificationPosition? notificationPosition,
      CustomToastType type = CustomToastType.information}) {
    if (message == null) return;
    showOverlayNotification(
      (context) {
        return CustomToast(
          message: message,
          type: type,
        );
      },
      position: notificationPosition ?? NotificationPosition.top,
      duration: duration ?? const Duration(milliseconds: 2000),
    );
  }

  static const List<String> _themes = ['dark', 'light'];

  static dynamic valueByMode({List<String> themes = _themes, required List<dynamic> values}) {
    try {
      for (int i = 0; i < themes.length; i++) {
        if (AppPrefs.appMode == themes[i]) {
          if (i < values.length) {
            return values[i];
          } else {
            values.first;
          }
        }
      }
      return values.first;
    } catch (e) {
      return values.first;
    }
  }

  static void openGoogleMaps(String latlng) async {
    await _channel.invokeMapMethod<String, dynamic>(
      'open_google_maps',
      <String, dynamic>{'latlng': latlng},
    );
  }

  static String pathMediaToUrl(String? url) {
    if (url == null || url.startsWith('http')) return url ?? '';
    return '${AppEndpoint.baseImageUrl}$url';
  }

  static String convertDateTime2String(DateTime? dateTime, {String format = 'yy-MM-dd'}) {
    if (dateTime == null) return "";
    return DateFormat(format).format(dateTime);
  }

  static DateTime? convertString2DateTime(String? dateTime,
      {String format = "yyyy-MM-ddTHH:mm:ss.SSSZ"}) {
    if (dateTime == null) return null;
    return DateFormat(format).parse(dateTime);
  }

  static String convertString2String(String? dateTime,
      {String inputFormat = "yyyy-MM-ddTHH:mm:ss.SSSZ", String outputFormat = "yyyy-MM-dd"}) {
    if (dateTime == null) return "";
    final input = convertString2DateTime(dateTime, format: inputFormat);
    return convertDateTime2String(input, format: outputFormat);
  }

  static String minimum(int? value) {
    if (value == null) return "00";
    return value < 10 ? "0$value" : "$value";
  }

  static String convertPhoneNumber(String phone, {String code = "+84"}) {
    return '$code${phone.substring(1)}';
  }

  static String convertPrice(price, {bool isCurrency = true}) {
    String result = "";
    try {
      result = isCurrency
          ? "${NumberFormat(",###", "vi").format(price)}đ"
          : NumberFormat(",###", "vi").format(price);
    } catch (e) {}
    return result;
  }

  static void copyToClipBoard(String text) {
    toast("copy_to_clipboard", type: CustomToastType.success);
    Clipboard.setData(ClipboardData(text: text));
  }

  // chuyển qua app khác
  static void openBrowserUrl({required url, bool inApp = false}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      // ignore: deprecated_member_use
      await launch(url, forceSafariVC: inApp, forceWebView: inApp, enableJavaScript: true);
    }
  }

  static Future<void> openMap(String latitude, String longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      // ignore: deprecated_member_use
      await launch(googleUrl, forceSafariVC: false, forceWebView: false, enableJavaScript: true);
    } else {
      throw 'Could not open the map.';
    }
  }
}
