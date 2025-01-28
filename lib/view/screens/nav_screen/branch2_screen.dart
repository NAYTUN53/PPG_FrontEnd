import 'package:flutter/material.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/chart_announcement_widget.dart';

class Branch2Screen extends StatelessWidget {
  const Branch2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ChartAnnouncementWidget(
              color: Colors.blue, text: "Warning! This is the announcement"),
        ],
      ),
    ));
  }
}
