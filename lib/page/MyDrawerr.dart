

// eta new eta niba
=======
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:untitled1/page/MenuPage.dart';
import 'package:untitled1/page/myList.dart';
import 'package:untitled1/page/profile_page.dart';

import 'package:untitled1/screens/applogo.dart';



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
                    builder: (context)=>ProfileScreen()),
              )),
          MyListTitle(icon: Icons.logout, text: 'Log Out',
              onTap: ()=>Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>MenuPage()),
              )),
          //logout

                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.white),
                ),
              ),
              child: Container(
                width: 120,
                height: 50,
                alignment: Alignment.center,
                child: Text('Edit Profile', style: TextStyle(fontSize: 20)),
              ),
            ),
            //logout
            ElevatedButton(
              onPressed: () {
                exit(0);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.white),
                ),
              ),
              child: Container(
                width: 120,
                height: 50,
                alignment: Alignment.center,
                child: Text('Log Out', style: TextStyle(fontSize: 20)),

              ),
            ),
          ],
        ),
      ),
    );
  }}

