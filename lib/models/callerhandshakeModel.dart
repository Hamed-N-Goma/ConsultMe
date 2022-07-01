class CallMessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? remoteDescription;
  String? candidate;

  CallMessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.remoteDescription,
    this.candidate,
  });

  CallMessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    remoteDescription = json['remoteDescription'];
    candidate = json['candidate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'remoteDescription': remoteDescription,
      'candidate': candidate,
    };
  }
}
