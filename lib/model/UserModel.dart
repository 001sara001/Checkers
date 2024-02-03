class UserModel {
  String? uid;
  String? fullName;
  String? emailAddress;
  String? profilepic;

  UserModel({this.uid, this.fullName, this.emailAddress,this.profilepic});

  UserModel.fromMap(Map<String, dynamic> map) {
    //"userUid": userCredential!.user!.uid,
    uid = map["userUid"];
    fullName = map["username"];
    emailAddress = map["emailAddress"];
    profilepic = map["profileImageUrl"];
  }

  Map<String, dynamic> toMap() {
    return {
      "userUid": uid,
      "username": fullName,
      "emailAddress": emailAddress,
      "profileImageUrl": profilepic,
    };
  }
}