import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pwar_pwar_gyi_app/model/category.dart';

class CategoryProvider extends StateNotifier<List<Category>> {
  CategoryProvider() : super([]);

  //Set the list of products
  void setCategories(List<Category> categories) {
    state = categories;
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryProvider, List<Category>>((ref) {
  return CategoryProvider();
});
