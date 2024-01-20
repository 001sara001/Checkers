
// eta new eta niba
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled1/page/myList.dart';
import 'package:untitled1/page/profile_page.dart';

import 'package:untitled1/screens/applogo.dart';

import '../locations/locations.dart';
import 'Profile.dart';



class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
              exit(0); // This will exit the app
            },
          ),
          //logout


        ],
      ),
    );
  }}

