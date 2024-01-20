import 'package:flutter/material.dart';
import 'package:untitled1/home.dart';
import 'package:untitled1/widgets/custom_scaffold.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScaffold(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //applogo(),
            SizedBox(height: 0), // Adjust the height as needed
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
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
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 80,
                  child: const Text(
                      'Mohammadpur', style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ),
            ),
            SizedBox(height: 23), // Adjust the height as needed
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
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
              child: Center(
                child: Container(
                  width: 200,
                  height: 80,
                  alignment: Alignment.center,
                  child: const Text(''
                      'Gulshan', style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ),
            ),
            SizedBox(height: 20), // Adjust the height as needed
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
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
              child: Center(

                child: Container(
                  width: 200,
                  height: 80,
                  alignment: Alignment.center,
                  child: const Text(''
                      'Dhanmondi', style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                  MyHomePage()),
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
              child: Center(
                child: Container(
                  width: 200,
                  height: 80,
                  alignment: Alignment.center,
                  child: const Text('Mirpur', style: TextStyle(fontSize: 25, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
