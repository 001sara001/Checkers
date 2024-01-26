class UserModel {
  String? uid;
  String? fullName;
  String? emailAddress;
  //String? profilepic;

  UserModel({this.uid, this.fullName, this.emailAddress});

  UserModel.fromMap(Map<String, dynamic> map) {
    //"userUid": userCredential!.user!.uid,
    uid = map["uid"];
    fullName = map["fullname"];
    emailAddress = map["email"];
   // profilepic = map["profilepic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullName,
      "email": emailAddress,
      //"profilepic": profilepic,
    };
  }
}