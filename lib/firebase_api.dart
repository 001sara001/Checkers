import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:untitled1/main.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/model/UserModel.dart';

import '../login/Homepage/ChatRoomModel.dart';

class FirebaseApi{
  //create instance massage
  final _firebaseMessaging = FirebaseMessaging.instance;


  //initialize notification
Future<void> initNotification() async{
  //request permission

  await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  // for token
  final fCMToken = await _firebaseMessaging.getToken();

  // print token
  print('Token : $fCMToken');
  print('########################');

  ////setting for push notification
  //initPushNotification();

}


void saveToken(String fCMToken) async{
  //Store in firebase
  await FirebaseFirestore.instance.collection("User Token").doc("user2").set({
    'token' : fCMToken,
  });
}

void handleMessage(RemoteMessage? message){
  // if message in null
  if(message==null) return;

  // message given navigate to that page
  navigatorKey.currentState?.pushNamed(
      '/notification_screen',
          arguments: message,
  );
}
Future initPushNotification( ) async{
  //if app is terminate
  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

  // if app is open
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  try{
    var data=
    {
      // recieve msg info
      //'to':chatroomid.fCMToken(),
      'notication': {
        'title' : "New message",
    'body': "unread message",
    },
    };
    // my device
    var res = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body: jsonEncode(data),
      headers: {
        HttpHeaders.contentTypeHeader : 'application/json',
        HttpHeaders.authorizationHeader:
        'key =AAAAlMTNcs4:APA91bEQOsXlEvyXofPMpV8krg0Bw7qIuPz_4lj17G10ebFBgShHqS8_qI6kFVHA4Ro4Mc6D5Zf1UgIRyWPHku9zJR3K-yt4NVoaxgRMc5RXSoacjQOClYXdz6Sw5KJAtfRwJbMywnJo'
      },
    );
    print('Response status: ${res.statusCode}');
    print('Response body: ${res.body}');

  }
  catch(e){
    print('\notification_screen : $e');
  }

}

}
