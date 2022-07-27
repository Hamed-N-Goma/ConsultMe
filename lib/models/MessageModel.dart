class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? content;
  Map<String,dynamic>? messageImage;


  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    this.content,
    this.messageImage,

  });

  MessageModel.fromJson(Map<String, dynamic> json)
  {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    content = json['content'];
    messageImage = json['messageImage'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
      'content':content,
      'messageImage':messageImage,

    };
  }
}