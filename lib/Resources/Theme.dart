
import 'package:flutter/material.dart';
import 'package:super_adminPanel/Resources/Colors.dart';
import 'package:super_adminPanel/Resources/textTheme.dart' show TTextTheme;

class TAppTheme {
  TAppTheme._();

  /// Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3:true ,
    fontFamily:"poppins",
    brightness: Brightness.light,
    primaryColor: Color(0xFF0085FF),
    scaffoldBackgroundColor: AppColors.backgroundScreenColor,
    textTheme:TTextTheme.lightTextTheme,
  );

  /// Dark Theme (In future if needed we will add it )
  static ThemeData darkTheme = ThemeData();

}