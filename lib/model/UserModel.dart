class UserModel {
  String? uid;
  String? fullName;
  String? emailAddress;
  //String? profilepic;

  UserModel({this.uid, this.fullName, this.emailAddress});

  UserModel.fromMap(Map<String, dynamic> map) {
    //"userUid": userCredential!.user!.uid,
    uid = map["userUid"];
    fullName = map["username"];
    emailAddress = map["emailAddress"];
   // profilepic = map["profilepic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "userUid": uid,
      "username": fullName,
      "emailAddress": emailAddress,
      //"profilepic": profilepic,
    };
  }
}