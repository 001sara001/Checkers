import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class menu_home extends StatelessWidget {
  final String id;
  final String collection;
  const menu_home({
    Key? key,
    required this.collection,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: //Column(children: [
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("Restaurant names")
                    .doc(id)
                    .collection("Menus")
                    .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx, index) {
                        var data = snapshot.data!.docs[index];
                        return Restaurant(
                          name:"Name:" +data["Name"],
                          description:"Description:"+ data["Description"],
                          price:"Price:"+ data["Price"]+"Tk",
                          image: data["Image"],
                        );
                      });

                  /* Column(
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.4,
                                  crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20),
                          itemBuilder: (context, index) {
                            var data=snapshot.data!.docs[index];
                          }),
                    ],
                  );*/
                })

        //],

        // )

        );
  }
}

class Restaurant extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final String price;

  const Restaurant(
      {Key? key,
      required this.image,
      required this.name,
      required this.description,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0), // Adjust the padding around the Card
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.white30, width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use a Column to display text widgets vertically
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 5),
                  Text(
                    price,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              // Spacer to create space between text and image
              Spacer(),
              // Container for the image
              Container(
                width: 80.0, // Adjust the width as needed
                height: 80.0, // Adjust the height as needed
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
