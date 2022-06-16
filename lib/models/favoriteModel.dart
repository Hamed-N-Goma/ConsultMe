class FavoriteModel {
  String? favoriteConsultant;
  FavoriteModel({
    this.favoriteConsultant,
  });
  FavoriteModel.fronJson(Map<String, dynamic>? json) {
    favoriteConsultant = json?['favoriteConsultant'];
  }

  Map<String, dynamic> toMap() {
    return {"favoriteConsultant": favoriteConsultant};
  }
}
