import 'dart:convert';

class Items {
  final String id;
  final List<String> images;
  final String itemCode;
  final String categoryId;
  final String brand;
  final String itemName;
  final int buyPrice;
  final List<Map<String, dynamic>> warranty;
  final String description;

  Items(
      {required this.id,
      required this.images,
      required this.itemCode,
      required this.categoryId,
      required this.brand,
      required this.itemName,
      required this.buyPrice,
      required this.warranty,
        required this.description});

  // Convert user object to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "images": images,
      "itemCode": itemCode,
      "categoryId": categoryId,
      "brand": brand,
      "itemName": itemName,
      "buyPrice": buyPrice,
      "warranty": warranty,
      "description": description,
    };
  }

  // Convert Map to Json
  String toJson() => json.encode(toMap());

  // Convert a Map to a User Object
  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
        id: map['_id'] as String? ?? "",
        images: List<String>.from(map['images'] as List<dynamic>? ?? []),
        itemCode: map['itemCode'] as String? ?? "",
        categoryId: map['categoryId'] as String? ?? "",
        brand: map['brand'] as String? ?? "",
        itemName: map['itemName'] as String? ?? "",
        buyPrice: map['buyPrice'] as int? ?? 0,
        description: map['description'] as String? ?? "",
        warranty: List<Map<String, dynamic>>.from(map["warranty"] as List));
  }

  factory Items.fromJson(String source) =>
      Items.fromMap(json.decode(source) as Map<String, dynamic>);
}
