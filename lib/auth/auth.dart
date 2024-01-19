import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/auth/login_or_register.dart';
import 'package:untitled1/screens/welcome_screen.dart';



/*class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData){
            return const WelcomeScreen ();

          }else {
            return const LoginOrResigter();
          }
        },
      ),

    );
  }
}*/
