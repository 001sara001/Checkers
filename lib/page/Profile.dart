import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/page/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _selectedImage;
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  Future<void> _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      // Upload the image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('profile_images/${currentUser.uid}');
      await storageRef.putFile(_selectedImage!);

      // Get the image URL
      final imageUrl = await storageRef.getDownloadURL();

      // Update the image URL in Firestore
      await usersCollection.doc(currentUser.email).update({'profileImageUrl': imageUrl});
    }
  }

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          "Edit $field",
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter your new $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Save', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    if (newValue.trim().length > 0) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(height: 50),
                // Profile pic
                IconButton(
                  onPressed: _pickImageFromGallery,
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.photo_camera,
                        size: 80,
                        color: Colors.indigo[900],
                      ),
                      if (_selectedImage != null)
                        ClipOval(
                          child: Image.file(
                            _selectedImage!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                ),

                // User email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.indigo[900]),
                ),

                // User details
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.indigo[300],
                    ),
                  ),
                ),

                // Username
                MyTextBox(text: userData['username'], sectionName: 'username', onPressed: () => editField('username')),
               // MyTextBox(text: userData['emailAddress'], sectionName: 'emailAddress', onPressed: () => editField('emailAddress')),
                // Bio
                MyTextBox(text: userData['bio'], sectionName: 'bio', onPressed: () => editField('bio')),

                // User posts
                const SizedBox(height: 50),
                /*
          Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My Posts',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.indigo[300],
                    ),
                  ),
                ),*/
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
