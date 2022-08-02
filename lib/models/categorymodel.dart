class CategoryModel {
  String? name;
  String? image;
  String? id;


  CategoryModel({
    required this.name,
    required this.image,
    required this.id,

  });

  CategoryModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    image = json['image'];
    id = json['id'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      'name' : name,
      'image': image,
      'id'   : id,
    };
  }
}