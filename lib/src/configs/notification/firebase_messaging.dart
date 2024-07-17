import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notification.dart';
import 'notification_data.dart';

class FirebaseCloudMessaging {
  static final FirebaseMessaging instance = FirebaseMessaging.instance;

  static initFirebaseMessaging() async {
    if (Platform.isIOS) {
      await instance.requestPermission();
    }
    FirebaseMessaging.onMessage.listen((message) {
      log("OnMessage: ${message.data}");
      Platform.isAndroid ? _handler(message) : null;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("OnMessageOpenedApp: ${message.data}");
      Data payloadData = Data.fromJson(message.data);
      onClickNotification(payloadData);
    });
    // FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    // final initMessage = await FirebaseMessaging.instance.getInitialMessage();
    // if (initMessage != null) _handler(initMessage);
  }

  static _handler(RemoteMessage message) {
    if (message.notification != null) {
      Data payload = Data.fromJson(message.data);
      LocalNotification.showNotification(
          message.notification?.title, message.notification?.body, payload.toString());
    }
  }

  static onClickNotification(Data data) async {}
}
