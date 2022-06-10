class PostModel
{
  String? name;
  String? title;
  String? uid;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    required this.name,
    required this.title,
    required this.uid,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    title = json['title'];
    uid = json['uid'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'name':name,
      'title':title,
      'uid':uid,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
    };
  }
}