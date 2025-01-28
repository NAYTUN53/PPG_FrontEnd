import 'dart:convert';
import 'dart:io';
import 'package:pwar_pwar_gyi_app/global_variables.dart';
import 'package:pwar_pwar_gyi_app/model/items.dart';
import 'package:pwar_pwar_gyi_app/services/manage_http_response.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';

class ItemController {
  Future<void> uploadItems({
    required String id,
    required List<File>? pickedImages,
    required String itemCode,
    required String categoryId,
    required String brand,
    required String itemName,
    required int buyPrice,
    required List<Map<String, dynamic>> warranty,
    required String description,
    required context,
  }) async {
    try {
      if (pickedImages != null) {
        final cloudinary = CloudinaryPublic("dymyqeyyw", "t2mdxedr");
        List<String> images = [];

        for (int i = 0; i < pickedImages.length; i++) {
          CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
              CloudinaryFile.fromFile(pickedImages[i].path, folder: brand));

          images.add(cloudinaryResponse.secureUrl);
        }

        if (categoryId.isNotEmpty && itemName.isNotEmpty) {
          final Items items = Items(
              id: id,
              images: images,
              itemCode: itemCode,
              categoryId: categoryId,
              brand: brand,
              itemName: itemName,
              buyPrice: buyPrice,
              warranty: warranty,
              description: description);

          http.Response response = await http.post(
              Uri.parse("$uri/api/add-items"),
              body: items.toJson(),
              headers: <String, String>{
                "Content-Type": "application/json; charset=UTF-8",
              });
          manageHttpResponse(
              response: response,
              context: context,
              onSuccess: () {
                showSnackBar(context, "Items have successfully uploaded.");
              });
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get items
  Future<List<Items>> loadItems() async {
    try {
      // Send an http request to get the items
      http.Response response = await http
          .get(Uri.parse("$uri/api/get-items"), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      });

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Items> items = data.map((item) {
          return Items.fromMap(item as Map<String, dynamic>);
        }).toList();
        // List<Items> items = data.map((item) => Items.fromJson(item)).toList();
        return items;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception("Error found in loading items");
      }
    } catch (e) {
      throw Exception('Failed to load items $e');
    }
  }

  // Get the last inserted orders
  Future<Map<String, dynamic>> loadLastItems() async {
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/last-items"),
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
  //
  // // Delete Order by Id
  // Future<void> deleteOrder({required String id, required context}) async {
  //   try {
  //     http.Response response = await http
  //         .delete(Uri.parse("$uri/api/orders/$id"), headers: <String, String>{
  //       "Content-Type": "application/json; charset=UTF-8",
  //     });
  //
  //     manageHttpResponse(
  //         response: response,
  //         context: context,
  //         onSuccess: () {
  //           showSnackBar(context, "Your items was successfully deleted.");
  //         });
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  // Search Products
  Future<List<Items>> searchProducts(String query) async {
    try {
      http.Response response = await http.get(
          Uri.parse("$uri/api/search-items?query=$query"),
          headers: <String, String>{
            "Content-Type": "application/json; charset = UTF-8"
          });

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        List<Items> searchedItems = data.map((item) {
          return Items.fromMap(item as Map<String, dynamic>);
        }).toList();
        return searchedItems;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception("Failed to load searched products");
      }
    } catch (e) {
      throw Exception("Error fetching in searched products");
    }
  }
}
