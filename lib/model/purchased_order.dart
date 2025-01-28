import 'dart:convert';

class PurchasedOrder {
  final String id;
  final String supplierId;
  final String orderDate;
  final String deliveryStatus;
  final int totalAmount;

  PurchasedOrder(
      {required this.id,
      required this.supplierId,
        required this.orderDate,
      required this.deliveryStatus,
      required this.totalAmount});

  // Convert user object to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "supplierId": supplierId,
      "orderDate": orderDate,
      "deliveryStatus": deliveryStatus,
      "totalAmount": totalAmount,
    };
  }

  // Convert Map to Json
  String toJson() => json.encode(toMap());

  // Convert a Map to a User Object
  factory PurchasedOrder.fromMap(Map<String, dynamic> map) {
    return PurchasedOrder(
        id: map['_id'] as String? ?? "",
        supplierId: map['supplierId'] as String? ?? "",
        orderDate: map['orderDate'] as String? ?? "",
        deliveryStatus: map['deliveryStatus'] as String? ?? "",
        totalAmount: map['totalAmount'] as int ? ?? 0);
  }

  factory PurchasedOrder.fromJson(String source) =>
      PurchasedOrder.fromMap(json.decode(source) as Map<String, dynamic>);
}
