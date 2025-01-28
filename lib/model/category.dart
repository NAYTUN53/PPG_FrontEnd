import 'dart:convert';

class Category {
  final String id;
  final String categoryName;
  final String description;

  Category(
      {required this.id,
      required this.categoryName,
      required this.description});

  // Convert user object to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "categoryName": categoryName,
      "description": description,
    };
  }

  // Convert Map to Json
  String toJson() => json.encode(toMap());

  // Convert a Map to a User Object
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'] as String? ?? "",
      categoryName: map['categoryName'] as String? ?? "",
      description: map['description'] as String? ?? "",
    );
  }

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
