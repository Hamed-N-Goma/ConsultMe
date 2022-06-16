class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? content;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.content,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
  {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    content = json['content'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
      'content':content,
    };
  }
}