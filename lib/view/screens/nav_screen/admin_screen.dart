import 'package:flutter/material.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';
import 'package:pwar_pwar_gyi_app/view/screens/detail_screens/show_item_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/nav_screen/show_popular_items_screen.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/chart_announcement_widget.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/reusable_text_widget.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ChartAnnouncementWidget(
              color: MyColor.color2, text: "Warning! This is the announcement"),
          SizedBox(
            height: 10,
          ),
          ReusableTextWidget(
            directionWidget: ShowTopSaleItemsScreen(), text: "Top Sale Items", title: "See All >",
          ),
          SizedBox(height: 10),
          ReusableTextWidget(
              directionWidget: ShowTopSaleItemsScreen(), text: "All Items", title: '',
          ),
          SizedBox(height: 10),
          ShowItemScreen(),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
