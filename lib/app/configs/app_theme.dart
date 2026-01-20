import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

ThemeData appTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSeed(
    // brightness: Brightness.dark,
    seedColor: AppColors.primary,
    error: const Color.fromARGB(255, 191, 78, 69),
  ),

  textTheme: GoogleFonts.dmSansTextTheme().copyWith(),
  fontFamily: "Poppins",
  useMaterial3: true,
);
