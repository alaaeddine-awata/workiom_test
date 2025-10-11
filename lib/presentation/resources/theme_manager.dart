import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static const Color primaryBlue = Color(0xFF4E86F7);
  static const Color lightGray = Color(0xFFF4F4F4);
  static const Color warningYellow = Color(0xFFF5C044);
  static const Color disabledGray = Color(0xFFB5B5B5);
  static const Color white = Color(0xFFFFFFFF);
  
  static ThemeData get lightTheme => ThemeData(
    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      surface: white,
    ),
    useMaterial3: true,
    fontFamily: GoogleFonts.rubik().fontFamily,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: primaryBlue),
      titleTextStyle: TextStyle(
        color: primaryBlue,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.w400,
        fontSize: 17,
        letterSpacing: -0.41,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: primaryBlue,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: GoogleFonts.rubik(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          letterSpacing: -0.32,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryBlue,
        textStyle: GoogleFonts.rubik(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          letterSpacing: -0.32,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryBlue),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 16.h,
      ),
      labelStyle: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        letterSpacing: -0.24,
        color: Colors.grey[600],
      ),
      hintStyle: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        letterSpacing: -0.24,
        color: Colors.grey[400],
      ),
    ),
    textTheme: TextTheme(
      // Headlines
      headlineLarge: GoogleFonts.rubik(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        letterSpacing: 0.35,
        color: Colors.black87,
      ),
      headlineMedium: GoogleFonts.rubik(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: 0.35,
        color: Colors.black87,
      ),
      headlineSmall: GoogleFonts.rubik(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        letterSpacing: 0.35,
        color: Colors.black87,
      ),
      
      // Body text
      bodyLarge: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        fontSize: 17,
        letterSpacing: -0.41,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        letterSpacing: -0.24,
        color: Colors.black87,
      ),
      bodySmall: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: 0,
        color: Colors.grey[600],
      ),
      
      // Labels
      labelLarge: GoogleFonts.rubik(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        letterSpacing: -0.32,
        color: Colors.black87,
      ),
      labelMedium: GoogleFonts.rubik(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        letterSpacing: 0,
        color: Colors.black87,
      ),
      labelSmall: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        fontSize: 10,
        letterSpacing: 0,
        color: Colors.grey[600],
      ),
      
      // Titles
      titleLarge: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        fontSize: 17,
        letterSpacing: -0.41,
        color: primaryBlue,
      ),
      titleMedium: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        letterSpacing: -0.24,
        color: Colors.grey[600],
      ),
      titleSmall: GoogleFonts.rubik(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: 0,
        color: Colors.grey[600],
      ),
    ),
  );
}