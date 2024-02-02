import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/helper/helper_method.dart';
import 'package:untitled1/rest2ndpage/comment_button.dart';
import 'package:untitled1/rest2ndpage/like_button.dart';
import 'package:untitled1/rest2ndpage/comment.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;

  const WallPost({
    Key? key,
    required this.message,
    required this.user,
    required this.likes,
    required this.postId,
    required this.time,
  }) : super(key: key);

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
    FirebaseFirestore.instance.collection('UserPosts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("UserPosts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now(),
    });
  }

  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Comment"),
        content: TextField(
          controller: _commentTextController,
          decoration: InputDecoration(hintText: "Write a comment.."),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              addComment(_commentTextController.text);
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: Text("Post"),
          ),
        ],
      ),
    );
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

      //wallpost
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.message,
                style: TextStyle(
                  fontSize: 18, // Adjust the font size as needed
                  // Add other style properties if needed
                ),
              ),

              const SizedBox(height: 10),

              //user
              Row(
                children: [
                  Text (widget.user, style: TextStyle (color: Colors.blueGrey),
                  ),
                  Text (".", style: TextStyle (color: Colors.blueGrey)),
                  Align(
                    alignment: Alignment.centerRight,
                    widthFactor: 1.8,
                    child: Text(
                      widget.time,
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),



                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  LikeButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    widget.likes.length.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  CommentButton(onTap: showCommentDialog),
                  const SizedBox(width: 5.0),
                  Text(
                    '0',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("UserPosts")
                .doc(widget.postId)
                .collection("Comments")
                .orderBy("CommentTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  final commentData = doc.data() as Map<String, dynamic>;
                  return Comment(
                    text: commentData["CommentText"],
                    user: commentData["CommentedBy"],
                    time: formatDate(commentData["CommentTime"]),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
