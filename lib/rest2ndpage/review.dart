import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/rest2ndpage/text_field.dart';
import 'package:untitled1/rest2ndpage/wall_post.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //text controller
  final textController = TextEditingController();

  //post message method
  void postMessage() {
    // Only post message if there is something in the text field
    if (textController.text.isNotEmpty) {
      // Store in Firebase
      FirebaseFirestore.instance.collection("UserPosts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'Timestamp': Timestamp.now(),
        'Likes': [],
      });
    }

    // Clear the text field after a short delay
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        textController.clear();
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column (
          children: [
            //the wall
            Expanded(
              child: StreamBuilder(
                 stream: FirebaseFirestore.instance.collection("UserPosts").orderBy("Timestamp", descending: false).snapshots(),

                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        // get the message
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                            message: post['Message'], user: post['UserEmail'], postId: post.id,
                          likes: List<String>.from(post['Likes']?? []),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return const Center(
                      //child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),


            // post message
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row (
                children: [
                  //textfield
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: 'Write your review here...',
                      obscureText: false,

                  ),
                  ),

                  //post button
                  IconButton(onPressed: postMessage,
                      icon: Icon(Icons.arrow_circle_up_rounded),
                  ),
                ],
              ),
            ),

            //logged in as
            Text ('Logged in as: '+currentUser.email!,
            style: TextStyle(color: Colors.grey),),

            const SizedBox(
              height: 20,
            )
          ],
        ),
      )
    );
  }

// Add any additional methods or properties here
}
