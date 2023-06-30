import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/main.dart';

//*Notification API for Firebase cloud messaging

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  Logger().i('Title: ${message.notification?.title}');
  Logger().i('Body: ${message.notification?.body}');
  Logger().i('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('notification');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(
      settings,

      //*Handle local notification when user tap on it
      onDidReceiveNotificationResponse: (payload) {
        final msg = RemoteMessage.fromMap(jsonDecode(payload as String));
        handleMessage(msg);
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    //*initialize user
    // Provider.of<UserViewModel>(context, listen: false).setUser();

    //*homepage notification
    MyApp.navigatorKey.currentState!.pushNamed('/');
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //*perform action when app is open from terminated state, via notification
    _firebaseMessaging.getInitialMessage().then(handleMessage);

    //*call when user click notifcation when app in background
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    //*when app terminated
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/notif1',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    //request permission from user
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();

    //*FCM token is used to send notification to a specific device
    Logger().wtf('FCM Token: $fcmToken');
    initPushNotifications();

    //local notification
    initLocalNotifications();
  }
}
