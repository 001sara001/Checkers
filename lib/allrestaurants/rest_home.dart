//code

//more edits of this codes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/Service/resdata.dart';
import 'package:untitled1/allrestaurants/form.dart';
import 'package:fluttertoast/fluttertoast.dart';



class rest_home extends StatefulWidget {
  const rest_home({super.key});

  @override
  State<rest_home> createState() => _rest_homeState();
}

class _rest_homeState extends State<rest_home> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController descontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  Stream? MenuStream;
  String? userId; // Add this variable to store the user's UID
  String? RestName=FirebaseAuth.instance.currentUser?.displayName;
  getontheload() async {
    // Get the current user's UID
     userId = FirebaseAuth.instance.currentUser?.uid;
     RestName = FirebaseAuth.instance.currentUser?.displayName;
     print("User ID: $userId");
    if (userId != null) {
      MenuStream = await DatabaseMethods().getMenuDetails(userId!);
      setState(() {});
    }
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allMenuDetails(){
    return Container(
      child: StreamBuilder(
          stream:MenuStream,
          builder: (context,AsyncSnapshot snappshot) {
            return snappshot.hasData

                ? ListView.builder(
                itemCount: snappshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snappshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Material(
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
                              Row(

                                children: [
                                  Text("Name : " + ds["Name"], style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: (){
                                        namecontroller.text=ds["Name"];
                                        descontroller.text=ds["Description"];
                                        pricecontroller.text=ds["Price"];
                                        EditMenuDetails(ds["Id"]);
                                      },
                                      child:
                                      Icon(Icons.edit,color: Colors.black,)),
                                  SizedBox(width: 2.0,),
                                  GestureDetector(
                                      onTap: ()async{
                                        await DatabaseMethods().deletMenuDetail(ds["Id"],userId!);
                                      },
                                      child:
                                      Icon(Icons.delete,color: Colors.black,)),

                                ],
                              ),


                              Text("Description : " + ds["Description"],
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              Text("Price : " + ds["Price"]+"Tk", style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              // Displaying the image
                             ds["Image"] != null
                                  ? Image.network(
                                ds["Image"],
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                                fit: BoxFit.cover,
                              )
                                  : Container(),
                             /* Container(
                                height: 80,
                                width: 80,
                                child: ds["Image"] != null?
                                    Image.network(ds['Image']):Container(),
                              ),*/

                            ],
                          ),)

                    ),
                  );
                })
                : Container();
          } ),
    );

  }

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
      /*appBar: AppBar(

        backgroundColor:Colors.black87,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              RestName??"MENU",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),*/
      body: Container(
        margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 30.0),
        child: Column(
          children: [
            Expanded(child: allMenuDetails()),
          ],
        ),

      ),
    );


  }
  Future EditMenuDetails(String id)=>showDialog(context: context, builder:(context)=>AlertDialog(
    content: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            GestureDetector(onTap:(){
              Navigator.pop(context);
            } ,
              child: Icon(Icons.cancel),),
            SizedBox(width: 60,),
            Text(
              "Edit",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
              ),
              // sharedPreferences!.getString("name")!,
            ),
            Text(
              "Details",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
              ),
              // sharedPreferences!.getString("name")!,
            ),

          ],),
          SizedBox(height: 20.0,),
          Text("Item Name", style: TextStyle(color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(18)
            ),
            child: TextField(
              controller: namecontroller,
              decoration: InputDecoration(border: InputBorder.none),

            ),
          ),
          SizedBox(height: 10.0,),
          Text("Item Description", style: TextStyle(color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(18)
            ),
            child: TextField(
              controller: descontroller,
              decoration: InputDecoration(border: InputBorder.none),

            ),
          ),
          SizedBox(height: 10.0,),
          Text("Item Price", style: TextStyle(color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(18)
            ),
            child: TextField(
              controller: pricecontroller,
              decoration: InputDecoration(border: InputBorder.none),

            ),
          ),
          SizedBox(height: 30,),
          Center(child: ElevatedButton(onPressed:()async{
            Map<String, dynamic>updateInfo={
              "Name": namecontroller.text,
              "Description": descontroller.text,
              "Price": pricecontroller.text,
              "Id": id,

            };
            await DatabaseMethods().updateMenuDetail(id,userId!,updateInfo).then((value) {
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: "Updated Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            });
          },
              child: Text("Update")))
        ],),
    ),

  ));

}