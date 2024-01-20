import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home.dart';


class LoginAuthProviderForRestaurant with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(LoginAuthProviderForRestaurant.pattern.toString());

  bool loading = false;

  UserCredential? userCredential;

  void loginValidation({required TextEditingController? emailAdress,
    required TextEditingController? password,
    required BuildContext context}) async {
    if (emailAdress!
        .text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email address is empty"),
        ),
      );
      return;
    } else if (!regExp.hasMatch(emailAdress.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid email address"),
        ),
      );
      return;
    } else if (password!
        .text
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password is empty"),
        ),
      );
      return;
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password must be 8"),
        ),
      );
      return;
    } else {
      try {
        loading = true;
        notifyListeners();
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailAdress.text,
          password: password.text,
        )
            .then(
              (value) async {
            loading = false;
            notifyListeners();
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MyHomePage(),),);
          },
        );
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        String errorMessage ;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user';
        } else if (e.code == 'too-many-requests') {
          errorMessage =
          'Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.code),
          ),
        );
      }
    }
  }
}