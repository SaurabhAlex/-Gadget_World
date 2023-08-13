import 'dart:convert';


CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));
String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.image,
    required this.id,
  });

  String image;
  String id;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(
        id: json["id"],
        image: json["image"],
      );


  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "image": image,
      };
}