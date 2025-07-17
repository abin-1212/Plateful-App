import 'package:flutter/material.dart';
import 'theme.dart';
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
import 'screens/packs_screen.dart';
import 'screens/pack_detail_screen.dart';
import 'screens/confirmation_screen.dart';
import 'package:go_router/go_router.dart';
import 'screens/privacy_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const PlatefulApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
    GoRoute(path: '/blog', builder: (context, state) => const BlogScreen()),
    GoRoute(path: '/reviews', builder: (context, state) => const ReviewsScreen()),
    GoRoute(path: '/contact', builder: (context, state) => const ContactScreen()),
    GoRoute(path: '/faq', builder: (context, state) => const FAQScreen()),
    GoRoute(path: '/careers', builder: (context, state) => const CareersScreen()),
    GoRoute(path: '/download', builder: (context, state) => const DownloadScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    GoRoute(path: '/packs', builder: (context, state) => const PacksScreen()),
    GoRoute(
      path: '/packs/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return PackDetailScreen(packId: id);
      },
    ),
    GoRoute(path: '/confirmation', builder: (context, state) => const ConfirmationScreen()),
    GoRoute(path: '/privacy', builder: (context, state) => const PrivacyScreen()),
  ],
);

class PlatefulApp extends StatelessWidget {
  const PlatefulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Plateful',
      theme: platefulTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
