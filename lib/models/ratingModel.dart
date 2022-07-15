class RatingModel {
  dynamic? rating;
  String? sender;
  String? recever;

  RatingModel({
    required this.rating,
    required this.sender,
    required this.recever,
  });

  RatingModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    sender = json["sender"];
    recever = json['recever'];
  }

  Map<String, dynamic> tomap() {
    return {
      "rating": rating,
      "sender": sender,
      "recever": recever,
    };
  }
}
