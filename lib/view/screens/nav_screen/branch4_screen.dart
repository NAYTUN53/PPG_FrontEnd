import 'package:flutter/material.dart';
import 'package:pwar_pwar_gyi_app/view/screens/widgets/chart_announcement_widget.dart';

class Branch4Screen extends StatelessWidget {
  const Branch4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ChartAnnouncementWidget(
              color: Colors.purple, text: "Warning! This is the announcement"),
        ],
      ),
    ));
  }
}
