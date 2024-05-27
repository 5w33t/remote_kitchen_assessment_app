import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_kitchen_assessment_app/app/routes/app_pages.dart';
import 'package:remote_kitchen_assessment_app/firebase_options.dart';
import 'package:remote_kitchen_assessment_app/main.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  handleMessage(message);
}

void handleMessage(RemoteMessage? message) {
  if (message == null) return;

  navigatorKey.currentState?.pushNamed(
    Routes.HOME,
    arguments: message,
  );
}

void messageOnOpenedApp(RemoteMessage? message) {
  if (message == null) return;
  Get.snackbar(
    message.notification?.title ?? '',
    message.notification?.body! ?? '',
    backgroundColor: Colors.blueGrey.shade900,
    colorText: Colors.blueGrey.shade100,
    icon: const Icon(Icons.notifications),
  );
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print(fCMToken);
    initPushNotifications();
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        messageOnOpenedApp(message);
      },
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(
      (message) {
        messageOnOpenedApp(message);
      },
    );
  }
}
