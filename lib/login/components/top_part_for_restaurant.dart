import 'package:flutter/material.dart';

import 'image_add.dart';

class TopPartForRestaurant extends StatelessWidget {
  const TopPartForRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 50,
            ),
            //Image.asset("images/Checkers.png",scale:10),
            Image.asset("assets/images/Checkers.png", scale: 2),
            const SizedBox(
              height: 7,
            ),
            const Text("Sign In", style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),

            ),
            SizedBox(
              height: 30,
            ),
            //ImageAdd(),
          ],
        ),
      ],
    );
  }
}

