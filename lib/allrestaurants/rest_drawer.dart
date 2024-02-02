
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/page/myList.dart';
import 'package:untitled1/page/profile_page.dart';

import 'package:untitled1/screens/applogo.dart';

import '../locations/locations.dart';
import '../screens/welcome_screen.dart';



/*
class MyDrawer extends StatelessWidget {
   MyDrawer({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: Column(
        children: [
          //header
          const DrawerHeader(
            child: applogo(),
          ),
          //home list
          MyListTitle(icon: Icons.home, text: 'Home', onTap: ()=>Navigator.pop(context),),
          //profile list
          MyListTitle(icon: Icons.person, text: 'Profile',
              onTap: ()=>Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>ProfilePage()),
              )),
          MyListTitle(icon: Icons.message_rounded, text: 'Message', onTap: ()=>Navigator.pop(context),),
          //change location
          /*
          MyListTitle(icon: Icons.location_on_outlined, text: 'Change Location',
              onTap: () {
                      // Use Navigator to navigate to the Locations widget
              Navigator.push(
               context,
              MaterialPageRoute(builder: (context) => Locations()),
              );
             },
          ),*/
          MyListTitle(icon: Icons.logout, text: 'Sign Out',
            onTap: () {
              // Perform logout actions here
              _auth.signOut();
            },
          ),
          //logout


        ],
      ),
    );
  }}
*/

class rest_drawer extends StatelessWidget {
  rest_drawer({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: Column(
        children: [
          //header
          const DrawerHeader(
            child: applogo(),
          ),
          //home list
          MyListTitle(icon: Icons.home, text: 'Home', onTap: () => Navigator.pop(context),),
          //profile list
          //MyListTitle(icon: Icons.message_rounded, text: 'Message', onTap: () => Navigator.pop(context),),
          //change location
          /*
          MyListTitle(
            icon: Icons.location_on_outlined,
            text: 'Change Location',
            onTap: () {
              // Use Navigator to navigate to the Locations widget
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Locations()),
              );
            },
          ),*/
          MyListTitle(
            icon: Icons.logout,
            text: 'Sign Out',
            onTap: () async {
              // Perform logout actions here
              await _auth.signOut();

              // Navigate to the WelcomeScreen after signing out
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
          ),
          //logout
        ],
      ),
    );
  }
}
