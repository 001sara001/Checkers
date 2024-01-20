import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../allrestaurants/rest_home.dart';

class SignupAuthProviderForRestaurant with ChangeNotifier {

  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(SignupAuthProviderForRestaurant.pattern.toString());
  UserCredential? userCredential;

  bool loading = false;
  void signupValidation({
    required TextEditingController? fullRestaurantName,
    required TextEditingController? restaurantEmailAddress,
    required TextEditingController? restaurantPassword,
    required BuildContext context
  }) async {
    if (fullRestaurantName!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Restaurant name is empty"
          ),
        ),
      );
      return;
    }
    else if (restaurantEmailAddress!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Email Address for restaurant is empty"
          ),
        ),
      );
      return;
    }
    else if (!regExp.hasMatch(restaurantEmailAddress.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid email address"),
        ),
      );
      return;
    } else if (restaurantPassword!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password is empty"),
        ),
      );
      return;
    } else if (restaurantPassword.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password must be 8"),
        ),
      );
      return;
    }
    else if (!restaurantEmailAddress.text.trim().toLowerCase().endsWith('@gmail.com')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Only Gmail accounts are allowed"),
        ),
      );
      return;
    }else {
      try {
        loading = true;
        notifyListeners();
        userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: restaurantEmailAddress.text,
          password: restaurantPassword.text,
        );
        loading = true;
        notifyListeners();
        FirebaseFirestore.instance.collection("Restaurant names")
            .doc(userCredential!.user!.uid)
            .set(
          {
            "fullName": fullRestaurantName.text,
            "emailAddress": restaurantEmailAddress.text,
            "password": restaurantPassword.text,
            "userUid": userCredential!.user!.uid,
          },
        ).then((value) {
          loading = false;
          notifyListeners();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context)=>RestHome(),
              //
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        loading = false;
        notifyListeners();
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("weak-password"),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("email-already-in-use"),
            ),
          );
        }
      }
    }
  }
}
