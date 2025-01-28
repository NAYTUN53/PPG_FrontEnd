import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';
import 'package:pwar_pwar_gyi_app/model/items.dart';

class ItemDetailScreen extends ConsumerStatefulWidget {
  final Items items;

  const ItemDetailScreen({super.key, required this.items});

  @override
  // ignore: library_private_types_in_public_api
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends ConsumerState<ItemDetailScreen> {
  @override
  void initState() {
    super.initState();
    // final relatedProducts = ref.read(relatedProductProvider);
    // if (relatedProducts.isEmpty) {
    //   _fetchProduct();
    // }
  }

  // Future<void> _fetchProduct() async {
  //   final ItemController itemController = ItemController();
  //   try {
  //     final items = await itemController
  //         .loadRelatedProductsBySubcategory(widget.product.id);
  //     ref
  //         .read(relatedProductProvider.notifier)
  //         .setProducts(products); // Store products in provider
  //   } catch (e) {
  //     throw Exception("Error in provider $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final cartProviderData = ref.read(cartProvider.notifier);
    // final cartData = ref.watch(cartProvider);
    // final isInCart = cartData.containsKey(widget.items.id);
    // final favouriteProviderData = ref.read(favouriteProvider.notifier);
    // ref.watch(favouriteProvider);
    // final relatedProduct = ref.watch(relatedProductProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Items Details",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            )),
        actions: [
          IconButton(
              onPressed: () {
                // favouriteProviderData.addProductToFavourite(
                //   productName: widget.product.productName,
                //   productPrice: widget.product.productPrice,
                //   category: widget.product.category,
                //   image: widget.product.images,
                //   vendorId: widget.product.vendorId,
                //   productQuantity: widget.product.quantity,
                //   quantity: 1,
                //   productId: widget.product.id,
                //   description: widget.product.description,
                //   fullName: widget.product.fullName,
                // );
                // showSnackBar(context,
                //     '${widget.product.productName} has been added to favourite list');
              },
              icon: //favouriteProviderData.getFavouriteItems
                  //     .containsKey(widget.product.id)
                  //     ?
                  const Icon(
                CupertinoIcons.cart,
                color: Colors.red,
              )
              // : const Icon(Icons.favorite_border),
              ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 260,
                height: 275,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 50,
                      child: Container(
                        width: 260,
                        height: 260,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(130),
                            color: const Color(0XFFD8DDFF)),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 22,
                      child: Container(
                        width: 216,
                        height: 274,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9CA8FF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: SizedBox(
                          height: 300,
                          child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.items.images.length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  widget.items.images[index],
                                  width: 198,
                                  height: 225,
                                  fit: BoxFit.cover,
                                );
                              }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.items.brand,
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.items.itemName,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.items.buyPrice.toString()} MMK",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.blueAccent),
                  ),
                  Text(
                    "4 items left",
                    style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: GoogleFonts.montserrat(
                        fontSize: 17,
                        letterSpacing: 1.7,
                        color: const Color(0xFF363330)),
                  ),
                  Text(
                    widget.items.description,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        letterSpacing: 1.0,
                        color: const Color(0xFF363330)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            // onTap: isInCart
            //     ? null
            //     : () {
            //         cartProviderData.addProductToCart(
            //             productName: widget.product.productName,
            //             productPrice: widget.product.productPrice,
            //             category: widget.product.category,
            //             image: widget.product.images,
            //             vendorId: widget.product.vendorId,
            //             productQuantity: widget.product.quantity,
            //             quantity: 1,
            //             productId: widget.product.id,
            //             description: widget.product.description,
            //             fullName: widget.product.fullName);
            //
            //         showSnackBar(context, widget.product.productName);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 80,
            height: 50,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: isInCart ? Colors.grey : const Color(0xFF3B54EE),
              color: MyColor.color2,
            ),
            child: Center(
              child: Text(
                "ADD TO CART",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
