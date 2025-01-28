import 'package:flutter/material.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/annimated_widget.dart';

class ChartAnnouncementWidget extends StatelessWidget {
  final Color color;
  final String text;

  const ChartAnnouncementWidget(
      {super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: screenWidth * 0.95,
          height: screenWidth < 600 ? 200 : 400,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: screenWidth * 0.95,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: MyColor.color1)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.campaign),
                AnnimatedWidget(
                  text: text,
                ),
              ],
            ),
          ),
        ),
        // SingleChildScrollView(child: const ShowItemScreen()),
      ],
    );
  }
}
