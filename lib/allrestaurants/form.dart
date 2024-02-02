import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:untitled1/Service/resdata.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
//import 'dart:io';

class form extends StatefulWidget {
  const form({super.key});

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController descontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  File? _image;
  //Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Function to upload the image to Firebase Storage
  Future<String> _uploadImage() async {
    String imageName = "menu_image_${randomAlphaNumeric(5)}";
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('menu_images')
        .child(imageName);
    await ref.putFile(_image!);
    return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Form",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body:

         Container(
          margin: EdgeInsets.only(left: 25.0, top: 30.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Item Name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(18)),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Item Description",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(18)),
              child: TextField(
                controller: descontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Item Price",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(18)),
              child: TextField(
                controller: pricecontroller,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Item Image",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                // _pickImage();
                ImagePicker imagePicker = ImagePicker();
                imagePicker.pickImage(source: ImageSource.gallery);
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: _image == null
                    ? Icon(Icons.add_a_photo, size: 50, color: Colors.teal)
                    : Image.file(_image!),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if(namecontroller.text!=null || descontroller.text!=null || pricecontroller.text!=null) {
                      String userId = FirebaseAuth.instance.currentUser!.uid;
                      String menuId = randomAlphaNumeric(10);

                      //String imageUrl = await _uploadImage();

                        Map<String, dynamic> menuInfoMap = {
                          "Name": namecontroller.text,
                          "Description": descontroller.text,
                          "Price": pricecontroller.text,
                          "Id": menuId,
                          //"Image": imageUrl,
                        };
                        await DatabaseMethods()
                            .addMenuDetailsForUser(menuInfoMap, userId, menuId)
                            .then((value) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Menu Detail Has been added succesfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      }else{
                        Fluttertoast.showToast(
                            msg: "Fill up the empty feilds",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);


                      }
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )))
          ]),
        ),
      );
  }
}
