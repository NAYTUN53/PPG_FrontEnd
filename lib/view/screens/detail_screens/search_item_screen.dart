import 'package:flutter/material.dart';
import 'package:pwar_pwar_gyi_app/controller/item_controller.dart';
import 'package:pwar_pwar_gyi_app/model/items.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/item_widget.dart';

class SearchItemScreen extends StatefulWidget {
  const SearchItemScreen({super.key});

  @override
  State<SearchItemScreen> createState() => _SearchItemScreenState();
}

class _SearchItemScreenState extends State<SearchItemScreen> {
  TextEditingController searchItemController = TextEditingController();
  ItemController itemController = ItemController();
  List<Items> searchItems = [];
  bool isLoading = false;

  searchProduct() async {
    setState(() {
      isLoading = true;
    });

    try {
      String query = searchItemController.text.trim();
      if (query.isNotEmpty) {
        List<Items> items = await itemController.searchProducts(query);
        setState(() {
          searchItems = items;
        });
      }
    } catch (e) {
      throw Exception("Error loading in searched products");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 4;
    final childAspectRatio = screenWidth < 600 ? 3 / 3.5 : 4 / 5;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: TextField(
          controller: searchItemController,
          decoration: InputDecoration(
            label: const Text("Search Item"),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: IconButton(
              onPressed: () {
                searchProduct();
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      )
          : searchItems.isEmpty
          ? const Center(
        child: Text("No Product Found"),
      )
          : Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: searchItems.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      crossAxisCount: crossAxisCount),
                  itemBuilder: (context, index) {
                    final searchedItem = searchItems[index];

                    return ItemWidget(items: searchedItem);
                  }))
        ],
      ),
    );
  }
}
