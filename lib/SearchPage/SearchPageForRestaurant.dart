import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/login/Homepage/ChatRoomPageForRestaurant.dart';
import 'package:untitled1/model/RestaurantModel.dart';

import '../login/Homepage/ChatRoomModel.dart';
import '../login/Homepage/ChatRoomPage.dart';
import '../main.dart';
import '../model/UserModel.dart';

class SearchPageForRestaurant extends StatefulWidget {
  final RestaurantModel restaurantModel;
  final User firebaseUser;

  const SearchPageForRestaurant({Key? key, required this.restaurantModel, required this.firebaseUser}) : super(key: key);

  @override
  _SearchPageForRestaurantState createState() => _SearchPageForRestaurantState();
}

class _SearchPageForRestaurantState extends State<SearchPageForRestaurant> {
  TextEditingController searchController = TextEditingController();

  Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("chatrooms")
        .where("participants.${widget.restaurantModel.restaurantuid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true).get();

    if (snapshot.docs.length > 0) {
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom = ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoom = existingChatroom;
    } else {
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: "",
        participants: {
          widget.restaurantModel.restaurantuid.toString(): true,
          targetUser.uid.toString(): true,
        },
      );

      await FirebaseFirestore.instance.collection("chatrooms")
          .doc(newChatroom.chatroomid).set(newChatroom.toMap());

      chatRoom = newChatroom;

      log("New Chatroom Created!");
    }

    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                  ),
                ),
                SizedBox(height: 20),
                CupertinoButton(
                  onPressed: () {
                    setState(() {});
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text("Search"),
                ),
                SizedBox(height: 20),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("Users")
                      .where("emailAddress", isEqualTo: searchController.text)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                        if (dataSnapshot.docs.length > 0) {

                          Map<String, dynamic> userMap = dataSnapshot.docs[0].data() as Map<String, dynamic>;

                          UserModel searchedUser = UserModel.fromMap(userMap);
                          /* Map<String, dynamic> userMap = dataSnapshot.docs[0].data() as Map<String, dynamic>;

                          RestaurantModel searchedUser = RestaurantModel.fromMap(userMap);
*/

                          return ListTile(
                            onTap: () async {
                              ChatRoomModel? chatroomModel = await getChatroomModel(searchedUser);

                              if (chatroomModel != null) {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ChatRoomPageForRestaurant(
                                        targetUser: searchedUser,
                                        restaurantModel: widget.restaurantModel,
                                        firebaseUser: widget.firebaseUser,
                                        chatRoom: chatroomModel,
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                            leading: CircleAvatar(
                              //backgroundImage: NetworkImage(searchedUser.profilepic!),
                              backgroundColor: Colors.grey[500],
                            ),
                            /* title: Text(searchedUser.fullRestaurantName ?? ''),
                            subtitle: Text(searchedUser.restaurantEmailAddress ?? ''),
                            trailing: Icon(Icons.keyboard_arrow_right),*/
                            title: Text(searchedUser.fullName!),
                            subtitle: Text(searchedUser.emailAddress!),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          );
                        } else {
                          return Text("Search here ");
                        }
                      } else if (snapshot.hasError) {
                        return Text("An error occurred!");
                      } else {
                        return Text("No results found!");
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
