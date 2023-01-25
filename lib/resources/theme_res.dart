import 'package:flutter/material.dart';

import 'color_res.dart';
import 'font_res.dart';

class ThemeRes{
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: FontRes.robotoFont,
      primaryColor: ColorRes.primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorRes.primaryColor),
      scaffoldBackgroundColor: ColorRes.whiteColor,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: ColorRes.primaryColor,
              foregroundColor: ColorRes.whiteColor,
              textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              )
          )
      ),
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              color: ColorRes.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold
          ),
          iconTheme: IconThemeData(
              color: ColorRes.primaryColor,
              size: 24
          )
      ),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: ColorRes.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold
          ),
          displayMedium: TextStyle(
              color: ColorRes.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
          displaySmall: TextStyle(
              color: ColorRes.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
          headlineMedium: TextStyle(
              color: ColorRes.primaryColor,
              fontSize: 17,
              fontWeight: FontWeight.bold
          ),
          headlineSmall: TextStyle(
              color: ColorRes.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
          titleLarge: TextStyle(
              color: ColorRes.primaryColor,
              fontSize: 19,
              fontWeight: FontWeight.bold
          ),
          bodyLarge: TextStyle(
              color: ColorRes.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.normal
          ),
          bodyMedium: TextStyle(
              color: ColorRes.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.normal
          )
      )
  );
}