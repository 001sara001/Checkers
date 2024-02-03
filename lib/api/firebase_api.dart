import 'package:firebase_messaging/firebase_messaging.dart';

import '../main.dart';

class FirebaseApi {
  //create instance of FB messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notification
  Future<void> initNotifications() async {
    //request permission from user
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();

    //print the token
    print('Token: $fCMToken');

    initPushNotifications();
  }



  // function to handle received messages
  void handleMessage(RemoteMessage? message) {
    // if the message is null, do nothing
    if (message == null) return;

    // navigate to new screen when message is received and user taps notification
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

// function to initialize background settings
  Future initPushNotifications() async {
// handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

// attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}