import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlatefulColors {
  static const Color primaryGradientStart = Color(0xFFFD5C63);
  static const Color primaryGradientEnd = Color(0xFFFF9966);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF555555);
  static const Color background = Color(0xFFFFFFFF);
  static const Color sectionBackgroundAlt = Color(0xFFF9F9F9);
  static const Color footerBackground = Color(0xFF151515);
  static const Color linkHighlight = Color(0xFFFD5C63);
}

const double kSectionPaddingVertical = 72;
const double kSectionPaddingHorizontalMobile = 24;
const double kSectionPaddingHorizontalDesktop = 80;
const double kCardCornerRadius = 24;
const double kCardElevation = 4;
const double kButtonPaddingVertical = 16;
const double kButtonPaddingHorizontal = 32;

final platefulGradient = const LinearGradient(
  colors: [PlatefulColors.primaryGradientStart, PlatefulColors.primaryGradientEnd],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final platefulTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
    fontSize: 42,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: PlatefulColors.textPrimary,
  ),
  displayMedium: GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: PlatefulColors.textPrimary,
  ),
  displaySmall: GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: PlatefulColors.textPrimary,
  ),
  titleLarge: GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: PlatefulColors.textSecondary,
  ),
  bodyLarge: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: PlatefulColors.textPrimary,
  ),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: PlatefulColors.textSecondary,
  ),
  labelLarge: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 1.1,
  ),
  bodySmall: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: PlatefulColors.textSecondary,
    letterSpacing: 1.2,
  ),
);

ThemeData platefulTheme = ThemeData(
  fontFamily: GoogleFonts.poppins().fontFamily,
  scaffoldBackgroundColor: PlatefulColors.background,
  textTheme: platefulTextTheme,
  primaryColor: PlatefulColors.primaryGradientStart,
  colorScheme: ColorScheme.light(
    primary: PlatefulColors.primaryGradientStart,
    secondary: PlatefulColors.primaryGradientEnd,
    background: PlatefulColors.background,
    surface: PlatefulColors.sectionBackgroundAlt,
    onPrimary: Colors.white,
    onSecondary: PlatefulColors.textPrimary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: kButtonPaddingVertical,
        horizontal: kButtonPaddingHorizontal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCardCornerRadius),
      ),
      textStyle: platefulTextTheme.labelLarge,
      backgroundColor: PlatefulColors.primaryGradientStart,
      foregroundColor: Colors.white,
      elevation: kCardElevation,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(color: PlatefulColors.textPrimary),
    titleTextStyle: platefulTextTheme.displayMedium,
    centerTitle: true,
  ),
  cardTheme: CardThemeData(
    color: PlatefulColors.sectionBackgroundAlt,
    elevation: kCardElevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kCardCornerRadius),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: PlatefulColors.sectionBackgroundAlt,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kCardCornerRadius),
      borderSide: BorderSide.none,
    ),
    labelStyle: platefulTextTheme.bodyMedium,
    hintStyle: platefulTextTheme.bodyMedium,
  ),
); 