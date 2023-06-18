import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtiqrTheme {
  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.questrial(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: Colors.white,
    ),
    bodyText2: GoogleFonts.questrial(
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: Colors.white,
    ),
    subtitle1: GoogleFonts.questrial(
      fontSize: 15.0,
      fontWeight: FontWeight.w700,
      height: 1.5,
      color: Colors.white,
    ),
    subtitle2: GoogleFonts.questrial(
      fontSize: 17.0,
      color: Colors.white,
      height: 1.5,
    ),
    headline1: GoogleFonts.questrial(
      fontSize: 31.0,
      fontWeight: FontWeight.bold,
      height: 1.5,
      color: Colors.white,
    ),
    headline2: GoogleFonts.questrial(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      height: 1.5,
      color: Colors.white,
    ),
    headline3: GoogleFonts.questrial(
      fontSize: 19.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.5,
      decoration: TextDecoration.none,
    ),
    headline4: GoogleFonts.questrial(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      height: 1.5,
      decoration: TextDecoration.none,
    ),
    headline5: GoogleFonts.questrial(
      fontSize: 19.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      height: 1.5,
      decoration: TextDecoration.none,
    ),
    headline6: GoogleFonts.questrial(
      fontSize: 19.0,
      fontWeight: FontWeight.w600,
      height: 1.5,
      color: Colors.white,
    ),
  );

  static ThemeData dark() {
    return ThemeData(
      primarySwatch: Colors.blue,
      iconTheme: IconThemeData(color: Colors.purpleAccent),
      primaryIconTheme: IconThemeData(
        color: Colors.white,
      ),
      brightness: Brightness.dark,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: tkDarkerBlue,
      primaryColor: tkDarkBlue,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: tkDarkBlue,
        centerTitle: true,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        backgroundColor: tkDarkBlue,
      ),
      textTheme: darkTextTheme,
    );
  }
}

const Color tkDarkBlue = Color(0xFF0D1321);
const Color tkDarkerBlue = Color(0xFF060B16);