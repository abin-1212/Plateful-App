import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/firebase_service.dart';
import '../../widgets/modern_loading.dart';
import '../../constants/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndRedirect();
  }

  Future<void> _checkAuthAndRedirect() async {
    final service = FirebaseService();
    final user = service.getCurrentUser();
    await Future.delayed(const Duration(milliseconds: 600)); // Smooth splash
    if (user == null) {
      if (mounted) context.go('/onboarding');
      return;
    }
    final role = await service.getUserRole(user.uid);
    if (role == AppRoles.user) {
      if (mounted) context.go('/dashboard/user');
    } else if (role == AppRoles.vendor) {
      if (mounted) context.go('/dashboard/vendor');
    } else if (role == AppRoles.admin) {
      if (mounted) context.go('/dashboard/admin');
    } else {
      if (mounted) context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const ModernLoading();
  }
} 