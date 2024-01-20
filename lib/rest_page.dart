import 'package:flutter/material.dart';
import 'rest2ndpage/review.dart';

class RestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dominos"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                "Dominos",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Menu'),
                      Tab(text: 'Reviews'),
                      Tab(text: 'Location'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Content for the "Menu" tab
                        Center(
                          child: Text("Menu Content"),
                        ),
                        // Content for the "Reviews" tab
                        Center(
                          child: ReviewPage(), // Use the ReviewsPage widget here
                        ),
                        // Content for the "Location" tab
                        Center(
                          child: Text("Location Content"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
