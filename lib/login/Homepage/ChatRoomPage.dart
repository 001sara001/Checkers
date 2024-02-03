import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/login/Homepage/ChatRoomModel.dart';
import 'package:untitled1/login/Homepage/MessageModel.dart';

import '../../main.dart';
import '../../model/RestaurantModel.dart';
import '../../model/UserModel.dart';
import '../../screens/restaurant.dart';

class ChatRoomPage extends StatefulWidget {
  final RestaurantModel targetUser;
  final ChatRoomModel chatRoom;
  final UserModel userModel;
  final User firebaseUser;
  const ChatRoomPage({super.key, required this.targetUser, required this.chatRoom, required this.userModel, required this.firebaseUser});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {

  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    String msg=messageController.text.trim();
    messageController.clear();
    if(msg!=" "){
      //send message
      MessageModel newMessage=MessageModel(
        messageid: uuid.v1(),
        sender: widget.userModel.uid,
        createdon: DateTime.now(),
        text: msg,
        seen:false
      );
      FirebaseFirestore.instance.collection("chatrooms")
          .doc(widget.chatRoom.chatroomid).collection("messages")
          .doc(newMessage.messageid).set(newMessage.toMap());
    }

    widget.chatRoom.lastMessage = msg;
    FirebaseFirestore.instance.collection("chatrooms").doc(widget.chatRoom.chatroomid).set(widget.chatRoom.toMap());

    log("Message Sent!");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Row(
            children: [
             CircleAvatar(
               backgroundColor: Colors.blueGrey[300],
               backgroundImage: NetworkImage(widget.targetUser.profilepic.toString()),
             ),
            SizedBox(width: 10,),
            Text(widget.targetUser.fullRestaurantName.toString()),
            ],
          )
      ),

      body: SafeArea(
        child: Container(
          child: Column(
            children: [

              //This is where the chats will go
              Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("chatrooms")
                          .doc(widget.chatRoom.chatroomid).collection("messages")
                          .orderBy("createdon", descending: true).snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState==ConnectionState.active){
                          if(snapshot.hasData) {
                            QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;

                            return ListView.builder(
                              reverse: true,
                             itemCount: dataSnapshot.docs.length,
                              itemBuilder: (context, index) {
                                MessageModel currentMessage = MessageModel.fromMap(dataSnapshot.docs[index]
                                    .data() as Map<String, dynamic>);

                                return Row(
                                  mainAxisAlignment: (currentMessage.sender == widget.userModel.uid) ?
                                  MainAxisAlignment.end : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 2,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: (currentMessage.sender == widget.userModel.uid) ?
                                          Colors.grey : Theme.of(context).colorScheme.secondary,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          currentMessage.text.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          else if(snapshot.hasError){
                            return Center(
                              child: Text("Error occurred!Please check your internet connection"),
                            );
                          }
                          else{
                            return Center(
                              child: Text("Say hi to your new friend"),
                            );
                          }
                        }
                        else{
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },

                    ),
                  ),
              ),

              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Flexible(
                        child: TextField(
                          controller: messageController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Message"
                          ),
                        ),
                    ),

                    IconButton(
                        onPressed:(){
                        sendMessage();
                        },
                        icon: Icon(Icons.send,color: Theme.of(context).colorScheme.secondary,),
                    ),
                  ],

              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
