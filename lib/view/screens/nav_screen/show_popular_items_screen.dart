import 'package:flutter/material.dart';

class ShowTopSaleItemsScreen extends StatelessWidget {
  const ShowTopSaleItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Top Sale Items"),
      ),
    );
  }
}
