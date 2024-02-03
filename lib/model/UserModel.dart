class UserModel {
  String? uid;
  String? fullName;
  String? emailAddress;
  //String? profilepic;

  UserModel({this.uid, this.fullName, this.emailAddress});

  UserModel.fromMap(Map<String, dynamic> map) {
    //"userUid": userCredential!.user!.uid,
    uid = map["userUid"];
    fullName = map["fullName"];
    emailAddress = map["emailAddress"];
   // profilepic = map["profileImageUrl"];
  }

  Map<String, dynamic> toMap() {
    return {
      "userUid": uid,
      "fullName": fullName,
      "emailAddress": emailAddress,
      //"profileImageUrl": profilepic,
    };
  }
}