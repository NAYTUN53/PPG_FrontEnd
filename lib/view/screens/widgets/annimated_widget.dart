import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AnnimatedWidget extends StatelessWidget {
  final String text;

  const AnnimatedWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      height: 40,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Marquee(
        text: text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
        blankSpace: 90,
        velocity: 30,
        pauseAfterRound: const Duration(seconds: 2),
      ),
    );
  }
}
