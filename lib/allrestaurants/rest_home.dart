//code

//more edits of this code
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/Service/resdata.dart';
import 'package:untitled1/allrestaurants/form.dart';



class rest_home extends StatefulWidget {
  const rest_home({super.key});

  @override
  State<rest_home> createState() => _rest_homeState();
}

class _rest_homeState extends State<rest_home> {
  Stream? MenuStream;
  getontheload()async{
    MenuStream=await DatabaseMethods().getMenuDetails();
    setState(() {

    });
  }

  @override
  void initState(){
    getontheload();
    super.initState();

  }


  Widget allMenuDetails(){
    return StreamBuilder(
        stream:MenuStream,
          builder: (context,AsyncSnapshot snappshot) {
            return snappshot.hasData

                ? ListView.builder(
                itemCount: snappshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snappshot.data.docs[index];
                  return Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name : " + ds["Name"], style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                            Text("Description : " + ds["Description"],
                                style: TextStyle(color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text("Price : " + ds["Price"], style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),

                          ],
                        ),)

                  );
                })
                : Container();
          } );

  }
  SharedPreferences?sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 150.0, // Set the desired width
          height: 60.0, // Set the desired height
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>form()));
            },
            child: Text("Add Menu"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
         "resturant",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),
             // sharedPreferences!.getString("name")!,
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 30.0),
        child: Column(
          children: [
            Expanded(child: allMenuDetails()),
           /*Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name : Burger",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
              Text("Description : Delicious",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
              Text("Price : 300tk",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),

            ],
          ),)

          ),*/
          ],
        ),

      ),
    );






    
  }
}

