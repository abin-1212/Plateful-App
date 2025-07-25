import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme).copyWith(
      headlineLarge: AppTextStyles.headline,
      headlineMedium: AppTextStyles.subhead,
      bodyLarge: AppTextStyles.body,
      labelLarge: AppTextStyles.button,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.glass,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      hintStyle: AppTextStyles.body.copyWith(color: AppColors.textLight),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: AppTextStyles.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 32),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.glass,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      margin: EdgeInsets.all(AppSpacing.md),
      shadowColor: AppColors.shadow,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textDark),
      titleTextStyle: AppTextStyles.headline,
      centerTitle: true,
    ),
    useMaterial3: true,
  );
} 