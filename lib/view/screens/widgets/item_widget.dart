import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pwar_pwar_gyi_app/model/items.dart';
import 'package:pwar_pwar_gyi_app/provider/item_provider.dart';

class ItemWidget extends ConsumerStatefulWidget {
  final Items items;

  const ItemWidget({super.key, required this.items});

  @override
  ConsumerState<ItemWidget> createState() => _ItemWidgetState();
}



class _ItemWidgetState extends ConsumerState<ItemWidget> {
  // @override
  // void initState(){
  //   super.initState();
  //   ref.read(itemProvider);
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final items = ref.watch(itemProvider);

    return InkWell(
      onTap: () {},
      child: items.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: screenWidth < 600 ? 160 : 200,
              height: screenWidth < 600 ? 60 : 150,
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.items.images[0],
                          width: screenWidth < 600 ? 200 : 250,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 4, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.items.itemName,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF212121)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${widget.items.buyPrice.toString()} MMK",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
