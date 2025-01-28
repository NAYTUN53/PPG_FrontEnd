import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pwar_pwar_gyi_app/model/items.dart';

class ItemProvider extends StateNotifier<List<Items>> {
  ItemProvider() : super([]);

  //Set the list of products
  void setItems(List<Items> items) {
    state = items;
  }
}

final itemProvider = StateNotifierProvider<ItemProvider, List<Items>>((ref) {
  return ItemProvider();
});
