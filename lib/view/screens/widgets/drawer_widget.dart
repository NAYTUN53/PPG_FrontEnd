import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';
import 'package:pwar_pwar_gyi_app/view/screens/detail_screens/category_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/nav_screen/account_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/nav_screen/expense_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/nav_screen/service_fees_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/nav_screen/supplier_screen.dart';

class DrawerWidget extends StatelessWidget {
  final String text;

  const DrawerWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade300,
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/logo/logo.png",
                  width: 135,
                  height: 135,
                  fit: BoxFit.cover,
                ),
                Text(
                  text,
                  style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        BoxShadow(
                            color: MyColor.color1,
                            blurRadius: 5,
                            offset: Offset(1.5, 1.5))
                      ]),
                )
              ],
            )
          ])),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            title: const Text("Home Screen"),
            leading: const Icon(Icons.home),
            trailing: const Icon(Icons.navigate_next),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountScreen()));
            },
            title: const Text("Account"),
            leading: const Icon(CupertinoIcons.profile_circled),
            trailing: const Icon(Icons.navigate_next),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CategoryScreen();
              }));
            },
            title: const Text("Category"),
            leading: const Icon(Icons.category),
            trailing: const Icon(Icons.navigate_next),
          ),

          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SupplierScreen()));
            },
            title: const Text("Suppliers"),
            leading: Image.asset("assets/logo/hotel-supplier.png",
            color: const Color.fromARGB(175, 0, 0, 0),
            width: 25,
              height: 25,
            ),
            trailing: const Icon(Icons.navigate_next),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExpenseScreen()));
            },
            title: const Text("Expense"),
            leading: const Icon(Icons.attach_money_rounded),
            trailing: const Icon(Icons.navigate_next),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ServiceFeesScreen()));
            },
            title: const Text("Service Fees"),
            leading: const Icon(Icons.settings_applications),
            trailing: const Icon(Icons.navigate_next),
          ),

          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ServiceFeesScreen()));
            },
            title: const Text("Contact Support"),
            leading: const Icon(Icons.contact_support_outlined),
            trailing: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
