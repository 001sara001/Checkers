import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/login/components/login_page_for_restaurant.dart';
import 'package:untitled1/signup/components/signup_auth_provider_for_restaurant.dart';


import '../../login/login_page.dart';
import '../../widgets/my_button.dart';
class SignupPageForRestaurant extends StatefulWidget {
  const SignupPageForRestaurant({Key? key}) : super(key: key);

  @override
  State<SignupPageForRestaurant> createState() => _SignupPageForRestaurantState();
}

class _SignupPageForRestaurantState extends State<SignupPageForRestaurant> {
  TextEditingController fullRestaurantName=TextEditingController();
  TextEditingController restaurantEmailAddress=TextEditingController();
  TextEditingController password=TextEditingController();

  XFile? imageXFIle;
  final ImagePicker _picker = ImagePicker();
  String imageUrl = '';

  Future<void> _getImage() async {
    imageXFIle = await _picker.pickImage(source: ImageSource.gallery);
    print('${imageXFIle?.path}');
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("logo");
    Reference referenceImageUpload = referenceDirImages.child(uniqueFileName);
    await referenceImageUpload.putFile(File(imageXFIle!.path));
    imageUrl = await referenceImageUpload.getDownloadURL();
    setState(() {
      imageXFIle;
    });
  }



  bool visibility=false;
  @override
  Widget build(BuildContext context) {
    SignupAuthProviderForRestaurant signupAuthProviderForRestaurant=Provider.of<SignupAuthProviderForRestaurant>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Register",
                style: TextStyle(
                  fontSize:30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: fullRestaurantName,
                    decoration: const InputDecoration(

                      hintText: "Restaurant name",
                    ),
                  ),
                  TextFormField(
                    controller: restaurantEmailAddress,
                    decoration: const InputDecoration(
                      hintText: "Restaurant Email address",
                    ),
                  ),
                  TextFormField(
                    obscureText: visibility,
                    controller: password,
                    decoration:  InputDecoration(
                      hintText: "Password for the restaurant",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        icon: Icon(
                          visibility ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () {
                      _getImage();
                    },
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.15,
                      backgroundColor: Colors.white,
                      backgroundImage:
                      imageXFIle == null ? null : FileImage(File(imageXFIle!.path)),
                      child: imageXFIle == null
                          ? Icon(
                        Icons.add_photo_alternate,
                        size: MediaQuery.of(context).size.width * 0.15,
                        color: Colors.grey,
                      )
                          : null,
                    ),
                  ),
                  Text("ADD LOGO",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal))


                ],
              ),
              Column(
                children: [
                  signupAuthProviderForRestaurant.loading == false?
                  MyButton(
                    onPressed:(){
                      signupAuthProviderForRestaurant.signupValidation(
                          context: context,
                          fullRestaurantName : fullRestaurantName,
                          restaurantEmailAddress: restaurantEmailAddress,
                          restaurantPassword: password, imageUrl: imageUrl);
                    },
                    text: "Register",
                  )
                      : Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account for the restaurant?\t\t"),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPageForRestaurant(),));
                        },
                        child: const Text("Sign in"),),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
