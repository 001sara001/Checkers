import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseMethods{
  //CREATE
  Future addMenuDetails(Map<String,dynamic>menuInfoMap,String id)async{
return await FirebaseFirestore.instance
    .collection("Menu")
    .doc(id)
    .set(menuInfoMap);

  }
  //FETCH
  Future<Stream<QuerySnapshot>>getMenuDetails()async{
    return await FirebaseFirestore.instance.collection("Menu").snapshots();
   // .doc("").snapshots();

  }
//UPDATE
  Future updateMenuDetail(String id,Map<String,dynamic>updateInfo)async{
    return await FirebaseFirestore.instance.collection("Menu").doc(id).update(updateInfo);

  }
  //DELETE
  Future deletMenuDetail(String id)async{
    return await FirebaseFirestore.instance.collection("Menu").doc(id).delete();

  }



}