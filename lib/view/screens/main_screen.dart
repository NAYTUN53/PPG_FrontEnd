import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';
import 'package:pwar_pwar_gyi_app/view/screens/cart_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/detail_screens/add_item_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/home_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/inventory_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/report_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/sale_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // int _pageIndex = 0;
  // final List<Widget> _pages = [
  //   const HomeScreen(),
  //   const SaleScreen(),
  //   const ReportScreen(),
  //   const CartScreen(),
  //   const InventoryScreen()
  // ];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
        bottomNavigationBar: Obx(
          () => ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: NavigationBar(
                backgroundColor: Colors.grey.shade200,
                labelBehavior:
                NavigationDestinationLabelBehavior.onlyShowSelected,
                height: 70,
                elevation: 10,
                selectedIndex: controller.selectedIndex.value,
                onDestinationSelected: (index) =>
                    controller.selectedIndex.value = index,
                destinations: const [
                  NavigationDestination(
                    selectedIcon: Icon(Icons.home),
                      icon: Icon(
                        Icons.home_outlined,
                        color: MyColor.color2,
                      ),
                      label: "Home"),
                  NavigationDestination(
                    selectedIcon: Icon(Icons.sell),
                      icon: Icon(
                        Icons.sell_outlined,
                        color: MyColor.color2,
                      ),
                      label: "Sale"),
                  NavigationDestination(
                      selectedIcon: Icon(CupertinoIcons.doc_fill),
                      icon: Icon(
                        CupertinoIcons.doc,
                        color: MyColor.color2,
                      ),
                      label: "Report"),
                  NavigationDestination(
                    selectedIcon: Icon(CupertinoIcons.cart_fill),
                      icon: Icon(
                        CupertinoIcons.cart,
                        color: MyColor.color2,
                      ),
                      label: "Cart"),
                  NavigationDestination(
                    selectedIcon: Icon(Icons.inventory),
                      icon: Icon(
                        Icons.inventory_2_outlined,
                        color: MyColor.color2,
                      ),
                      label: "Inventory"),
                ]),
          ),
        ),

        // bottomNavigationBar: BottomNavigationBar(
        //     elevation: 20,
        //     selectedItemColor: Colors.purple,
        //     unselectedItemColor: Colors.grey,
        //     type: BottomNavigationBarType.fixed,
        //     onTap: (value) {
        //       setState(() {
        //         _pageIndex = value;
        //       });
        //     },
        //     items: const [
        //       BottomNavigationBarItem(
        //           icon: Icon(CupertinoIcons.home), label: "Home"),
        //       BottomNavigationBarItem(
        //           icon: Icon(CupertinoIcons.money_dollar), label: "Sale"),
        //       BottomNavigationBarItem(
        //           icon: Icon(CupertinoIcons.doc), label: "Report"),
        //       BottomNavigationBarItem(
        //           icon: Icon(CupertinoIcons.cart), label: "Cart"),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.inventory_2_outlined), label: "Inventory"),
        //     ]),
        body: Obx(() => controller.screens[controller.selectedIndex.value]),
        // _pages[_pageIndex],
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AddItemScreen();
                },
              ),
            );
          },
          backgroundColor: MyColor.color2,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const SaleScreen(),
    const ReportScreen(),
    const CartScreen(),
    const InventoryScreen()
  ];
}
