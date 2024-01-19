
import 'package:flutter/material.dart';
import 'package:untitled1/page/MenuPage.dart';
import 'package:untitled1/page/button.dart';
import 'package:untitled1/page/edit_profile.dart';


class EditScreen extends StatefulWidget {
  const EditScreen({Key? key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const MenuPage(), // back button to back in menu page
              ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.brown,
              ),
              child: const Center(
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'My Details',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const MyTextBox(firstName: ' ', lastName: ' ', address: ' '),
          const SubmitButton(),
        ],
      ),
    );
  }
}
