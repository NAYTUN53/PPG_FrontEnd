import 'package:http/http.dart' as http;
import 'package:pwar_pwar_gyi_app/model/purchased_item.dart';
import '../global_variables.dart';
import '../services/manage_http_response.dart';

class PurchasedItemController {
  Future<void> uploadPurchasedItem({
    required String id,
    required String purchaseOrderId,
    required String itemId,
    required int quantity,
    required int price,
    required context,
  }) async {
    try {
      final PurchasedItem purchasedItem = PurchasedItem(
          id: id,
          purchaseOrderId: purchaseOrderId,
          itemId: itemId,
          quantity: quantity,
          price: price);

      await http.post(
          Uri.parse("$uri/api/purchasedItems"),
          body: purchasedItem.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
