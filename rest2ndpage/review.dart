import 'package:flutter/material.dart';
import 'package:untitled1/page/MyDrawerr.dart';

class ReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews"),
      ),

      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 100.0,
              color: Colors.yellow,
            ),
            SizedBox(height: 20.0),
            Text(
              "No reviews yet",
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
