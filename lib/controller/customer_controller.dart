import 'package:flutter/material.dart';
import 'package:pwar_pwar_gyi_app/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:pwar_pwar_gyi_app/model/customer.dart';

class CustomerController {
  Future<void> uploadCustomer({
    required String id,
    required String customerName,
    required String email,
    required String phone,
    required String address,
    required BuildContext context,
  }) async {
    try {
      final Customer customer = Customer(
          id: id,
          customerName: customerName,
          email: email,
          phone: phone,
          address: address);

      await http.post(Uri.parse("$uri/api/customers"),
          body: customer.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
