import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/blog_screen.dart';
import 'screens/reviews_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/careers_screen.dart';
import 'screens/download_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/pack_detail_screen.dart';
import 'screens/confirmation_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const PlatefulApp());
}

class PlatefulApp extends StatelessWidget {
  const PlatefulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plateful',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C3EF4),
        scaffoldBackgroundColor: const Color(0xFF181A2A),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF6C3EF4),
          secondary: const Color(0xFF00FFD0),
          background: const Color(0xFF181A2A),
          surface: const Color(0xFF23244D),
          onPrimary: Colors.white,
          onSecondary: Colors.black,
        ),
        textTheme: GoogleFonts.orbitronTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C3EF4),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            shadowColor: const Color(0xFF00FFD0).withOpacity(0.5),
            elevation: 8,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF23244D),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF00FFD0),
          foregroundColor: Color(0xFF181A2A),
          elevation: 12,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C3EF4),
        scaffoldBackgroundColor: const Color(0xFF181A2A),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF6C3EF4),
          secondary: const Color(0xFF00FFD0),
          background: const Color(0xFF181A2A),
          surface: const Color(0xFF23244D),
          onPrimary: Colors.white,
          onSecondary: Colors.black,
        ),
        textTheme: GoogleFonts.orbitronTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(),
        '/blog': (context) => const BlogScreen(),
        '/reviews': (context) => const ReviewsScreen(),
        '/contact': (context) => const ContactScreen(),
        '/faq': (context) => const FAQScreen(),
        '/careers': (context) => const CareersScreen(),
        '/download': (context) => const DownloadScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/packDetail': (context) => const PackDetailScreen(),
        '/confirmation': (context) => const ConfirmationScreen(),
      },
    );
  }
}
