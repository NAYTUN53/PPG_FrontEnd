import 'dart:convert';

class Customer {
  final String id;
  final String customerName;
  final String email;
  final String phone;
  final String address;

  Customer(
      {required this.id,
        required this.customerName,
        required this.email,
        required this.phone,
        required this.address});

  // Convert user object to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "customerName": customerName,
      "email": email,
      "phone": phone,
      "address": address,
    };
  }

  // Convert Map to Json
  String toJson() => json.encode(toMap());

  // Convert a Map to a User Object
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['_id'] as String? ?? "",
      customerName: map['customerName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      phone: map['phone'] as String? ?? "",
      address: map['address'] as String? ?? "",
    );
  }

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);


}
