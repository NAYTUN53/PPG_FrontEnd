import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pwar_pwar_gyi_app/model/purchased_order.dart';
import '../global_variables.dart';

class PurchasedOrderController {
  Future<void> uploadPurchasedOrder({
    required String id,
    required String supplierId,
    required String orderDate,
    required String deliveryStatus,
    required int totalAmount,
    required context,
  }) async {
    try {
      final PurchasedOrder purchasedOrder = PurchasedOrder(
          id: id,
          supplierId: supplierId,
          orderDate: orderDate,
          deliveryStatus: deliveryStatus,
          totalAmount: totalAmount);

      await http.post(
          Uri.parse("$uri/api/purchasedOrder"),
          body: purchasedOrder.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get the last inserted orders
  Future<Map<String, dynamic>> loadLastOrders() async {
    try {
      http.Response response = await http.get(
          Uri.parse("$uri/api/last-orders"),
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
