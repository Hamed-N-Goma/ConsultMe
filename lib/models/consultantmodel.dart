class ConsultantModel {
  late String uid;
  late String name;
  late String email;
  late String phone;
  late String userType;
  late bool accept;
  String? department;
  String? speachalist;
  String? yearsofExperience;
  String? image;
  String? imageOfCertificate;
  ConsultantModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    required this.accept,
    this.department,
    this.speachalist,
    this.yearsofExperience,
    this.image,
    this.imageOfCertificate,
  });

  ConsultantModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    userType = json['userType'];
    department = json['department'];
    speachalist = json['speachalist'];
    yearsofExperience = json['yearsofExperience'];
    image = json['image'];
    imageOfCertificate = json['imageOfCertificate'];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "userType": userType,
      "department": department,
      "speachalist": speachalist,
      "yearsofExperience": yearsofExperience,
      "image": image,
      "imageOfCertificate": imageOfCertificate,
      'accept': accept
    };
  }
}
