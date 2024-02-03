import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/SearchPage/SearchPageForRestaurant.dart';
import 'package:untitled1/login/Homepage/ChatRoomPageForRestaurant.dart';
import 'package:untitled1/model/RestaurantModel.dart';
import 'package:untitled1/page/Profile.dart';

import '../../SearchPage/SearchPage.dart';
import '../../home.dart';
import '../../model/UserModel.dart';
import '../FirebaseHelper.dart';
import '../login_page.dart';
import 'ChatRoomModel.dart';
import 'ChatRoomPage.dart';

class HomePageForRestaurant extends StatefulWidget {
  final RestaurantModel restaurantModel;
  final User firebaseUser;

  const HomePageForRestaurant({
    Key? key, required this.firebaseUser,
    required this.restaurantModel}) :
        super(key: key);

  @override
  _HomePageForRestaurantState createState() => _HomePageForRestaurantState();
}

class _HomePageForRestaurantState extends State<HomePageForRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Messages"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) {
                      return MyHomePage();
                    }
                ),
              );
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("chatrooms")
                .where("participants.${widget.restaurantModel.restaurantuid}",
                isEqualTo: true).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.active) {
                if(snapshot.hasData) {
                  QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;

                  return ListView.builder(
                    itemCount: chatRoomSnapshot.docs.length,
                    itemBuilder: (context, index) {
                      ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(chatRoomSnapshot.docs[index]
                          .data() as Map<String, dynamic>);

                      Map<String, dynamic> participants = chatRoomModel.participants!;

                      List<String> participantKeys = participants.keys.toList();
                      participantKeys.remove(widget.restaurantModel.restaurantuid);

                      return FutureBuilder(
                        future: FirebaseHelper.getUserModelById(participantKeys[0]),
                        builder: (context, userData) {
                          if(userData.connectionState == ConnectionState.done) {
                            if(userData.data != null) {
                             UserModel targetUser =userData.data as  UserModel;

                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                     /* return ChatRoomPageForRestaurant(
                                        chatRoom: chatRoomModel,
                                        firebaseUser: widget.firebaseUser,
                                        restaurantModel: widget.restaurantModel,
                                        targetUser: targetUser,
                                      );
*/
                                      return ChatRoomPageForRestaurant(
                                        chatRoom: chatRoomModel,
                                        firebaseUser: widget.firebaseUser,
                                        restaurantModel: widget.restaurantModel,
                                        targetUser: targetUser,
                                      );
                                    }),
                                  );
                                },
                                leading: CircleAvatar(
                                  //backgroundImage: NetworkImage(targetUser.profilepic.toString()),
                                ),
                                title: Text(targetUser.fullName.toString()),
                                subtitle: (chatRoomModel.lastMessage.toString() != "") ?
                                Text(chatRoomModel.lastMessage.toString())
                                    : Text("Say hi to your new friend!", style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                ),
                              );
                            }
                            else {
                              return Container();
                            }
                          }
                          else {
                            return Container();
                          }
                        },
                      );
                    },
                  );
                }
                else if(snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                else {
                  return Center(
                    child: Text("No Chats"),
                  );
                }
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchPageForRestaurant(
                restaurantModel: widget.restaurantModel,
                firebaseUser: widget.firebaseUser);
          }
          )
          );
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

