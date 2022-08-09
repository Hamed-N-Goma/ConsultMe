class CallMessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? channelName;
  String? token;
  String? callType;
  String? callId;
  bool? callState;

  CallMessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.channelName,
    this.token,
    required this.callType,
    required this.callId,
    required this.callState,


  });

  CallMessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    channelName = json['channelName'];
    token = json['token'];
    callType = json['callType'];
    callId = json['callId'];
    callState = json['callState'];

  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'channelName': channelName,
      'token': token,
      'callType': callType,
      'callId': callId,
      'callState': callState,


    };
  }
}
