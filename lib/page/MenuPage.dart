import 'package:flutter/material.dart';
import 'myDrawerr.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Go back
          },
        ),

        backgroundColor: Colors.black,

      ),
    body: Stack(

      ),
      endDrawer: MyDrawer(),
    );
  }
}




