import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('some notification is received');
  }
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission(
      sound: true,
      alert: true,
      announcement: true,
      badge: true,
    );
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
