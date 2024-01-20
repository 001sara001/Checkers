import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/rest2ndpage/like_button.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;

  const WallPost({
  super.key,
    required this.message,
    required this.user,
    required this.likes,
    required this.postId,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {

  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState () {
    super.initState();
    isLiked= widget.likes.contains(currentUser.email);
  }

  //toggle like
  void toggleLike () {
    setState(() {
      isLiked=!isLiked;
    });

    //access the foc in firebase
    DocumentReference postRef=
        FirebaseFirestore.instance.collection('UserPosts').doc(widget.postId);

    if (isLiked) {
      // like kora hoile user er email firebase e jabe
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      //unlike kora hoile remove hobe email firebase theke
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, left: 15, right: 15),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            children: [
              //like button
              LikeButton(
                  isLiked: isLiked,

                  onTap: toggleLike),

              // Add some space
              SizedBox(width: 5.0),

              // like count
              Text (widget.likes.length.toString(),
              style: TextStyle (color: Colors.black)),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey[500]),
              ),
              const SizedBox(height: 10),
              Text(widget.message),
            ],
          ),
        ],
      ),
    );
  }
}
