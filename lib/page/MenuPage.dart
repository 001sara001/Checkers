import 'package:flutter/material.dart';
import 'package:untitled1/page/profile_page.dart';
import 'package:untitled1/allrestaurants/restaurant1.dart';
import 'package:untitled1/allrestaurants/restaurant2.dart';
import 'package:untitled1/allrestaurants/restaurant3.dart';
import 'package:untitled1/allrestaurants/restaurant4.dart';
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
        children: [
         // applogo(),
          SizedBox(height: 130), // Adjust the height as needed
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Restaurant1()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.white),
              ),
            ),
            child: Container(
              width: 200,
              height: 80,
              alignment: Alignment.center,
              child: Text('Restaurant1', style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Restaurant2()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.white),
              ),
            ),
            child: Container(
              width: 200,
              height: 80,
              alignment: Alignment.center,
              child: const Text('Restaurant2', style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(height: 100), // Adjust the height as needed
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Restaurant3()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.white),
              ),
            ),
            child: Container(
              width: 200,
              height: 80,
              alignment: Alignment.center,
              child: Text('Restaurant3', style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(height: 130), // Adjust the height as needed
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Restaurant4()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.white),
              ),
            ),
            child: Container(
              width: 200,
              height: 80,
              alignment: Alignment.center,
              child: Text('Restaurant4', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
      endDrawer: MyDrawer(),
    );
  }
}




