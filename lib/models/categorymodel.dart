class CategoryModel {
  String? name;
  String? image;

  CategoryModel({required this.image, required this.name});

  CategoryModel.fromJson(Map<dynamic, dynamic> categorymap) {
    if (categorymap == null) {
      return;
    } else {
      name = categorymap['name'];
      image = categorymap['image'];
    }
  }
  // TODO CREATE TO JESON METHOD OR REPOSOTRY TO RERUTN MAPPED CATEGORY DATA
}
