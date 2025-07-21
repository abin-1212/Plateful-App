import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../themes/modern_theme.dart';
import '../../widgets/modern/glass_card.dart';
import '../../widgets/modern/modern_button.dart';
import '../../constants/app_constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  int _currentPage = 0;
  final int _totalPages = 3;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'For Food Lovers',
      subtitle: 'Discover amazing food at incredible prices',
      description: 'Find fresh, delicious meals from top restaurants and hotels at up to 70% off. Save money while helping reduce food waste.',
      lottieAsset: 'assets/animations/food_lover.json',
      icon: Icons.restaurant_menu,
      color: ModernColors.electricBlue,
      role: UserRoles.user,
    ),
    OnboardingPage(
      title: 'For Restaurants & Hotels',
      subtitle: 'Turn surplus food into revenue',
      description: 'List your excess food and reach customers who appreciate quality meals. Generate additional income while contributing to sustainability.',
      lottieAsset: 'assets/animations/restaurant.json',
      icon: Icons.store,
      color: ModernColors.neonPurple,
      role: UserRoles.vendor,
    ),
    OnboardingPage(
      title: 'Smart Platform',
      subtitle: 'AI-powered food redistribution',
      description: 'Our intelligent system ensures food safety, optimizes delivery routes, and provides real-time analytics for better decision making.',
      lottieAsset: 'assets/animations/ai_platform.json',
      icon: Icons.psychology,
      color: ModernColors.mintGreen,
      role: UserRoles.admin,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: ModernGradients.darkGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with skip button
              _buildHeader(),
              
              // Page content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _totalPages,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),
              
              // Bottom navigation
              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(ModernSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          GlassCard(
            width: 50,
            height: 50,
            borderRadius: BorderRadius.circular(ModernBorderRadius.full),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                gradient: ModernGradients.primaryGradient,
              ),
              child: const Icon(
                Icons.restaurant_menu,
                color: ModernColors.textPrimary,
                size: 24,
              ),
            ),
          ),
          
          // Skip button
          ModernTextButton(
            text: 'Skip',
            onPressed: _navigateToLogin,
            textColor: ModernColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: ModernSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Lottie animation
                  _buildLottieAnimation(page),
                  
                  const SizedBox(height: ModernSpacing.xxl),
                  
                  // Title
                  _buildTitle(page),
                  
                  const SizedBox(height: ModernSpacing.lg),
                  
                  // Subtitle
                  _buildSubtitle(page),
                  
                  const SizedBox(height: ModernSpacing.xl),
                  
                  // Description
                  _buildDescription(page),
                  
                  const SizedBox(height: ModernSpacing.xxl),
                  
                  // Role badge
                  _buildRoleBadge(page),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLottieAnimation(OnboardingPage page) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ModernBorderRadius.xxl),
        boxShadow: ModernShadows.neonGlow(page.color.withOpacity(0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ModernBorderRadius.xxl),
        child: GlassCard(
          borderRadius: BorderRadius.circular(ModernBorderRadius.xxl),
          borderColor: page.color.withOpacity(0.5),
          borderWidth: 2.0,
          child: Center(
            child: Lottie.asset(
              page.lottieAsset,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(OnboardingPage page) {
    return Text(
      page.title,
      style: ModernTextStyles.displayMedium.copyWith(
        background: Paint()
          ..shader = LinearGradient(
            colors: [page.color, page.color.withOpacity(0.7)],
          ).createShader(const Rect.fromLTWH(0, 0, 300, 50)),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle(OnboardingPage page) {
    return Text(
      page.subtitle,
      style: ModernTextStyles.headlineMedium.copyWith(
        color: ModernColors.textSecondary,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(OnboardingPage page) {
    return Text(
      page.description,
      style: ModernTextStyles.bodyLarge.copyWith(
        color: ModernColors.textTertiary,
        height: 1.6,
      ),
      textAlign: TextAlign.center,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildRoleBadge(OnboardingPage page) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: ModernSpacing.lg,
        vertical: ModernSpacing.md,
      ),
      borderColor: page.color.withOpacity(0.5),
      borderWidth: 1.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            page.icon,
            color: page.color,
            size: 20,
          ),
          const SizedBox(width: ModernSpacing.sm),
          Text(
            UserRoles.roleLabels[page.role] ?? page.role,
            style: ModernTextStyles.labelMedium.copyWith(
              color: page.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Padding(
      padding: const EdgeInsets.all(ModernSpacing.xl),
      child: Column(
        children: [
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_totalPages, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                  color: _currentPage == index 
                      ? ModernColors.electricBlue 
                      : ModernColors.textTertiary,
                ),
              );
            }),
          ),
          
          const SizedBox(height: ModernSpacing.xl),
          
          // Navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button
              if (_currentPage > 0)
                ModernOutlinedButton(
                  text: 'Previous',
                  onPressed: _previousPage,
                  icon: Icons.arrow_back,
                )
              else
                const SizedBox(width: 100),
              
              // Next/Get Started button
              ModernGradientButton(
                text: _currentPage == _totalPages - 1 ? 'Get Started' : 'Next',
                gradient: ModernGradients.primaryGradient,
                onPressed: _nextPage,
                trailingIcon: _currentPage == _totalPages - 1 
                    ? Icons.rocket_launch 
                    : Icons.arrow_forward,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String description;
  final String lottieAsset;
  final IconData icon;
  final Color color;
  final String role;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.lottieAsset,
    required this.icon,
    required this.color,
    required this.role,
  });
} 