import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'MenuPage.dart';
import 'edit_profile.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override

  State<ProfileScreen> createState() => _ProfileScreenState();
}

  class _ProfileScreenState extends State<ProfileScreen> {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    final currentUser = FirebaseAuth.instance.currentUser!;

    storeUserInfo() async {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('Personal Info')
          .doc(uid)
          .set({
        'image': url,
        'Name': nameController.text,
        'Phone Number': phoneNumberController.text,
        'Address': addressController.text,
        'Email': emailController.text,
      });
      nameController.clear();
      phoneNumberController.clear();
      addressController.clear();
      emailController.clear();
      setState(() {
        //Loading = false;
      });
    }

    bool loading = false;

   /* void signupValidation({
      required TextEditingController? name,
      required TextEditingController? phoneNumber,
      required TextEditingController? address,
      required TextEditingController? email,
      required BuildContext context
    }) async {
      if (name!
          .text
          .trim()
          .isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Full name is empty"
            ),
          ),
        );
        return;
      }
      else if (phoneNumber!
          .text
          .trim()
          .isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Phone NUmber is empty"
            ),
          ),
        );
        return;
      }
      else if (address!
          .text
          .trim()
          .isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Address is empty"
            ),
          ),
        );
        return;
      }
      else if (email!
          .text
          .trim()
          .isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Email is empty"
            ),
          ),
        );
        return;
      }
    }*/
      bool isLoading = false;

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextBox(
                  Name: nameController.text,
                  PhoneNumber: phoneNumberController.text,
                  address: addressController.text,
                  Email: emailController.text,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    storeUserInfo();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPage()),
                    );
                  },
                  child: Text('Save'),

                ),
                if (isLoading) CircularProgressIndicator(),
                // Show loading indicator if saving
              ],
            ),
          ),
        );
      }
    }
