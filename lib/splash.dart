import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled1/screens/applogo.dart';
import 'package:untitled1/screens/welcome_screen.dart';
import 'package:untitled1/widgets/custom_scaffold.dart';




class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.push(
          //context, MaterialPageRoute(builder: (c) => const LoginOrResigter()));
         context, MaterialPageRoute(builder: (c) => const WelcomeScreen()));
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override

  Widget build(BuildContext context) {

    return CustomScaffold(
      child: Column(
        children: [
          applogo(),
          SizedBox(height: 70),
          Flexible(
            flex: 2,
            child: Container(

              child: Center(

                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                     // Image.asset(image: "image/Checkers.png");
                      TextSpan(
                        text: 'Getting Started...\n',
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//This is a test line.





