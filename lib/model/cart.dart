import 'dart:convert';

class Cart {
  final String id;
  final List<String> images;
  final String itemName;
  final String type;
  final String categoryId;
  final String brand;
  final String model;
  final int price;
  final String description;
  final List<Map<String, dynamic>> warranty;

  Cart(
      {required this.id,
        required this.images,
        required this.itemName,
        required this.type,
        required this.categoryId,
        required this.brand,
        required this.model,
        required this.price,
        required this.description,
        required this.warranty});

  // Convert user object to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "images": images,
      "itemName": itemName,
      "type": type,
      "categoryId": categoryId,
      "brand": brand,
      "model": model,
      "price": price,
      "description": description,
      "warranty": warranty,
    };
  }

  // Convert Map to Json
  String toJson() => json.encode(toMap());

  // Convert a Map to a User Object
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
        id: map['_id'] as String? ?? "",
        images: List<String>.from(map['images'] as List<dynamic>? ?? []),
        itemName: map['itemName'] as String? ?? "",
        type: map['type'] as String? ?? "",
        categoryId: map['categoryId'] as String? ?? "",
        brand: map['brand'] as String? ?? "",
        model: map['model'] as String? ?? "",
        price: map['price'] as int? ?? 0,
        description: map['description'] as String? ?? "",
        warranty:  List<Map<String, dynamic>>.from(map["warranty"] as List));
  }

  factory Cart.fromJson(String source) =>
      Cart.fromMap(json.decode(source) as Map<String, dynamic>);
}
