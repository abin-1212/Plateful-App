import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Import new modern theme
import 'themes/modern_theme.dart';

// Import existing screens
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
import 'screens/privacy_screen.dart';

// Import new auth screens
import 'screens/auth/splash_screen.dart';
import 'screens/auth/onboarding_screen.dart';
import 'screens/auth/modern_login_screen.dart';

// Import new dashboard screens
import 'screens/user/user_dashboard.dart';
import 'screens/user/search_screen.dart';
import 'screens/vendor/vendor_dashboard.dart';
import 'screens/admin/admin_dashboard.dart';

// Import constants
import 'constants/app_constants.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();
  runApp(const PlatefulApp());
}

final _router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    // Auth routes
    GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashScreen()),
    GoRoute(path: AppRoutes.onboarding, builder: (context, state) => const OnboardingScreen()),
    GoRoute(path: AppRoutes.login, builder: (context, state) => const ModernLoginScreen()),
    GoRoute(path: AppRoutes.signup, builder: (context, state) => const SignupScreen()),
    
    // Main app routes
    GoRoute(path: AppRoutes.home, builder: (context, state) => const HomeScreen()),
    GoRoute(path: AppRoutes.userDashboard, builder: (context, state) => const UserDashboard()),
    GoRoute(path: AppRoutes.vendorDashboard, builder: (context, state) => const VendorDashboard()),
    GoRoute(path: AppRoutes.adminDashboard, builder: (context, state) => const AdminDashboard()),
    
    // User routes
    GoRoute(path: AppRoutes.foodPacks, builder: (context, state) => const PacksScreen()),
    GoRoute(
      path: AppRoutes.packDetail,
      builder: (context, state) {
        final id = int.tryParse(state.uri.queryParameters['id'] ?? '0') ?? 0;
        return PackDetailScreen(packId: id);
      },
    ),
    GoRoute(path: AppRoutes.search, builder: (context, state) => const SearchScreen()),
    GoRoute(path: AppRoutes.favorites, builder: (context, state) => const HomeScreen()), // TODO: Replace with FavoritesScreen
    GoRoute(path: AppRoutes.orders, builder: (context, state) => const HomeScreen()), // TODO: Replace with OrdersScreen
    GoRoute(path: AppRoutes.orderDetail, builder: (context, state) => const HomeScreen()), // TODO: Replace with OrderDetailScreen
    GoRoute(path: AppRoutes.profile, builder: (context, state) => const HomeScreen()), // TODO: Replace with ProfileScreen
    GoRoute(path: AppRoutes.settings, builder: (context, state) => const HomeScreen()), // TODO: Replace with SettingsScreen
    
    // Vendor routes
    GoRoute(path: AppRoutes.addPack, builder: (context, state) => const HomeScreen()), // TODO: Replace with AddPackScreen
    GoRoute(path: AppRoutes.editPack, builder: (context, state) => const HomeScreen()), // TODO: Replace with EditPackScreen
    GoRoute(path: AppRoutes.vendorOrders, builder: (context, state) => const HomeScreen()), // TODO: Replace with VendorOrdersScreen
    GoRoute(path: AppRoutes.analytics, builder: (context, state) => const HomeScreen()), // TODO: Replace with AnalyticsScreen
    GoRoute(path: AppRoutes.vendorProfile, builder: (context, state) => const HomeScreen()), // TODO: Replace with VendorProfileScreen
    
    // Admin routes
    GoRoute(path: AppRoutes.adminUsers, builder: (context, state) => const HomeScreen()), // TODO: Replace with AdminUsersScreen
    GoRoute(path: AppRoutes.adminVendors, builder: (context, state) => const HomeScreen()), // TODO: Replace with AdminVendorsScreen
    GoRoute(path: AppRoutes.adminReports, builder: (context, state) => const HomeScreen()), // TODO: Replace with AdminReportsScreen
    GoRoute(path: AppRoutes.adminAnalytics, builder: (context, state) => const HomeScreen()), // TODO: Replace with AdminAnalyticsScreen
    
    // Common routes
    GoRoute(path: AppRoutes.notifications, builder: (context, state) => const HomeScreen()), // TODO: Replace with NotificationsScreen
    GoRoute(path: AppRoutes.feedback, builder: (context, state) => const HomeScreen()), // TODO: Replace with FeedbackScreen
    GoRoute(path: AppRoutes.about, builder: (context, state) => const AboutScreen()),
    GoRoute(path: AppRoutes.privacy, builder: (context, state) => const PrivacyScreen()),
    GoRoute(path: AppRoutes.terms, builder: (context, state) => const HomeScreen()), // TODO: Replace with TermsScreen
    GoRoute(path: AppRoutes.help, builder: (context, state) => const HomeScreen()), // TODO: Replace with HelpScreen
    
    // Legacy routes for backward compatibility
    GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
    GoRoute(path: '/blog', builder: (context, state) => const BlogScreen()),
    GoRoute(path: '/reviews', builder: (context, state) => const ReviewsScreen()),
    GoRoute(path: '/contact', builder: (context, state) => const ContactScreen()),
    GoRoute(path: '/faq', builder: (context, state) => const FAQScreen()),
    GoRoute(path: '/careers', builder: (context, state) => const CareersScreen()),
    GoRoute(path: '/download', builder: (context, state) => const DownloadScreen()),
    GoRoute(path: '/packs', builder: (context, state) => const PacksScreen()),
    GoRoute(
      path: '/packs/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
        return PackDetailScreen(packId: id);
      },
    ),
    GoRoute(path: '/confirmation', builder: (context, state) => const ConfirmationScreen()),
  ],
);

class PlatefulApp extends StatelessWidget {
  const PlatefulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      theme: ModernTheme.lightTheme,
      darkTheme: ModernTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
