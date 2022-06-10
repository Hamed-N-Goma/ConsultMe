class ComplaintModel {
   String? name;
   String? email;
   String? complaint;
   String? userType;


  ComplaintModel({
    required this.name,
    required this.email,
    required this.complaint,
    required this.userType,


  });

  ComplaintModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    email = json?['email'];
    complaint = json?['complaint'];
    userType = json? ['userType'];

  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "complaint": complaint,
      "userType" : userType,
    };
  }
}
