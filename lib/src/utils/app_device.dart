import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfo {
  String? id;
  String? name;
  String? version;

  DeviceInfo({this.id, this.version, this.name});
}

class AppDeviceInfo {
  AppDeviceInfo._();

  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static DeviceInfo? _deviceInfo;

  static String? get deviceID => _deviceInfo?.id;

  static String? get deviceName => _deviceInfo?.name;

  static String? get deviceVersion => _deviceInfo?.version;

  static Future init() async {
    _deviceInfo = await getDeviceDetails();
    print("AppDeviceInfo: $deviceID - $deviceName - $deviceVersion");
  }

  static Future<DeviceInfo?> getDeviceDetails() async {
    DeviceInfo? device;
    try {
      if (Platform.isAndroid) {
        var info = await _deviceInfoPlugin.androidInfo;
        device = DeviceInfo(
          name: info.model,
          version: info.version.codename,
          id: info.androidId,
        );
      } else if (Platform.isIOS) {
        var info = await _deviceInfoPlugin.iosInfo;
        device = DeviceInfo(
          name: info.name,
          version: info.systemVersion,
          id: info.identifierForVendor,
        );
      }
    } catch (e) {
      print('Failed to get platform version: $e');
    }
    return device;
  }
}
