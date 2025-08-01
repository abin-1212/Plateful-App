import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFFF8F9FB);
  static const Color glass = Color(0x80FFFFFF);
  static const Color primary = Color(0xFF0071E3); // Apple blue
  static const Color accent = Color(0xFF34C759); // Apple green
  static const Color textDark = Color(0xFF1C1C1E);
  static const Color textLight = Color(0xFF8E8E93);
  static const Color shadow = Color(0x1A000000);
  static const Color glassBorder = Color(0x33FFFFFF);
  static const Color heroOverlay = Color(0xCCF8F9FB);
}

class AppGradients {
  static const LinearGradient background = LinearGradient(
    colors: [Color(0xFFF8F9FB), Color(0xFFE5E9F2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient glass = LinearGradient(
    colors: [Color(0x80FFFFFF), Color(0x40FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient pastel = LinearGradient(
    colors: [
      Color(0xFFe0eafc),
      Color(0xFFcfdef3),
      Color(0xFFf5f7fa),
      Color(0xFFc9e7ff),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppFonts {
  static const String primary = 'Inter';
  static const String fallback = 'sans-serif';
}

class AppTextStyles {
  static final TextStyle headline = GoogleFonts.inter(
    fontWeight: FontWeight.w800,
    fontSize: 54,
    color: AppColors.textDark,
    letterSpacing: -1.5,
  );
  static final TextStyle subhead = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 28,
    color: AppColors.textDark,
    letterSpacing: -0.5,
  );
  static final TextStyle body = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.textDark,
    letterSpacing: 0.1,
  );
  static final TextStyle button = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    color: Colors.white,
    letterSpacing: 0.5,
  );
}

class AppSpacing {
  static const double xl = 64.0;
  static const double lg = 40.0;
  static const double md = 24.0;
  static const double sm = 16.0;
  static const double xs = 8.0;
}

class AppShadows {
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 32,
      offset: Offset(0, 8),
    ),
  ];
  static const List<BoxShadow> glass = [
    BoxShadow(
      color: AppColors.glassBorder,
      blurRadius: 24,
      offset: Offset(0, 4),
    ),
  ];
}

// Parallax and hero image constants
class AppImages {
  static const String heroBg = 'assets/images/hero_food_bg.jpg';
  static const String howItWorksBg = 'assets/images/how_it_works_bg.jpg';
  static const String featuresBg = 'assets/images/features_bg.jpg';
  static const String communityBg = 'assets/images/community_bg.jpg';
}

class AppRoutes {
  // Auth routes
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  
  // Main app routes
  static const String home = '/home';
  static const String userDashboard = '/user-dashboard';
  static const String vendorDashboard = '/vendor-dashboard';
  static const String adminDashboard = '/admin-dashboard';
  
  // User routes
  static const String foodPacks = '/food-packs';
  static const String packDetail = '/pack-detail';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String orders = '/orders';
  static const String orderDetail = '/order-detail';
  static const String profile = '/profile';
  static const String settings = '/settings';
  
  // Vendor routes
  static const String addPack = '/add-pack';
  static const String editPack = '/edit-pack';
  static const String vendorOrders = '/vendor-orders';
  static const String analytics = '/analytics';
  static const String vendorProfile = '/vendor-profile';
  
  // Admin routes
  static const String adminUsers = '/admin-users';
  static const String adminVendors = '/admin-vendors';
  static const String adminReports = '/admin-reports';
  static const String adminAnalytics = '/admin-analytics';
  
  // Common routes
  static const String notifications = '/notifications';
  static const String feedback = '/feedback';
  static const String about = '/about';
  static const String privacy = '/privacy';
  static const String terms = '/terms';
  static const String help = '/help';
}

class FoodCategories {
  static const List<String> categories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Desserts',
    'Beverages',
    'Snacks',
    'Bakery',
    'Salads',
    'Soups',
    'Pasta',
    'Pizza',
    'Burgers',
    'Sushi',
    'Indian',
    'Chinese',
    'Italian',
    'Mexican',
    'Thai',
    'Mediterranean',
    'Vegan',
    'Vegetarian',
    'Gluten-Free',
    'Organic',
    'Street Food',
    'Fine Dining',
  ];
  
  static const Map<String, String> categoryIcons = {
    'Breakfast': '🍳',
    'Lunch': '🍽️',
    'Dinner': '🍴',
    'Desserts': '🍰',
    'Beverages': '🥤',
    'Snacks': '🍿',
    'Bakery': '🥖',
    'Salads': '🥗',
    'Soups': '🍲',
    'Pasta': '🍝',
    'Pizza': '🍕',
    'Burgers': '🍔',
    'Sushi': '🍣',
    'Indian': '🍛',
    'Chinese': '🥡',
    'Italian': '🇮🇹',
    'Mexican': '🌮',
    'Thai': '🍜',
    'Mediterranean': '🥙',
    'Vegan': '🌱',
    'Vegetarian': '🥬',
    'Gluten-Free': '🌾',
    'Organic': '🌿',
    'Street Food': '🌯',
    'Fine Dining': '🍷',
  };
}

class OrderStatus {
  static const String pending = 'pending';
  static const String confirmed = 'confirmed';
  static const String pickedUp = 'picked_up';
  static const String cancelled = 'cancelled';
  static const String expired = 'expired';
  
  static const Map<String, String> statusLabels = {
    pending: 'Pending',
    confirmed: 'Confirmed',
    pickedUp: 'Picked Up',
    cancelled: 'Cancelled',
    expired: 'Expired',
  };
  
  static const Map<String, String> statusDescriptions = {
    pending: 'Your order is being processed',
    confirmed: 'Your order has been confirmed',
    pickedUp: 'Your order has been picked up',
    cancelled: 'Your order has been cancelled',
    expired: 'Your order has expired',
  };
}

class UserRoles {
  static const String user = 'user';
  static const String vendor = 'vendor';
  static const String admin = 'admin';
  
  static const Map<String, String> roleLabels = {
    user: 'User',
    vendor: 'Vendor',
    admin: 'Admin',
  };
}

class PaymentMethods {
  static const String cash = 'cash';
  static const String card = 'card';
  static const String digitalWallet = 'digital_wallet';
  static const String bankTransfer = 'bank_transfer';
  
  static const Map<String, String> methodLabels = {
    cash: 'Cash',
    card: 'Card',
    digitalWallet: 'Digital Wallet',
    bankTransfer: 'Bank Transfer',
  };
}

class NotificationTypes {
  static const String orderConfirmation = 'order_confirmation';
  static const String orderUpdate = 'order_update';
  static const String orderCancelled = 'order_cancelled';
  static const String newPackAvailable = 'new_pack_available';
  static const String packExpiring = 'pack_expiring';
  static const String hygieneAlert = 'hygiene_alert';
  static const String systemUpdate = 'system_update';
  static const String promotional = 'promotional';
  
  static const Map<String, String> typeLabels = {
    orderConfirmation: 'Order Confirmation',
    orderUpdate: 'Order Update',
    orderCancelled: 'Order Cancelled',
    newPackAvailable: 'New Pack Available',
    packExpiring: 'Pack Expiring Soon',
    hygieneAlert: 'Hygiene Alert',
    systemUpdate: 'System Update',
    promotional: 'Promotional',
  };
}

class AppConfig {
  static const String appName = 'Plateful';
  static const String appTagline = 'Smart Food Redistribution';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // API Configuration
  static const String baseUrl = 'https://api.plateful.com';
  static const int apiTimeout = 30000; // milliseconds
  
  // Location Configuration
  static const double defaultLatitude = 37.7749;
  static const double defaultLongitude = -122.4194;
  static const double maxSearchRadius = 50.0; // kilometers
  
  // Time Configuration
  static const int orderExpiryMinutes = 30;
  static const int packExpiryWarningMinutes = 60;
  static const int maxPickupDelayMinutes = 15;
  
  // UI Configuration
  static const double maxCardWidth = 400.0;
  static const double minCardHeight = 200.0;
  static const int maxImagesPerPack = 5;
  static const int maxTagsPerPack = 10;
  
  // AI Configuration
  static const double minRecommendationScore = 0.3;
  static const int maxRecommendations = 10;
  static const double anomalyThreshold = 0.8;
  
  // Hygiene Configuration
  static const double minHygieneScore = 7.0;
  static const double maxHygieneScore = 10.0;
  static const int hygieneCheckInterval = 24; // hours
}

class ErrorMessages {
  static const String networkError = 'Network error. Please check your connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String authError = 'Authentication failed. Please login again.';
  static const String permissionError = 'Permission denied.';
  static const String locationError = 'Location access required.';
  static const String cameraError = 'Camera access required.';
  static const String storageError = 'Storage access required.';
  static const String unknownError = 'An unknown error occurred.';
  
  static const String invalidEmail = 'Please enter a valid email address.';
  static const String invalidPassword = 'Password must be at least 6 characters.';
  static const String invalidPhone = 'Please enter a valid phone number.';
  static const String invalidName = 'Please enter a valid name.';
  
  static const String packNotFound = 'Food pack not found.';
  static const String packExpired = 'This food pack has expired.';
  static const String packUnavailable = 'This food pack is no longer available.';
  static const String insufficientQuantity = 'Insufficient quantity available.';
  
  static const String orderFailed = 'Failed to place order. Please try again.';
  static const String orderCancelled = 'Order has been cancelled.';
  static const String orderExpired = 'Order has expired.';
  
  static const String paymentFailed = 'Payment failed. Please try again.';
  static const String paymentCancelled = 'Payment was cancelled.';
  
  static const String uploadFailed = 'Failed to upload image. Please try again.';
  static const String saveFailed = 'Failed to save changes. Please try again.';
  static const String deleteFailed = 'Failed to delete item. Please try again.';
}

class SuccessMessages {
  static const String loginSuccess = 'Login successful!';
  static const String signupSuccess = 'Account created successfully!';
  static const String passwordReset = 'Password reset email sent!';
  static const String profileUpdated = 'Profile updated successfully!';
  static const String orderPlaced = 'Order placed successfully!';
  static const String orderCancelled = 'Order cancelled successfully!';
  static const String packAdded = 'Food pack added successfully!';
  static const String packUpdated = 'Food pack updated successfully!';
  static const String packDeleted = 'Food pack deleted successfully!';
  static const String feedbackSubmitted = 'Feedback submitted successfully!';
  static const String settingsSaved = 'Settings saved successfully!';
  static const String imageUploaded = 'Image uploaded successfully!';
} 

class AppRoles {
  static const String user = 'user';
  static const String vendor = 'vendor';
  static const String admin = 'admin';
} 