import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/RestaurantModel.dart';
import '../model/UserModel.dart';

class FirebaseHelper {

  static Future<UserModel?> getUserModelById(String userUid) async {
    UserModel? userModel;

    DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection("users").doc(userUid).get();

    if(docSnap.data() != null) {
      userModel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return userModel;
  }

  static Future<RestaurantModel?> getRestaurantModelById(String restaurantUid) async {
    RestaurantModel? restaurantModel;

    DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection("Restaurant names").doc(restaurantUid).get();

    if(docSnap.data() != null) {
      restaurantModel = RestaurantModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return restaurantModel;
  }

}