import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = buildAppTheme();

ThemeData buildAppTheme({TextTheme? textTheme}) => ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0C1117),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF6DE2CF),
    onPrimary: Color(0xFF0C1117),
    surface: Color(0xFF131C25),
    onSurface: Color(0xFFF0F5FA),
  ),
  textTheme:
      (textTheme ?? GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme))
          .apply(
            bodyColor: const Color(0xFFF0F5FA),
            displayColor: const Color(0xFFF0F5FA),
          ),
  dividerTheme: const DividerThemeData(color: Color(0xFF293541)),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: const Color(0xFF6DE2CF),
      foregroundColor: const Color(0xFF0C1117),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF6DE2CF),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
    ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: const Color(0xFF131C25),
    selectedColor: const Color(0xFF173A37),
    labelStyle: const TextStyle(color: Color(0xFFF0F5FA)),
    side: const BorderSide(color: Color(0xFF35434F)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);
