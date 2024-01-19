import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:untitled1/Service/resdata.dart';
class form extends StatefulWidget {
  const form({super.key});

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController descontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Form",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),

      body: Container(
        margin: EdgeInsets.only(left: 25.0, top: 30.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Center(
              child :ElevatedButton(onPressed:()async{
                String Id = randomAlphaNumeric(10);
                Map<String,dynamic>menuInfoMap={
                  "Name":namecontroller.text,
                  "Description":descontroller.text,
                  "Price":pricecontroller.text,
                  "Id":Id,
                };
                await DatabaseMethods().addMenuDetails(menuInfoMap,Id).then((value) {
                Fluttertoast.showToast(
                msg: "Menu Detail Has been added succesfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
                );
                });
              },
                  child: Text("Add",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
              )
            ]
        ),


      ),
    );
  }
}
