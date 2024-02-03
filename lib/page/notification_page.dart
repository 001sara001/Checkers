
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class notificationPage extends StatelessWidget {
  //String? mtoken = "";
  const notificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    //notification message display on screen
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Page"),
      ),
        body: Column(
          children: [
            Text(message.notification!.title.toString()),
            Text(message.notification!.body.toString()),
            Text(message.data.toString()),
          ],
        ),
    );
  }
}
