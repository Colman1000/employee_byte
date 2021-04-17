import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData.light().copyWith(
        textTheme: GoogleFonts.robotoCondensedTextTheme(),
      );

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        textTheme: GoogleFonts.robotoCondensedTextTheme(),
      );
}
