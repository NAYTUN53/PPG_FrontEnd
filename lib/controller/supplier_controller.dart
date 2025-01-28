import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pwar_pwar_gyi_app/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:pwar_pwar_gyi_app/model/supplier.dart';

class SupplierController {
  Future<void> uploadSupplier({
    required String id,
    required String supplierName,
    required String email,
    required String phone,
    required String address,
    required BuildContext context,
  }) async {
    try {
      final Supplier supplier = Supplier(
          id: id,
          supplierName: supplierName,
          email: email,
          phone: phone,
          address: address);

      await http.post(
          Uri.parse("$uri/api/suppliers"),
          body: supplier.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

    } catch (e) {
      throw Exception(e.toString());
    }
  }


  // Load the supplier information
  Future<List<Supplier>> loadSupplier() async {
    try {
      http.Response response = await http.get(
          Uri.parse("$uri/api/get-suppliers"),
          headers: {"Content-Type": "application/json; charset=UTF-8"});

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((supplier) => Supplier.fromMap(supplier)).toList();
      }
      else if(response.statusCode == 404){
        return [];
      }
      else {
        throw Exception("Failed to load Suppliers.");
      }
    } catch (e) {
      throw Exception("Error loading suppliers:  $e");
    }
  }

  // Load the supplier information by Supplier Id
  Future<Map<String, dynamic>> loadSupplierBySupplierId(String supplierId) async {
    try {
      http.Response response = await http.get(
          Uri.parse("$uri/api/suppliers/$supplierId"),
          headers: {"Content-Type": "application/json; charset=UTF-8"});
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Failed to load Suppliers.");
      }
    } catch (e) {
      throw Exception("Error loading suppliers:  $e");
    }
  }

  // Get the last inserted supplier
// Load the supplier information by Supplier Id
  Future<Map<String, dynamic>> loadLastSupplier() async {
    try {
      http.Response response = await http.get(
          Uri.parse("$uri/api/last-suppliers"),
          headers: {"Content-Type": "application/json; charset=UTF-8"});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Failed to load Suppliers.");
      }
    } catch (e) {
      throw Exception("Error loading suppliers:  $e");
    }
  }
}
