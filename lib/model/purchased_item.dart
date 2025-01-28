import 'dart:convert';

class PurchasedItem {
  final String id;
  final String purchaseOrderId;
  final String itemId;
  final int quantity;
  final int price;

  PurchasedItem({
    required this.id,
    required this.purchaseOrderId,
    required this.itemId,
    required this.quantity,
    required this.price,
  });

  // Convert user object to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "purchaseOrderId": purchaseOrderId,
      "itemId": itemId,
      "quantity": quantity,
      "price": price,
    };
  }

  // Convert Map to Json
  String toJson() => json.encode(toMap());

  // Convert a Map to a User Object
  factory PurchasedItem.fromMap(Map<String, dynamic> map) {
    return PurchasedItem(
        id: map['_id'] as String? ?? "",
        purchaseOrderId: map['purchaseOrderId'] as String? ?? "",
        itemId: map['itemId'] as String? ?? "",
        quantity: map['quantity'] as int? ?? 0,
        price: map['price'] as int? ?? 0);
  }

  factory PurchasedItem.fromJson(String source) =>
      PurchasedItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
