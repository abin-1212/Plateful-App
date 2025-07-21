import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../themes/modern_theme.dart';
import '../../widgets/modern/glass_card.dart';
import '../../constants/app_constants.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _loadingController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _loadingOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));
    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));

    // Loading animations
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _loadingOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeIn,
    ));
  }

  void _startAnimations() async {
    // Start logo animation
    await _logoController.forward();
    
    // Start text animation
    await _textController.forward();
    
    // Start loading animation
    await _loadingController.forward();
    
    // Wait for a moment then navigate
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() {
    // TODO: Check if user is logged in and navigate accordingly
    context.go(AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: ModernGradients.darkGradient,
        ),
        child: Stack(
          children: [
            // Animated background elements
            _buildBackgroundElements(),
            
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo section
                  _buildLogoSection(),
                  
                  const SizedBox(height: ModernSpacing.xxl),
                  
                  // App name and tagline
                  _buildAppInfoSection(),
                  
                  const SizedBox(height: ModernSpacing.xxxl),
                  
                  // Loading section
                  _buildLoadingSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        // Floating orbs
        Positioned(
          top: 100,
          left: 50,
          child: _buildFloatingOrb(ModernColors.electricBlue, 60),
        ),
        Positioned(
          top: 200,
          right: 80,
          child: _buildFloatingOrb(ModernColors.neonPurple, 40),
        ),
        Positioned(
          bottom: 150,
          left: 100,
          child: _buildFloatingOrb(ModernColors.mintGreen, 50),
        ),
        Positioned(
          bottom: 250,
          right: 60,
          child: _buildFloatingOrb(ModernColors.neonPink, 70),
        ),
      ],
    );
  }

  Widget _buildFloatingOrb(Color color, double size) {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 10 * _logoController.value),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color.withOpacity(0.3),
                  color.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
              boxShadow: ModernShadows.neonGlow(color.withOpacity(0.2)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogoSection() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScaleAnimation.value,
          child: Opacity(
            opacity: _logoOpacityAnimation.value,
            child: GlowingGlassCard(
              width: 120,
              height: 120,
              borderRadius: BorderRadius.circular(ModernBorderRadius.full),
              glowColor: ModernColors.electricBlue,
              glowIntensity: 0.5,
              enablePulse: true,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                  gradient: ModernGradients.primaryGradient,
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  size: 60,
                  color: ModernColors.textPrimary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppInfoSection() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return Opacity(
          opacity: _textOpacityAnimation.value,
          child: Column(
            children: [
              // App name
              Text(
                AppConfig.appName,
                style: ModernTextStyles.displayLarge.copyWith(
                  background: Paint()
                    ..shader = ModernGradients.primaryGradient.createShader(
                      const Rect.fromLTWH(0, 0, 200, 50),
                    ),
                ),
              ),
              
              const SizedBox(height: ModernSpacing.md),
              
              // Tagline with animated text
              SizedBox(
                width: 300,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      AppConfig.appTagline,
                      textStyle: ModernTextStyles.bodyLarge.copyWith(
                        color: ModernColors.textSecondary,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingSection() {
    return AnimatedBuilder(
      animation: _loadingController,
      builder: (context, child) {
        return Opacity(
          opacity: _loadingOpacityAnimation.value,
          child: Column(
            children: [
              // Custom loading spinner
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                  border: Border.all(
                    color: ModernColors.electricBlue.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(ModernColors.electricBlue),
                  backgroundColor: ModernColors.electricBlue.withOpacity(0.1),
                ),
              ),
              
              const SizedBox(height: ModernSpacing.lg),
              
              // Loading text
              Text(
                'Loading...',
                style: ModernTextStyles.bodyMedium.copyWith(
                  color: ModernColors.textTertiary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 