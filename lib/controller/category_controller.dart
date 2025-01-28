import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pwar_pwar_gyi_app/global_variables.dart';
import 'package:pwar_pwar_gyi_app/model/category.dart';
import 'package:http/http.dart' as http;
import 'package:pwar_pwar_gyi_app/services/manage_http_response.dart';

class CategoryController {
  Future<void> uploadCategory({
    required String id,
    required String categoryName,
    required String description,
    required BuildContext context,
  }) async {
    try {
      final Category category = Category(
          id: id, categoryName: categoryName, description: description);

      http.Response response = await http.post(
          Uri.parse("$uri/api/add-category"),
          body: category.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Categories have successfully uploaded.");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get items
  // Load the uploaded categories
  Future<List<Category>> loadCategories() async {
    try {
      http.Response response = await http.get(
          Uri.parse("$uri/api/get-category"),
          headers: {"Content-Type": "application/json; charset=UTF-8"});

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((category) => Category.fromMap(category))
            .toList();

      } else {
        throw Exception("Failed to load categories.");
      }
    } catch (e) {
      throw Exception("Error loading categories:  $e");
    }
  }
}
