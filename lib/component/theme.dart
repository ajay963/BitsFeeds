import 'package:bits_news/component/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      accentColor: kPkThemeShade1,
      cardColor: Colors.white,
      shadowColor: kShadowLightModeTheme,
      backgroundColor: kBGLightModeTheme,
      iconTheme: IconThemeData(color: kDarkTextLightModeTheme),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontFamily: GoogleFonts.itim().fontFamily,
            color: kDarkTextLightModeTheme,
            fontSize: 28),
        headline2: TextStyle(
            fontFamily: GoogleFonts.itim().fontFamily,
            color: kLightTextLightModeTheme,
            fontSize: 20),
        headline3: TextStyle(
            fontFamily: GoogleFonts.itim().fontFamily,
            color: kDarkTextLightModeTheme,
            fontSize: 24),
        bodyText1: TextStyle(
            fontFamily: GoogleFonts.delius().fontFamily,
            color: kDarkTextLightModeTheme,
            fontSize: 16),
        bodyText2: TextStyle(
            fontFamily: GoogleFonts.itim().fontFamily,
            color: kLightTextLightModeTheme,
            fontSize: 18),
      ));

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.light,
      accentColor: kPkThemeShade1,
      cardColor: kBoxColorDarkModeTheme,
      shadowColor: kShadowDarkModeTheme,
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: kLightTextDarkModeTheme),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontFamily: GoogleFonts.itim().fontFamily,
            color: kLightTextDarkModeTheme,
            fontSize: 28),
        headline2: TextStyle(
            fontFamily: GoogleFonts.itim().fontFamily,
            color: kDarkTextDarkModeTheme,
            fontSize: 20),
        headline3: TextStyle(
            fontFamily: GoogleFonts.itim().fontFamily,
            color: kLightTextDarkModeTheme,
            fontSize: 24),
        bodyText1: TextStyle(
            fontFamily: GoogleFonts.delius().fontFamily,
            color: kLightTextDarkModeTheme,
            fontSize: 16),
        bodyText2: TextStyle(
            fontFamily: GoogleFonts.itim().fontFamily,
            color: kDarkTextDarkModeTheme,
            fontSize: 18),
      ));

  static ThemeData calenderTheme(BuildContext context) => ThemeData(
      fontFamily: GoogleFonts.itim().fontFamily,
      colorScheme: ColorScheme.light(
        primary: Colors.deepPurple,
        onPrimary: Colors.white,
        surface: Colors.pink,
        onSurface: kBlackDark,
      ));
}
