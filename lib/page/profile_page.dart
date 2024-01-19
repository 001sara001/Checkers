import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // edit
  Future<void>editField(String field) async{

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(

        title: Text('PRPFILE'),

        backgroundColor: Colors.black45,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50,),
          // Profile pic
          Icon(Icons.person , size : 72),

          //const SizedBox(height: 10,)
          //Email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 50,),
          //user details
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text('Details',
            style: TextStyle(color: Colors.white),
            ),
          ),
          // ueser name
          Box(
            text: 'Raisa' ,
            sectionName : 'username' ,
            onPressed: () => editField ('userName'),),
          Box(
            text: 'Empty bio' ,
            sectionName : 'bio' ,
            onPressed: () => editField ('bio'),),

          Box(
            text: 'Empty adress' ,
            sectionName : 'address' ,
            onPressed: () => editField ('adress'),),
        ],
      ),
    );
  }
}
