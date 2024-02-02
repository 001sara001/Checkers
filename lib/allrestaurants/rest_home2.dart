import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/allrestaurants/rest_drawer.dart';
import 'package:untitled1/allrestaurants/rest_home.dart';

import '../page/MyDrawerr.dart';

class rest_home2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YOUR RESTAURANT"),
      ),
      endDrawer: rest_drawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /*Container(
            height: 200.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                "PizzaHut",
                style: TextStyle(fontSize: 0.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),*/
          // Add your header or any other widgets here
          FutureBuilder(
            future: _loadRestaurantImage(), // Function to load the restaurant image URL
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Display a loading indicator while fetching the image URL
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.hasData) {
                return Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(snapshot.data.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }

              return Container(); // Handle other cases as needed
            },
          ),

          DefaultTabController(
            length: 2, // Number of tabs
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Menu'),
                      Tab(text: 'Chat'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Content for the "Menu" tab
                        Center(
                          child: rest_home(),
                        ),
                        // Content for the "ChatApp" tab
                        Center(
                          child: Text(
                              "Contents for ChatApp"), // Use the ChatApp content here
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _loadRestaurantImage() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Restaurant names')
        .doc(userId)
        .get();

    return userDoc.get('logo') ?? ''; // Replace 'restaurantImageUrl' with the actual field name in your user document
  }
}

