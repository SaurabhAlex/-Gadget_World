import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));
String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.desc,
    required this.status,
    required this.isFavourite,
  });

  String image;
  String id;
  String name;
  String price;
  String desc;
  String status;
  bool isFavourite;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        desc: json["desc"],
        status: json["status"],
        isFavourite: false,
      );


  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "desc": desc,
        "status": status,
        "isFavourite": isFavourite,
      };
}