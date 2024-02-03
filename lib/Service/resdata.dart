import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DatabaseMethods{
  //CREATE
  Future addMenuDetails(Map<String,dynamic>menuInfoMap,String id)async{
return await FirebaseFirestore.instance
    .collection("Menu")
    .doc(id)
    .set(menuInfoMap);

  }
  Future<void> addMenuDetailsForUser(
      Map<String, dynamic> menuInfoMap, String userId, String menuId) async {
    await FirebaseFirestore.instance
        .collection("Restaurant names") // Change this to the users collection
        .doc(userId)
        .collection("Menus") // Sub-collection under the user's UID
        .doc(menuId)
        .set(menuInfoMap);
  }



  //FETCH
 Future<Stream<QuerySnapshot>>getMenuDetails(String userId)async{
    return await FirebaseFirestore.instance.collection("Restaurant names").doc(userId).collection("Menus").snapshots();
   // .doc("").snapshots();

  }
 /* Stream getMenuDetails(String userId) {
    return FirebaseFirestore.instance
        .collection("Restaurant names")
        .doc(userId)
        .collection("Menus")
        .snapshots();
  }*/

//UPDATE
  Future updateMenuDetail(String id,String userId,Map<String,dynamic>updateInfo)async{
    return await FirebaseFirestore.instance.collection("Restaurant names").doc(userId).collection("Menus").doc(id).update(updateInfo);

  }
  //DELETE
  Future deletMenuDetail(String id,String userId)async{
    return await FirebaseFirestore.instance.collection("Restaurant names").doc(userId).collection("Menus").doc(id).delete();

  }



}