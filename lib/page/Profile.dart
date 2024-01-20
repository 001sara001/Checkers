import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/page/text_box.dart';
import 'package:untitled1/rest2ndpage/text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  //all users
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  //edit field
  Future <void> editField (String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.blueGrey[900],
            title: Text ("Edit $field",
            style: TextStyle(color: Colors.white),),
          content: TextField(
            autofocus: true,
            style: TextStyle (color: Colors.white),
            decoration: InputDecoration (
              hintText: "Enter your new $field",
              hintStyle: TextStyle (color: Colors.grey),
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            //cancel button
            TextButton (
                child: Text ('Cancel', style: TextStyle (color: Colors.white),),
            onPressed: () => Navigator.pop (context),),
            //save
            TextButton (
              child: Text ('Save', style: TextStyle (color: Colors.white),),
              onPressed: () => Navigator.of(context).pop(newValue),),
          ],
        ),
    );

    //update in firestore
    if (newValue.trim().length>0){
      await usersCollection.doc(currentUser.email).update({field:newValue});
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true, // Center aligns the title
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder <DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          //get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data () as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(height: 50),
                //profile pic
                Icon (
                  Icons.person,
                  size: 80,
                ),

                const SizedBox(height: 10),

                //user email
                Text(currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo[900]),
                ),

                //user details
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text (
                    'My Details',
                    style: TextStyle (
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.indigo[300]),),
                ),

                // username
                MyTextBox(text: userData['username'],
                  sectionName: 'username',
                  onPressed: () => editField('username'),),

                //bio
                MyTextBox(
                  text: userData['bio'],
                  sectionName: 'bio',
                  onPressed: () => editField('bio'),),

                //user posts
                //user details
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text (
                    'My Posts',
                    style: TextStyle (
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.indigo[300]),),
                ),
              ],
            );
          } else if (snapshot.hasError){
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }

          return const Center(child: CircularProgressIndicator(),);

        },
      ),


    );
  }
}

