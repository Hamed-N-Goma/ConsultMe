class UserModel {
  late String uid;
  late String name;
  late String email;
  late String phone;
  late String userType;

  String? image;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    userType = json['userType'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "userType": userType,
      "image": image,
    };
  }
}
