class ConsultantModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? userType;
  bool? accept;
  String? department;
  String? speachalist;
  String? yearsofExperience;
  String? image;
  String? imageOfCertificate;
  String? bio;
  num? rating;

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
    this.bio,
    this.rating,
  });

  ConsultantModel.fromJson(Map<String, dynamic>? json) {
    uid = json?['uid'];
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    userType = json?['userType'];
    department = json?['department'];
    speachalist = json?['speachalist'];
    yearsofExperience = json?['yearsofExperience'];
    image = json?['image'];
    imageOfCertificate = json?['imageOfCertificate'];
    accept = json?["accept"];
    bio = json?['bio'];
    rating = json?['rating'];
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
      "accept": accept,
      "bio": bio,
      "rating" : rating,
    };
  }
}
