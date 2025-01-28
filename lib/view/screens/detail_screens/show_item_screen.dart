import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';
import 'package:pwar_pwar_gyi_app/controller/item_controller.dart';
import 'package:pwar_pwar_gyi_app/model/items.dart';
import 'package:pwar_pwar_gyi_app/provider/item_provider.dart';
import 'package:pwar_pwar_gyi_app/view/screens/detail_screens/item_detail_screen.dart';

class ShowItemScreen extends ConsumerStatefulWidget {
  const ShowItemScreen({super.key});

  @override
  ConsumerState<ShowItemScreen> createState() => _ShowItemScreenState();
}

class _ShowItemScreenState extends ConsumerState<ShowItemScreen> {
  bool isLoading = true;
  Items? items;

  @override
  void initState() {
    super.initState();
    // final items = ref.read(itemProvider);

    _fetchItems();
  }

  Future<void> _fetchItems() async {
    final ItemController itemController = ItemController();
    try {
      final items = await itemController.loadItems();
      ref.read(itemProvider.notifier).setItems(items);
    } catch (e) {
      throw Exception("Error saving in provider $e");
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
    final items = ref.watch(itemProvider);
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: childAspectRatio,
                crossAxisCount: crossAxisCount),
            itemBuilder: (context, index) {
              final item = items[index];
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ItemDetailScreen(items: item);
                  }));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: screenWidth < 600 ? 180 : 250,
                  height: screenWidth < 600 ? 150 : 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(
                          width: screenWidth < 600 ? 200 : 250,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.images[0],
                                width: screenWidth < 600 ? 200 : 250,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 35,
                                  height: 25,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0),
                                      ),
                                      color: MyColor.color1),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        // :TODO Add Item to Cart
                                      },
                                      child: const Icon(
                                          size: 20,
                                          color: MyColor.color2,
                                          CupertinoIcons.cart),
                                    ),
                                  ),
                                )),
                          ]),
                        ),
                      ]),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 4, right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.brand,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                Text(
                                  '4 items left',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              item.itemName,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF212121)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${item.buyPrice.toString()} MMK",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
  }
}
