import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails? notificationAppLaunchDetails;

class LocalNotification {
  static const String _id = '_ID';
  static const String _channel = '_Channel';
  static const String _description = '_Description';

  static setup() async {
    //setup local notification
    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    var initializationSettingsAndroid = const AndroidInitializationSettings('launcher_icon');
    // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
    // of the `IOSFlutterLocalNotificationsPlugin` class
    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          selectNotificationSubject.add(payload);
          flutterLocalNotificationsPlugin.cancel(id);
        });
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationSubject.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == 'id_3') {
            selectNotificationSubject.add(notificationResponse.payload);
          }
          break;
      }
    });
  }

  static Future<void> showNotification(String? title, String? body, String? payload) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(_id, _channel,
        channelDescription: _description,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '${title ?? 'Say hi!'} ', body ?? 'Nice to meet you again!', platformChannelSpecifics,
        payload: payload);
  }
}
