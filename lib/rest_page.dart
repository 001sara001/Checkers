import 'package:flutter/material.dart';
import 'package:untitled1/widgets/menu_home.dart';
import 'rest2ndpage/review.dart';

class RestPage extends StatelessWidget {

final String id;
final String collection;
final String image;

const RestPage({Key?key,required this.id,required this.collection,required this.image}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(collection),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200.0,
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                "Dominos",
                style: TextStyle(fontSize: 0.0, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
          DefaultTabController(
            length: 2, // Set the length to 2
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Menu'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Content for the "Menu" tab
                        Center(
                          child: menu_home(collection: collection, id: id),
                        ),
                        // Content for the "Reviews" tab
                        Center(
                          child: ReviewPage(id: id,), // Use the ReviewsPage widget here
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
