import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/login/Homepage/HomePage.dart';

import '../../model/UserModel.dart';
import '../login_page.dart';

class Message extends StatefulWidget {


  const Message({Key? key}) : super(key: key);
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
 /* @override
  Future<Widget> main() async {
    DocumentSnapshot userData = await FirebaseFirestore.instance.collection('Users').doc(userUid).get();
    UserModel userModel = UserModel.fromMap(userData.data() as Map<String, dynamic>);
    return Scaffold(
           appBar: AppBar(
           centerTitle: true,

           actions: [
           IconButton(
            onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
            context,
             MaterialPageRoute(
               builder: (context) {
                 return HomePage(
                     userModel: userModel,
                     firebaseUser: credential!.user!
                 );
              },
           ),
          );
       },
              icon: Icon(Icons.exit_to_app),
           ),
           ],
        ),
    );
    }*/
}
