import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serenity/app/utlis/color_pallete.dart';

ThemeData serenityTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      primary: serenityPrimary,
      secondary: serenitySecondary,
      surface: serenityPrimary,
      background: serenityBlack,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.nunitoTextTheme(const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    )),
    hintColor: Colors.white);
