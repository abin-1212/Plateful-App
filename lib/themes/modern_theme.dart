import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModernColors {
  // Primary neon colors
  static const Color electricBlue = Color(0xFF00D4FF);
  static const Color neonPurple = Color(0xFF8B5CF6);
  static const Color mintGreen = Color(0xFF10B981);
  static const Color neonPink = Color(0xFFEC4899);
  static const Color neonOrange = Color(0xFFFF6B35);
  
  // Dark theme colors
  static const Color deepGray = Color(0xFF0F0F0F);
  static const Color matteBlack = Color(0xFF000000);
  static const Color darkGray = Color(0xFF1A1A1A);
  static const Color mediumGray = Color(0xFF2A2A2A);
  static const Color lightGray = Color(0xFF3A3A3A);
  
  // Glassmorphism colors
  static const Color glassWhite = Color(0x1AFFFFFF);
  static const Color glassBlack = Color(0x1A000000);
  static const Color glassBlue = Color(0x1A00D4FF);
  static const Color glassPurple = Color(0x1A8B5CF6);
  
  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);
  
  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}

class ModernGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [ModernColors.electricBlue, ModernColors.neonPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [ModernColors.mintGreen, ModernColors.neonPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [ModernColors.neonOrange, ModernColors.neonPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient glassGradient = LinearGradient(
    colors: [ModernColors.glassWhite, ModernColors.glassBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkGradient = LinearGradient(
    colors: [ModernColors.deepGray, ModernColors.matteBlack],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class ModernShadows {
  static List<BoxShadow> neonGlow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: color.withOpacity(0.1),
      blurRadius: 40,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> glassShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 15,
      spreadRadius: 0,
      offset: const Offset(0, 5),
    ),
  ];
}

class ModernTextStyles {
  static TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: ModernColors.textPrimary,
    letterSpacing: -0.5,
  );
  
  static TextStyle displayMedium = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: ModernColors.textPrimary,
    letterSpacing: -0.25,
  );
  
  static TextStyle displaySmall = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: ModernColors.textPrimary,
  );
  
  static TextStyle headlineLarge = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: ModernColors.textPrimary,
  );
  
  static TextStyle headlineMedium = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ModernColors.textPrimary,
  );
  
  static TextStyle headlineSmall = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: ModernColors.textPrimary,
  );
  
  static TextStyle titleLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ModernColors.textPrimary,
  );
  
  static TextStyle titleMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ModernColors.textPrimary,
  );
  
  static TextStyle titleSmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ModernColors.textSecondary,
  );
  
  static TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ModernColors.textPrimary,
    height: 1.4,
  );
  
  static TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ModernColors.textSecondary,
    height: 1.4,
  );
  
  static TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ModernColors.textTertiary,
    height: 1.4,
  );
  
  static TextStyle labelLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: ModernColors.textPrimary,
    letterSpacing: 0.5,
  );
  
  static TextStyle labelMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ModernColors.textPrimary,
    letterSpacing: 0.25,
  );
  
  static TextStyle labelSmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ModernColors.textSecondary,
    letterSpacing: 0.5,
  );
}

class ModernSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}

class ModernBorderRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double full = 999.0;
}

class ModernTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ModernColors.matteBlack,
    
    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: ModernColors.electricBlue,
      secondary: ModernColors.neonPurple,
      tertiary: ModernColors.mintGreen,
      surface: ModernColors.darkGray,
      background: ModernColors.matteBlack,
      error: ModernColors.error,
      onPrimary: ModernColors.textPrimary,
      onSecondary: ModernColors.textPrimary,
      onTertiary: ModernColors.textPrimary,
      onSurface: ModernColors.textPrimary,
      onBackground: ModernColors.textPrimary,
      onError: ModernColors.textPrimary,
    ),
    
    // Text Theme
    textTheme: TextTheme(
      displayLarge: ModernTextStyles.displayLarge,
      displayMedium: ModernTextStyles.displayMedium,
      displaySmall: ModernTextStyles.displaySmall,
      headlineLarge: ModernTextStyles.headlineLarge,
      headlineMedium: ModernTextStyles.headlineMedium,
      headlineSmall: ModernTextStyles.headlineSmall,
      titleLarge: ModernTextStyles.titleLarge,
      titleMedium: ModernTextStyles.titleMedium,
      titleSmall: ModernTextStyles.titleSmall,
      bodyLarge: ModernTextStyles.bodyLarge,
      bodyMedium: ModernTextStyles.bodyMedium,
      bodySmall: ModernTextStyles.bodySmall,
      labelLarge: ModernTextStyles.labelLarge,
      labelMedium: ModernTextStyles.labelMedium,
      labelSmall: ModernTextStyles.labelSmall,
    ),
    
    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: ModernColors.darkGray.withOpacity(0.8),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: ModernTextStyles.headlineMedium,
      iconTheme: const IconThemeData(color: ModernColors.textPrimary),
      actionsIconTheme: const IconThemeData(color: ModernColors.textPrimary),
    ),
    
    // Card Theme
    cardTheme: CardThemeData(
      color: ModernColors.darkGray.withOpacity(0.8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
      ),
      shadowColor: Colors.black,
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ModernColors.electricBlue,
        foregroundColor: ModernColors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: ModernSpacing.xl,
          vertical: ModernSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        ),
        textStyle: ModernTextStyles.labelLarge,
      ),
    ),
    
    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ModernColors.electricBlue,
        side: const BorderSide(color: ModernColors.electricBlue, width: 2),
        padding: const EdgeInsets.symmetric(
          horizontal: ModernSpacing.xl,
          vertical: ModernSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        ),
        textStyle: ModernTextStyles.labelLarge,
      ),
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ModernColors.electricBlue,
        padding: const EdgeInsets.symmetric(
          horizontal: ModernSpacing.md,
          vertical: ModernSpacing.sm,
        ),
        textStyle: ModernTextStyles.labelMedium,
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ModernColors.darkGray.withOpacity(0.8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        borderSide: const BorderSide(color: ModernColors.electricBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        borderSide: const BorderSide(color: ModernColors.error, width: 2),
      ),
      labelStyle: ModernTextStyles.bodyMedium,
      hintStyle: ModernTextStyles.bodyMedium.copyWith(
        color: ModernColors.textTertiary,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: ModernSpacing.md,
        vertical: ModernSpacing.md,
      ),
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ModernColors.darkGray,
      selectedItemColor: ModernColors.electricBlue,
      unselectedItemColor: ModernColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ModernColors.electricBlue,
      foregroundColor: ModernColors.textPrimary,
      elevation: 8,
    ),
    
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: ModernColors.lightGray,
      thickness: 1,
      space: 1,
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(
      color: ModernColors.textPrimary,
      size: 24,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: ModernColors.electricBlue,
      secondary: ModernColors.neonPurple,
      tertiary: ModernColors.mintGreen,
      surface: Colors.white,
      background: Colors.white,
      error: ModernColors.error,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onTertiary: Colors.black,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
    ),
    textTheme: TextTheme(
      displayLarge: ModernTextStyles.displayLarge.copyWith(color: Colors.black),
      displayMedium: ModernTextStyles.displayMedium.copyWith(color: Colors.black),
      displaySmall: ModernTextStyles.displaySmall.copyWith(color: Colors.black),
      headlineLarge: ModernTextStyles.headlineLarge.copyWith(color: Colors.black),
      headlineMedium: ModernTextStyles.headlineMedium.copyWith(color: Colors.black),
      headlineSmall: ModernTextStyles.headlineSmall.copyWith(color: Colors.black),
      titleLarge: ModernTextStyles.titleLarge.copyWith(color: Colors.black),
      titleMedium: ModernTextStyles.titleMedium.copyWith(color: Colors.black),
      titleSmall: ModernTextStyles.titleSmall.copyWith(color: ModernColors.textTertiary),
      bodyLarge: ModernTextStyles.bodyLarge.copyWith(color: Colors.black),
      bodyMedium: ModernTextStyles.bodyMedium.copyWith(color: ModernColors.textSecondary),
      bodySmall: ModernTextStyles.bodySmall.copyWith(color: ModernColors.textTertiary),
      labelLarge: ModernTextStyles.labelLarge.copyWith(color: Colors.black),
      labelMedium: ModernTextStyles.labelMedium.copyWith(color: Colors.black),
      labelSmall: ModernTextStyles.labelSmall.copyWith(color: ModernColors.textSecondary),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white.withOpacity(0.95),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: ModernTextStyles.headlineMedium.copyWith(color: Colors.black),
      iconTheme: const IconThemeData(color: Colors.black),
      actionsIconTheme: const IconThemeData(color: Colors.black),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
      ),
      shadowColor: Colors.black12,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ModernColors.electricBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: ModernSpacing.xl,
          vertical: ModernSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        ),
        textStyle: ModernTextStyles.labelLarge.copyWith(color: Colors.white),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ModernColors.electricBlue,
        side: const BorderSide(color: ModernColors.electricBlue, width: 2),
        padding: const EdgeInsets.symmetric(
          horizontal: ModernSpacing.xl,
          vertical: ModernSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        ),
        textStyle: ModernTextStyles.labelLarge.copyWith(color: ModernColors.electricBlue),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ModernColors.electricBlue,
        padding: const EdgeInsets.symmetric(
          horizontal: ModernSpacing.md,
          vertical: ModernSpacing.sm,
        ),
        textStyle: ModernTextStyles.labelMedium.copyWith(color: ModernColors.electricBlue),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        borderSide: const BorderSide(color: ModernColors.electricBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
        borderSide: const BorderSide(color: ModernColors.error, width: 2),
      ),
      labelStyle: ModernTextStyles.bodyMedium.copyWith(color: Colors.black),
      hintStyle: ModernTextStyles.bodyMedium.copyWith(color: ModernColors.textTertiary),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: ModernSpacing.md,
        vertical: ModernSpacing.md,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: ModernColors.electricBlue,
      unselectedItemColor: ModernColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ModernColors.electricBlue,
      foregroundColor: Colors.white,
      elevation: 8,
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.grey,
      thickness: 1,
      space: 1,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
      size: 24,
    ),
  );
} 