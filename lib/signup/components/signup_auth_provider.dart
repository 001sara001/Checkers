import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../home.dart';

class SignupAuthProvider with ChangeNotifier {

  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(SignupAuthProvider.pattern.toString());
  UserCredential? userCredential;

  bool loading = false;
  void signupValidation({
    required TextEditingController? fullName,
    required TextEditingController? emailAddress,
    required TextEditingController? password,
    required BuildContext context
  }) async {
    if (fullName!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Full name is empty"
          ),
        ),
      );
      return;
    }
    else if (emailAddress!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Email Address is empty"
          ),
        ),
      );
      return;
    }
    else if (!regExp.hasMatch(emailAddress.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid email address"),
        ),
      );
      return;
    } else if (password!.text.trim().isEmpty) {
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
    }
    else if (!emailAddress.text.trim().toLowerCase().endsWith('@gmail.com')) {
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
         //create the user
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress.text,
          password: password.text,
        );
        //after creating the user, create a new docuement in cloud firestore called Users
        FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
        .set({
          'username': emailAddress.text.split('@')[0],// initial username
          'bio' : 'Empty bio..'// initial empty bio
          //additional field lagle ekhane add korbo
        });

        loading = true;
        notifyListeners();
        FirebaseFirestore.instance.collection("users")
            .doc(userCredential!.user!.uid)
            .set(
          {
            "fullName": fullName.text,
            "emailAddress": emailAddress.text,
            "password": password.text,
            "userUid": userCredential!.user!.uid,
          },
        ).then((value) {
          loading = false;
          notifyListeners();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context)=>
              MyHomePage(),
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
