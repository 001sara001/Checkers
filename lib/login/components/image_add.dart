import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageAdd extends StatefulWidget {
  const ImageAdd({Key? key}) : super(key: key);

  @override
  State<ImageAdd> createState() => _ImageAddState();
}

class _ImageAddState extends State<ImageAdd> {
  Uint8List? _image;

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
    }
  }

  Future<Uint8List?> pickImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      return pickedFile.readAsBytes();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                  radius: 40 , // Adjusted based on pixel density
                  backgroundImage: MemoryImage(_image!),
                )
                    : CircleAvatar(
                  radius: 40, // Adjusted based on pixel density
                  backgroundImage: NetworkImage(
                      'https://medvirturials.com/img/old_logo.png'),
                ),
                Positioned(
                  child: IconButton(
                    onPressed: selectImage,
                    icon: Icon(Icons.add_a_photo),
                  ),
                  bottom: -13, // Adjusted based on pixel density
                  left: 35 , // Adjusted based on pixel density
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
