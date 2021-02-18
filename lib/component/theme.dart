import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme1 {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      fontFamily: GoogleFonts.itim().fontFamily,
      primaryColor: kPkThemeShade1,
      accentColor: kPkThemeShade1,
      cardColor: kWhiteBgColor,
      backgroundColor: kPkThemeShade1,
      highlightColor: kMVThemeShade1,
      splashColor: kDYThemeShade1);

  static ThemeData calenderTheme(BuildContext context) => ThemeData(
      fontFamily: GoogleFonts.itim().fontFamily,
      colorScheme: ColorScheme.light(
        primary: Colors.deepPurple,
        onPrimary: Colors.white,
        surface: Colors.pink,
        onSurface: kBlackDark,
      ));
}
