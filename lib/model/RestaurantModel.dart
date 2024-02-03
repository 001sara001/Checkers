class RestaurantModel {
  String? restaurantuid;
  String? fullRestaurantName;
  String? restaurantEmailAddress;
  String? profilepic;

  RestaurantModel({this.restaurantuid, this.fullRestaurantName, this.restaurantEmailAddress,this.profilepic});

  RestaurantModel.fromMap(Map<String, dynamic> map) {
    //"userUid": userCredential!.user!.uid,
    restaurantuid = map["restaurantUid"];
    fullRestaurantName = map["fullName"];
    restaurantEmailAddress = map["emailAddress"];
     profilepic = map["logo"];
  }

  Map<String, dynamic> toMap() {
    return {
      "restaurantUid": restaurantuid,
      "fullName": fullRestaurantName,
      "emailAddress": restaurantEmailAddress,
      "logo": profilepic,
    };
  }
}
