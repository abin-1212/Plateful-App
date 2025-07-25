import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/modern_hero_section.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPageData> _pages = [
    _OnboardingPageData(
      lottie: 'assets/animations/ai_platform.json',
      title: 'Welcome to Plateful',
      subtitle: 'Curated food packs, delivered fresh. Discover, order, and enjoy delicious meals from top brands.',
    ),
    _OnboardingPageData(
      lottie: 'assets/animations/food_lover.json',
      title: 'Personalized for You',
      subtitle: 'Get AI-powered recommendations and find the perfect meal for every moment.',
    ),
    _OnboardingPageData(
      lottie: 'assets/animations/restaurant.json',
      title: 'Seamless Experience',
      subtitle: 'Order, track, and enjoy with a beautiful, intuitive interface.',
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onSkip() {
    // TODO: Navigate to login or home
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      // TODO: Navigate to login or home
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModernHeroSection(
      headline: 'Turn Surplus Into Support.',
      subheadline: 'Plateful connects extra food from restaurants and hotels with people who need it most.\n\nSave meals. Feed neighbors. Build a kinder city—together.',
      buttonText: 'Get Started',
      onButtonPressed: () => context.go('/signup'),
      imageAsset: 'assets/animations/food_lover.json',
    );
  }
}

class _OnboardingPageData {
  final String lottie;
  final String title;
  final String subtitle;
  const _OnboardingPageData({required this.lottie, required this.title, required this.subtitle});
} 