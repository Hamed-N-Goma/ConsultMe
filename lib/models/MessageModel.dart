class MessageModel {
  String? userId;
  String? consultId;
  String? dateTime;
  String? content;

  MessageModel({
    required this.userId,
    required this.consultId,
    required this.dateTime,
    required this.content,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
  {
    userId = json?['userId'];
    consultId = json?['consultId'];
    dateTime = json?['dateTime'];
    content = json?['content'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'senderId':userId,
      'receiverId':consultId,
      'dateTime':dateTime,
      'text':consultId,
    };
  }
}