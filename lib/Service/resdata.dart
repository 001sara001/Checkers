import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseMethods{
  Future addMenuDetails(Map<String,dynamic>menuInfoMap,String id)async{
return await FirebaseFirestore.instance
    .collection("Menu")
    .doc(id)
    .set(menuInfoMap);

  }
  Future<Stream<QuerySnapshot>>getMenuDetails()async{
    return await FirebaseFirestore.instance.collection("Menu").snapshots();
   // .doc("").snapshots();

  }

}