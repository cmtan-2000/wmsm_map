import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

Future _notificationDetails() async {
  return const NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          importance: Importance.max, priority: Priority.high));
}

class LocalNotification {
  static final _notifications = FlutterLocalNotificationsPlugin();

  //*listen notifications
  static final onNotifications = BehaviorSubject<String?>();

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) async {
        Logger().wtf("Check Response: ${response.payload}");
        final payload = response.payload;
        onNotifications.add(payload);
        Logger().wtf('on Notifications: $payload');
      },
    );
  }

  static Future clearPayload() {
    onNotifications.add(null);
    return Future.value();
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );
}
