import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/rest2ndpage/text_field.dart';
import 'package:untitled1/rest2ndpage/wall_post.dart';

import '../helper/helper_method.dart';


class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();
  int currentRating = 0;

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("UserPosts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'Timestamp': Timestamp.now(),
        'Likes': [],
        'Rating': currentRating,
      });
    }

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        textController.clear();
        currentRating = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("UserPosts")
                    .orderBy("Timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                          postId: post.id,
                          time: formatDate(post['Timestamp']),
                          likes: List<String>.from(post['Likes'] ?? []),
                          rating: post['Rating'] ?? 0,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return const Center();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: 'Write your review here...',
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                    onPressed: postMessage,
                    icon: Icon(Icons.arrow_circle_up_rounded),
                  ),
                  // Display the star rating input
                  buildStarRatingInput(),
                ],
              ),
            ),
            Text(
              'Logged in as: ' + currentUser.email!,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget buildStarRatingInput() {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      stars.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentRating = i + 1;
            });
          },
          child: Icon(
            i < currentRating ? Icons.star : Icons.star_border,
            color: Colors.blueGrey,
          ),
        ),
      );
    }
    return Row(children: stars);
  }
}
