
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFE50914);
  static const Color blackColor = Color(0xFF000000);
  static const Color deepNavyColor = Color(0xFF0A192F);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color greyColor = Color(0xFF808080);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: blackColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: deepNavyColor,
        background: blackColor,
        onBackground: whiteColor,
        surface: deepNavyColor,
        onSurface: whiteColor,
        error: Colors.redAccent,
        onError: whiteColor,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.oswald(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
        titleLarge: GoogleFonts.roboto(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: whiteColor,
        ),
        bodyMedium: GoogleFonts.openSans(
          fontSize: 14,
          color: greyColor,
        ),
        labelLarge: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: whiteColor,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: GoogleFonts.oswald(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: whiteColor,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: deepNavyColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
