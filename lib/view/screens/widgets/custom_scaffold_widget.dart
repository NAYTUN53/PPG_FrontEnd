import 'package:flutter/material.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';

class CustomScaffoldWidget extends StatelessWidget {
  const CustomScaffoldWidget({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: MyColor.color2),
          ),
          Positioned(
              top: 10,
              right: 0,
              left: 0,
              child: Image.asset(
                "assets/logo/logo.png",
                width: 220,
                height: 220,
              )),
          SafeArea(child: child!)
        ],
      ),
    );
  }
}
