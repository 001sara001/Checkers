import 'package:flutter/material.dart';

class TopPartForRestaurant extends StatelessWidget {
  const TopPartForRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
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

          ],
        ),
      ],
    );
  }
}

