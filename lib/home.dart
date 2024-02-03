//import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/page/MenuPage.dart';
import 'package:untitled1/page/MyDrawerr.dart';
import 'package:untitled1/rest2ndpage/drawer.dart';

import 'rest_page.dart'; // Ensure the correct import for RestPage

import 'login/login_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back button
        title: Center(
          child: Text(
            "       Checkers",
            style: TextStyle(
              fontSize: 24.0, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        /* actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.exit_to_app,
            ),
          ),
        ],*/
      ),
      endDrawer: MyDrawer(),
      body: /*GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RestPage(
            id: streamSnapshot.data!.docs[index],
          )));
        },
        child:*/ Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Restaurant names")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (!streamSnapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (ctx, index) {
                  return Restaurant(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RestPage(
                          id: streamSnapshot.data!.docs[index].id,
                          image:streamSnapshot.data!.docs[index]["logo"],
                          collection: streamSnapshot.data!.docs[index]["fullName"])));
                    },
                    name: streamSnapshot.data!.docs[index]["fullName"],
                    image: streamSnapshot.data!.docs[index]["logo"],
                  );
                });
          },
        ),

        /*child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.grey, width: 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dominos",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 80.0, // Adjust the width as needed
                    height: 80.0, // Adjust the height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.asset(
                      'assets/images/img2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),*/
      ),
      // ),
    );
  }
}

class Restaurant extends StatelessWidget {
  final String image;
  final String name;
  final Function()? onTap;
  const Restaurant({Key? key, required this.image, required this.name,required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust the padding as needed
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.white, width: 1.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 80.0, // Adjust the width as needed
                  height: 80.0, // Adjust the height as needed
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}