class AppoinmentModel
{
  String? consultId;
  String? userID;
  String? resson;
  String? description;
  String? time;


  AppoinmentModel({
    required this.consultId,
    required this.userID,
    required this.resson,
    required this.description,
    required this.time,
  });

  AppoinmentModel.fromJson(Map<String, dynamic> json)
  {
    consultId = json['consultId'];
    userID = json['userID'];
    resson = json['resson'];
    description = json['description'];
    time = json['time'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'consultId':consultId,
      'userID':userID,
      'resson':resson,
      'description':description,
      'time':time,
    };
  }
}