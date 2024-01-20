import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled1/page/profile_page.dart';

import '../screens/applogo.dart';
import 'MenuPage.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(

      backgroundColor: Colors.black54,
      width: MediaQuery.of(context).size.width * 100.0,
      child : Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // logo
            const applogo(),

            //for edit profile
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),

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
  }
}
