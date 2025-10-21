import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_adminPanel/Resources/Colors.dart';

class TTextTheme {
  TTextTheme._();


  /// For light theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge:  TextStyle().copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: AppColors.appBarColor,
    ),// also for login headings and the buttons of the body
    headlineMedium:  TextStyle().copyWith(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.poppins().fontFamily,color: AppColors.appBarColor) , // for the button of login
    headlineSmall: const TextStyle().copyWith(fontSize: 15,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,color: AppColors.textColors), // for the upper names of the textformfields

    titleLarge:  const TextStyle().copyWith(fontSize:32,fontWeight: FontWeight.w600,fontFamily: GoogleFonts.poppins().fontFamily ,color: AppColors.textColors), // for the main heading of the body
    titleMedium: const TextStyle().copyWith(fontSize:17,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily ,color: AppColors.redColor), // for the cancel buttons in the body
    titleSmall:  const TextStyle().copyWith(fontSize:16,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,color: AppColors.captionsColor ), // for the captions of the body

    bodyLarge: const TextStyle().copyWith(fontSize:20,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,color: AppColors.redColor ), // for the logout of the profile picture
    bodyMedium: const TextStyle().copyWith(fontSize:16,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily, color: AppColors.textColors), // for the upper picture of the profile
    bodySmall: const TextStyle().copyWith(fontSize:20,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,color: AppColors.textColors ),  // for the small headings in the body and also for the dropdown of the profile

    labelLarge: const TextStyle().copyWith(fontSize:24,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.poppins().fontFamily, color: AppColors.textColors ), // for the sidebar headings
    labelMedium: const TextStyle().copyWith(fontSize: 15,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily,color: AppColors.appBarColor), // for the loginscreens
    labelSmall: const TextStyle().copyWith(fontSize:12,fontWeight: FontWeight.w400,fontFamily: GoogleFonts.poppins().fontFamily, color: AppColors.TextformFieldsTextColor ), // for the textformfieldstext colors

  );


  /// For dark theme
  static TextTheme darkTextTheme = TextTheme();



}