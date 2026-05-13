import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class AppThemes {
  static ThemeData daylight = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.mintGreen,
    scaffoldBackgroundColor: AppColors.powderWhite,
    colorScheme: const ColorScheme.light(
      primary: AppColors.mintGreen,
      secondary: AppColors.coral,
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.fredokaTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.mintGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.coral,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 24,
        ),
      ),
    ),
  );

  static ThemeData starlight = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.mintGreen,
    scaffoldBackgroundColor: AppColors.darkBg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.mintGreen,
      secondary: AppColors.coral,
      surface: AppColors.darkSurface,
    ),
    textTheme: GoogleFonts.fredokaTextTheme(
      ThemeData.dark().textTheme,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.coral,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 24,
        ),
      ),
    ),
  );

  static ThemeData candy = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.candyPink,
    scaffoldBackgroundColor: AppColors.candyBg,
    colorScheme: const ColorScheme.light(
      primary: AppColors.candyPink,
      secondary: AppColors.candyPurple,
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.fredokaTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.candyPink,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.candyPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 24,
        ),
      ),
    ),
  );
}