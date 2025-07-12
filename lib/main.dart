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
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
      ),
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
