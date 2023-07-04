import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

import 'firebase_messaging.dart';
import 'local_notification.dart';
import 'notification_data.dart';

export 'firebase_messaging.dart';
export 'local_notification.dart';
export 'notification_data.dart';

notificationInitialed() {
  FirebaseCloudMessaging.initFirebaseMessaging();
  LocalNotification.setup();
}

final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();
final BehaviorSubject<bool> notificationSubject = BehaviorSubject<bool>();

StreamSubscription? _subscription;

configureSelectNotificationSubject(Function(Data payload) redirect) {
  _subscription = selectNotificationSubject.stream.listen((String? payloadStream) async {
    if (payloadStream == null) return;
    try {
      Data payload = Data.fromJson(jsonDecode(payloadStream));
      redirect(payload);
    } catch (e) {
      print('Error redirect by notification: $e');
    } finally {
      selectNotificationSubject.add(null);
    }
  });
}

unConfigureSelectNotificationSubject() {
  _subscription?.cancel();
  _subscription = null;
}
