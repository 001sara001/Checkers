import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'editInfo.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String firstName;
  late String lastName;
  late String address;

  @override
  void initState() {
    super.initState();
    // Fetch user data from Firebase when the page loads
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Get the current user from Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get user data from Firestore
        DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        // Set the user data in the state
        setState(() {
          firstName = userSnapshot['firstName'] ?? '';
          lastName = userSnapshot['lastName'] ?? '';
          address = userSnapshot['address'] ?? '';
        });
      }
    } catch (e) {
      print('Error ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'), // profile
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to the EditProfile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  EditScreen()),
              );
            },
            child: Text(
              'Edit', // edit button
              style: TextStyle(
                fontSize: 20,
                color: Colors.yellow,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
      body: MyTextBox( // boxe
        firstName: firstName,
        lastName: lastName,
        address: address,
      ),
    );
  }
}


