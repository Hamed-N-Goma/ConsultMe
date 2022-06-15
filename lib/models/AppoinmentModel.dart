class AppointmentModel
{
  String? appoId;
  String? consultName;
  String? consultSp;
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
    required this.appoId,
    required this.consultId,
    required this.consultName,
    required this.consultSp,
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
    appoId = json['appoId'];
    consultId = json['consultId'];
    consultName = json['consultName'];
    consultSp = json['consultSp'];
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
      'appoId' : appoId,
      'consultId':consultId,
      'consultName':consultName,
      'consultSp':consultSp,
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