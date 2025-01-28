import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pwar_pwar_gyi_app/constants.dart';

class ReusableTextWidget extends StatelessWidget {
  final Widget directionWidget;
  final String text;
  final String title;

  const ReusableTextWidget({super.key, required this.directionWidget, required this.text, required this.title});




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.montserrat(
                fontSize: 16,
                color: MyColor.color2,
                fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return directionWidget;
              }));
            },
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: MyColor.color2,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
