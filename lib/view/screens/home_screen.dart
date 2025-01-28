import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';
import 'package:pwar_pwar_gyi_app/model/user.dart';
import 'package:pwar_pwar_gyi_app/provider/user_provider.dart';
import 'package:pwar_pwar_gyi_app/view/screens/detail_screens/search_item_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/nav_screen/admin_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/nav_screen/branch1_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/nav_screen/branch2_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/nav_screen/branch3_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/nav_screen/branch4_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/nav_screen/branch5_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/drawer_widget.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  User? userData;
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider);
    return DefaultTabController(
      initialIndex: 0,
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Welcome to Pwar Pwar Gyi",
            style: GoogleFonts.montserrat(
              color: Colors.grey,
              letterSpacing: 0.5,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          toolbarHeight: 100,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchItemScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.search),
              color: MyColor.color1,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications_active,
                color: MyColor.color1,
              ),
            )
          ],
          // title: SizedBox(
          //   width: 300,
          //   height: 50,
          //   child: TextField(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const SearchItemScreen(),
          //         ),
          //       );
          //     },
          //     decoration: InputDecoration(
          //       contentPadding:
          //           const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          //       hintText: "Search bike",
          //       border: OutlineInputBorder(
          //         borderSide: const BorderSide(color: MyColor.color1),
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       hintStyle: const TextStyle(
          //         fontSize: 14,
          //         color: MyColor.textFieldColor,
          //       ),
          //       suffixIcon: const Icon(Icons.search),
          //     ),
          //   ),
          // ),
          bottom: ButtonsTabBar(
              backgroundColor: Colors.deepPurple,
              unselectedBackgroundColor: Colors.grey.shade200,
              unselectedLabelStyle: const TextStyle(color: Colors.black),
              splashColor: Colors.purpleAccent,
              labelSpacing: 10,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              labelStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              tabs: const [
                Tab(
                  icon: Icon(Icons.electric_bike),
                  text: "All",
                ),
                Tab(
                  icon: Icon(Icons.motorcycle),
                  text: "Branch1",
                ),
                Tab(
                  icon: Icon(Icons.directions_bike),
                  text: "Branch2",
                ),
                Tab(
                  icon: Icon(Icons.bike_scooter),
                  text: "Branch3",
                ),
                Tab(
                  icon: Icon(Icons.moped),
                  text: "Branch4",
                ),
                Tab(
                  icon: Icon(Icons.electric_moped),
                  text: "Branch5",
                ),
              ]),
        ),
        body: const TabBarView(
          children: [
            AdminScreen(),
            Branch1Screen(),
            Branch2Screen(),
            Branch3Screen(),
            Branch4Screen(),
            Branch5Screen(),
          ],
        ),
        drawer: DrawerWidget(text: userData!.role)
      ),
    );
  }
}
