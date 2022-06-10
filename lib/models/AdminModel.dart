class AdminModel {
  late String uid;
  late String name;
  late String email;
  late String userType;

  String? image;
  AdminModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.userType,
    this.image,
  });

  AdminModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    uid = json?['uid'];
    email = json?['email'];
    userType = json?['userType'];
    image = json?['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "userType": userType,
      "image": image,
    };
  }
}
