import 'dart:convert';

class Supplier {
  final String id;
  final String supplierName;
  final String email;
  final String phone;
  final String address;

  Supplier(
      {required this.id,
        required this.supplierName,
        required this.email,
        required this.phone,
        required this.address});

  // Convert user object to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "supplierName": supplierName,
      "email": email,
      "phone": phone,
      "address": address,
    };
  }

  // Convert Map to Json
  String toJson() => json.encode(toMap());

  // Convert a Map to a User Object
  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['_id'] as String? ?? "",
      supplierName: map['supplierName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      phone: map['phone'] as String? ?? "",
      address: map['address'] as String? ?? "",
    );
  }

  factory Supplier.fromJson(String source) =>
      Supplier.fromMap(json.decode(source) as Map<String, dynamic>);


}
