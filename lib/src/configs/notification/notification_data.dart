import 'dart:convert';

class FirebaseNotification {
  Notification? notification;
  Data? data;

  FirebaseNotification(
    this.notification,
    this.data,
  );

  factory FirebaseNotification.fromJson(Map<String, dynamic> json) => FirebaseNotification(
        json['notification'] == null
            ? null
            : Notification.fromJson((json['notification'] as Map).map(
                (k, e) => MapEntry(k as String, e),
              )),
        json['data'] == null
            ? null
            : Data.fromJson((json['data'] as Map).map(
                (k, e) => MapEntry(k as String, e),
              )),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'notification': notification,
        'data': data,
      };

  @override
  String toString() {
    return 'FirebaseNotification{notification: $notification, data: $data}';
  }
}

class Data {
  final String? id;
  final String? type;

  Data({this.id, this.type});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "type": type,
      };

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class Notification {
  String title;
  String body;

  Notification(
    this.title,
    this.body,
  );

  factory Notification.fromJson(Map<String, dynamic>? json) => Notification(
        json?['title'] as String,
        json?['body'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'body': body,
      };

  @override
  String toString() {
    return '{}';
  }
}
