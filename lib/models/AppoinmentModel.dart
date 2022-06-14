class AppointmentModel
{
  String? consultId;
  String? userID;
  String? userName;
  String? userPhone;
  String? userEmail;
  String? resson;
  String? description;
  String? time;
  String? MeetTime;
  bool? accept;


  AppointmentModel({
    required this.consultId,
    required this.userEmail,
    required this.MeetTime,
    required this.accept,
    required this.userName,
    required this.userPhone,
    required this.userID,
    required this.resson,
    required this.description,
    required this.time,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json)
  {
    consultId = json['consultId'];
    MeetTime = json['MeetTime'];
    accept = json['accept'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    userID = json['userID'];
    resson = json['resson'];
    description = json['description'];
    time = json['time'];
  }


  Map<String, dynamic> toMap()
  {
    return {
      'consultId':consultId,
      'userEmail' : userEmail,
      'userName' : userName,
      'userPhone' : userPhone,
      'userID':userID,
      'resson':resson,
      'description':description,
      'time':time,
      'MeetTime':MeetTime,
      'accept':accept,
    };
  }
}