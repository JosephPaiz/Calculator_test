import 'package:flutter/material.dart';
//Fonts
import 'package:google_fonts/google_fonts.dart';

class Style {
  //BackgroundAPp
  static const Color backgroundColor = Color(0xFF000000);

  //Buttons
  static const Color backgroundColorBtn = Color(0xFF262628);
  static const Color textColorbtn = Color(0xFF0882FF);
  static final btnTextStyle = GoogleFonts.sofiaSans(
    textStyle: const TextStyle(
        fontSize: 40, color: Color(0xFF0882FF), fontWeight: FontWeight.bold),
  );
  //View
  static final mainResultStyle = GoogleFonts.crimsonPro(
    textStyle: const TextStyle(
        fontSize: 70, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
  );

  static final secondaryResultStyle = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color(0xFF47CD6C),
    ),
  );
}
