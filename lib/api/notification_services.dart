/*import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestNotificationPermission () async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,

    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized){
      print ('User granted permission');
    }
    else if (settings.authorizationStatus == AuthorizationStatus.authorized){
      print('User granted provisional permission');

    } else {
      print('User has denied permission.');

    }
  }

  Future <String> getDeviceToken () async {
    String? token = await messaging.getAPNSToken();

    return token!;

  }

}

 */