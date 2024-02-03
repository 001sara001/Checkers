import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/user.dart';
import 'package:untitled1/screens/restaurant.dart';
import 'package:untitled1/screens/applogo.dart';
import 'package:untitled1/widgets/custom_scaffold.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:untitled1/notif/notification_services.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  /*
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState () {
    //TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();

    notificationServices.getDeviceToken().then((value){
      print ('device token');
      print (value);
    });
  }
  */
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          applogo(),
          SizedBox(height: 130), // Adjust the height as needed
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => user()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.white),
              ),
            ),
            child: Container(
              width: 200,
              height: 80,
              alignment: Alignment.center,
              child: const Text('User', style: TextStyle(fontSize: 25, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Restaurant()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.white),
              ),
            ),
            child: Container(
              width: 200,
              height: 80,
              alignment: Alignment.center,
              child: const Text('Restaurant', style: TextStyle(fontSize: 25, color: Colors.white)),
            ),
          ),

        ],
      ),
    );
  }
}
