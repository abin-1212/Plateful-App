import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'constants/app_constants.dart';
import 'theme.dart';
import 'services/firebase_service.dart';
import 'widgets/modern_loading.dart';
import 'widgets/modern_scaffold.dart';
import 'screens/auth/modern_login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/auth/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/dashboard/user_dashboard.dart';
import 'screens/dashboard/vendor_dashboard.dart';
import 'screens/dashboard/admin_dashboard.dart';
import 'screens/pack_detail_screen.dart';
import 'screens/notifications_page.dart';
import 'screens/feedback_page.dart';
import 'screens/vendor/add_food_form.dart';
import 'screens/test_image_gallery.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  print('Starting Firebase initialization...');
  try {
    await FirebaseService.initialize();
    print('Firebase initialization completed successfully');
  } catch (e) {
    print('Firebase initialization failed: $e');
    // Continue with app startup even if Firebase fails
  }
  
  runApp(const PlatefulApp());
}

final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const ModernLoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/dashboard/user',
      builder: (context, state) => const UserDashboard(),
    ),
    GoRoute(
      path: '/dashboard/vendor',
      builder: (context, state) => const VendorDashboard(),
    ),
    GoRoute(
      path: '/dashboard/admin',
      builder: (context, state) => const AdminDashboard(),
    ),
    GoRoute(
      path: '/food/:id',
      builder: (context, state) => PackDetailScreen(packId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      path: '/feedback',
      builder: (context, state) => const FeedbackPage(),
    ),
    GoRoute(
      path: '/vendor/add-food',
      builder: (context, state) => const AddFoodForm(),
    ),
  ],
);

class PlatefulApp extends StatelessWidget {
  const PlatefulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Plateful – Smart Food Redistribution',
      debugShowCheckedModeBanner: false,
      theme: appTheme(context),
      routerConfig: _router,
      builder: (context, child) {
        return ModernScaffold(child: child ?? ModernLoading());
      },
    );
  }
}
