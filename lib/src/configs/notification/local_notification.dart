import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_data.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails? notificationAppLaunchDetails;

class LocalNotification {
  static const String _id = '_ID';
  static const String _channel = '_Channel';
  static const String _description = '_Description';

  static setup() async {
    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    var initializationSettingsAndroid = const AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          flutterLocalNotificationsPlugin.cancel(id);
        });
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
      Data payloadData = Data.fromJson(jsonDecode(notificationResponse.payload!));
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
        case NotificationResponseType.selectedNotificationAction:
          onClickNotification(payloadData);
          break;
      }
    });
  }

  static Future<void> showNotification(String? title, String? body, String? payload) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(_id, _channel,
        channelDescription: _description,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        ticker: 'ticker',
        icon: 'ic_launcher');
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
        presentSound: true,
        presentBadge: true,
        presentAlert: true);
    const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(2147483647);
    await flutterLocalNotificationsPlugin.show(notificationId, title ?? 'Say hi!',
        body ?? 'Nice to meet you again!', platformChannelSpecifics,
        payload: payload);
  }

  static onClickNotification(Data data) async {}
}
