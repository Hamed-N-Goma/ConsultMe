class CallMessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? channelName;
  String? token;

  CallMessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.channelName,
    this.token,
  });

  CallMessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    channelName = json['channelName'];
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'channelName': channelName,
      'token': token,
    };
  }
}
