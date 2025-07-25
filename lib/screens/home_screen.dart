import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../widgets/modern_button.dart';
import '../widgets/modern_footer.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double scrollOffset = 0;
  final ScrollController _scrollController = ScrollController();

  // Add reveal state for each section
  final List<bool> _revealed = List.filled(5, false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
      _checkReveal();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkReveal());
  }

  void _checkReveal() {
    final positions = [
      0.0, // How It Works
      600.0, // Features
      1200.0, // Community Impact
      1800.0, // Testimonials
      2300.0, // Download App
    ];
    final height = MediaQuery.of(context).size.height;
    for (int i = 0; i < positions.length; i++) {
      if (!_revealed[i] && scrollOffset + height > positions[i] + 200) {
        setState(() => _revealed[i] = true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heroHeight = size.height * 0.95;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // HERO SECTION (restored, fixed blur)
            SizedBox(
              height: heroHeight,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Parallax background image
                  Positioned.fill(
                    child: Transform.translate(
                      offset: Offset(0, scrollOffset * 0.25),
                      child: Image.asset(
                        AppImages.heroBg,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  // Glassmorphic overlay (fixed: subtle opacity, always behind content)
                  Positioned.fill(
                    child: ClipRect(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.heroOverlay.withOpacity(0.12), Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  // Content (always on top)
                  Positioned.fill(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Turn Surplus Into Support.',
                              style: AppTextStyles.headline.copyWith(fontSize: 54, color: AppColors.textDark),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            Text(
                              'Plateful connects extra food from restaurants and hotels with people who need it most.\n\nSave meals. Feed neighbors. Build a kinder city—together.',
                              style: AppTextStyles.body.copyWith(fontSize: 22, color: AppColors.textDark.withOpacity(0.92)),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 48),
                            ModernButton(
                              text: 'Get Started',
                              onPressed: () => GoRouter.of(context).go('/signup'),
                              isPrimary: true,
                              width: 200,
                              height: 56,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // How It Works Section
            AnimatedOpacity(
              opacity: _revealed[0] ? 1 : 0,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOut,
              child: AnimatedSlide(
                offset: _revealed[0] ? Offset(0, 0) : Offset(0, 0.12),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOut,
                child: SizedBox(
                  height: 600,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Parallax background
                      Positioned.fill(
                        child: Transform.translate(
                          offset: Offset(0, (scrollOffset - heroHeight) * 0.18),
                          child: Image.asset(
                            AppImages.howItWorksBg,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                      // Glassmorphic overlay
                      Positioned.fill(
                        child: ClipRect(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.heroOverlay.withOpacity(0.12), Colors.transparent],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'How It Works',
                                style: AppTextStyles.headline.copyWith(fontSize: 40),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 40),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final isMobile = constraints.maxWidth < 800;
                                  if (isMobile) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _HowItWorksCard(
                                          icon: Icons.restaurant,
                                          title: 'Surplus Collected',
                                          description: 'Restaurants and hotels list surplus food packs on Plateful.',
                                          delay: 0,
                                          isMobile: isMobile,
                                        ),
                                        SizedBox(width: 0, height: 32),
                                        _HowItWorksCard(
                                          icon: Icons.volunteer_activism,
                                          title: 'Community Connect',
                                          description: 'People in need discover and reserve affordable meals nearby.',
                                          delay: 200,
                                          isMobile: isMobile,
                                        ),
                                        SizedBox(width: 0, height: 32),
                                        _HowItWorksCard(
                                          icon: Icons.eco,
                                          title: 'Waste Reduced',
                                          description: 'Meals are picked up, enjoyed, and food waste is minimized.',
                                          delay: 400,
                                          isMobile: isMobile,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(child: _HowItWorksCard(
                                          icon: Icons.restaurant,
                                          title: 'Surplus Collected',
                                          description: 'Restaurants and hotels list surplus food packs on Plateful.',
                                          delay: 0,
                                          isMobile: isMobile,
                                        )),
                                        SizedBox(width: 32, height: 0),
                                        Expanded(child: _HowItWorksCard(
                                          icon: Icons.volunteer_activism,
                                          title: 'Community Connect',
                                          description: 'People in need discover and reserve affordable meals nearby.',
                                          delay: 200,
                                          isMobile: isMobile,
                                        )),
                                        SizedBox(width: 32, height: 0),
                                        Expanded(child: _HowItWorksCard(
                                          icon: Icons.eco,
                                          title: 'Waste Reduced',
                                          description: 'Meals are picked up, enjoyed, and food waste is minimized.',
                                          delay: 400,
                                          isMobile: isMobile,
                                        )),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Features Section
            AnimatedOpacity(
              opacity: _revealed[1] ? 1 : 0,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOut,
              child: AnimatedSlide(
                offset: _revealed[1] ? Offset(0, 0) : Offset(0, 0.12),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOut,
                child: SizedBox(
                  height: 600,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Parallax background
                      Positioned.fill(
                        child: Transform.translate(
                          offset: Offset(0, (scrollOffset - heroHeight - 600) * 0.15),
                          child: Image.asset(
                            AppImages.featuresBg,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                      // Glassmorphic overlay
                      Positioned.fill(
                        child: ClipRect(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.heroOverlay.withOpacity(0.12), Colors.transparent],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Features',
                                style: AppTextStyles.headline.copyWith(fontSize: 40),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 40),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final isMobile = constraints.maxWidth < 800;
                                  if (isMobile) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _FeaturesCard(
                                          icon: Icons.auto_awesome,
                                          title: 'Smart Recommendations',
                                          description: 'AI-powered suggestions help users find the best surplus meals nearby.',
                                          delay: 0,
                                          isMobile: isMobile,
                                        ),
                                        SizedBox(width: 0, height: 32),
                                        _FeaturesCard(
                                          icon: Icons.notifications_active,
                                          title: 'Real-Time Updates',
                                          description: 'Get instant notifications when new food packs are listed or reserved.',
                                          delay: 200,
                                          isMobile: isMobile,
                                        ),
                                        SizedBox(width: 0, height: 32),
                                        _FeaturesCard(
                                          icon: Icons.people_alt,
                                          title: 'Community Impact',
                                          description: 'Every meal reserved helps reduce waste and nourish someone in need.',
                                          delay: 400,
                                          isMobile: isMobile,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(child: _FeaturesCard(
                                          icon: Icons.auto_awesome,
                                          title: 'Smart Recommendations',
                                          description: 'AI-powered suggestions help users find the best surplus meals nearby.',
                                          delay: 0,
                                          isMobile: isMobile,
                                        )),
                                        SizedBox(width: 32, height: 0),
                                        Expanded(child: _FeaturesCard(
                                          icon: Icons.notifications_active,
                                          title: 'Real-Time Updates',
                                          description: 'Get instant notifications when new food packs are listed or reserved.',
                                          delay: 200,
                                          isMobile: isMobile,
                                        )),
                                        SizedBox(width: 32, height: 0),
                                        Expanded(child: _FeaturesCard(
                                          icon: Icons.people_alt,
                                          title: 'Community Impact',
                                          description: 'Every meal reserved helps reduce waste and nourish someone in need.',
                                          delay: 400,
                                          isMobile: isMobile,
                                        )),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Community Impact Section
            AnimatedOpacity(
              opacity: _revealed[2] ? 1 : 0,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOut,
              child: AnimatedSlide(
                offset: _revealed[2] ? Offset(0, 0) : Offset(0, 0.12),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOut,
                child: SizedBox(
                  height: 600,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Parallax background
                      Positioned.fill(
                        child: Transform.translate(
                          offset: Offset(0, (scrollOffset - heroHeight - 1200) * 0.12),
                          child: Image.asset(
                            AppImages.communityBg,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                      // Glassmorphic overlay
                      Positioned.fill(
                        child: ClipRect(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.heroOverlay.withOpacity(0.12), Colors.transparent],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Community Impact',
                                style: AppTextStyles.headline.copyWith(fontSize: 40),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 40),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final isMobile = constraints.maxWidth < 800;
                                  if (isMobile) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _ImpactCard(
                                          icon: Icons.favorite,
                                          title: '12,000+ Meals Shared',
                                          description: 'Thousands of surplus meals have reached people in need.',
                                          delay: 0,
                                          isMobile: isMobile,
                                        ),
                                        SizedBox(width: 0, height: 32),
                                        _ImpactCard(
                                          icon: Icons.eco,
                                          title: '20 Tons of Food Saved',
                                          description: 'Significant reduction in food waste and environmental impact.',
                                          delay: 200,
                                          isMobile: isMobile,
                                        ),
                                        SizedBox(width: 0, height: 32),
                                        _ImpactCard(
                                          icon: Icons.people,
                                          title: 'Growing Community',
                                          description: 'Vendors, volunteers, and users working together for good.',
                                          delay: 400,
                                          isMobile: isMobile,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(child: _ImpactCard(
                                          icon: Icons.favorite,
                                          title: '12,000+ Meals Shared',
                                          description: 'Thousands of surplus meals have reached people in need.',
                                          delay: 0,
                                          isMobile: isMobile,
                                        )),
                                        SizedBox(width: 32, height: 0),
                                        Expanded(child: _ImpactCard(
                                          icon: Icons.eco,
                                          title: '20 Tons of Food Saved',
                                          description: 'Significant reduction in food waste and environmental impact.',
                                          delay: 200,
                                          isMobile: isMobile,
                                        )),
                                        SizedBox(width: 32, height: 0),
                                        Expanded(child: _ImpactCard(
                                          icon: Icons.people,
                                          title: 'Growing Community',
                                          description: 'Vendors, volunteers, and users working together for good.',
                                          delay: 400,
                                          isMobile: isMobile,
                                        )),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Testimonials Section
            AnimatedOpacity(
              opacity: _revealed[3] ? 1 : 0,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOut,
              child: AnimatedSlide(
                offset: _revealed[3] ? Offset(0, 0) : Offset(0, 0.12),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOut,
                child: SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Soft blurred overlay
                      Positioned.fill(
                        child: ClipRect(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white.withOpacity(0.92), Colors.white.withOpacity(0.7)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'What Our Community Says',
                                style: AppTextStyles.headline.copyWith(fontSize: 38),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 40),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final isMobile = constraints.maxWidth < 900;
                                  if (isMobile) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _TestimonialCard(
                                          avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
                                          name: 'Amit S.',
                                          quote: 'Plateful made healthy eating so easy! The packs are delicious and always fresh.',
                                          delay: 0,
                                          isMobile: isMobile,
                                        ),
                                        SizedBox(width: 0, height: 32),
                                        _TestimonialCard(
                                          avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
                                          name: 'Priya K.',
                                          quote: 'Love the variety and convenience. Highly recommend to anyone!',
                                          delay: 200,
                                          isMobile: isMobile,
                                        ),
                                        SizedBox(width: 0, height: 32),
                                        _TestimonialCard(
                                          avatar: 'https://randomuser.me/api/portraits/men/65.jpg',
                                          name: 'Rahul D.',
                                          quote: 'Great service and tasty food. My family loves the Family Feast pack!',
                                          delay: 400,
                                          isMobile: isMobile,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(child: _TestimonialCard(
                                          avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
                                          name: 'Amit S.',
                                          quote: 'Plateful made healthy eating so easy! The packs are delicious and always fresh.',
                                          delay: 0,
                                          isMobile: isMobile,
                                        )),
                                        SizedBox(width: 32, height: 0),
                                        Expanded(child: _TestimonialCard(
                                          avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
                                          name: 'Priya K.',
                                          quote: 'Love the variety and convenience. Highly recommend to anyone!',
                                          delay: 200,
                                          isMobile: isMobile,
                                        )),
                                        SizedBox(width: 32, height: 0),
                                        Expanded(child: _TestimonialCard(
                                          avatar: 'https://randomuser.me/api/portraits/men/65.jpg',
                                          name: 'Rahul D.',
                                          quote: 'Great service and tasty food. My family loves the Family Feast pack!',
                                          delay: 400,
                                          isMobile: isMobile,
                                        )),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Download App (CTA) Section
            AnimatedOpacity(
              opacity: _revealed[4] ? 1 : 0,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOut,
              child: AnimatedSlide(
                offset: _revealed[4] ? Offset(0, 0) : Offset(0, 0.12),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOut,
                child: SizedBox(
                  height: 340,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Clean blurred overlay
                      Positioned.fill(
                        child: ClipRect(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white.withOpacity(0.85), Colors.white.withOpacity(0.6)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Get the Plateful App',
                                style: AppTextStyles.headline.copyWith(fontSize: 38),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Join a movement to save food and nourish your community. Download now and start making a difference!',
                                style: AppTextStyles.body.copyWith(fontSize: 20, color: AppColors.textDark.withOpacity(0.85)),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 40),
                              ModernButton(
                                text: 'Get Started',
                                onPressed: () {},
                                isPrimary: true,
                                width: 220,
                                height: 56,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Footer Section
            ModernFooter(),
          ],
        ),
      ),
    );
  }
}

class _HowItWorksCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final int delay;
  final bool isMobile;
  const _HowItWorksCard({required this.icon, required this.title, required this.description, required this.delay, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 800 + delay),
      child: Container(
        width: isMobile ? 320 : 340,
        margin: EdgeInsets.symmetric(vertical: isMobile ? 16 : 0),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: AppGradients.glass,
          boxShadow: AppShadows.glass,
        ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Icon(icon, size: 48, color: AppColors.primary),
            const SizedBox(height: 24),
            Text(title, style: AppTextStyles.subhead.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 16),
            Text(description, style: AppTextStyles.body.copyWith(fontSize: 18, color: AppColors.textDark.withOpacity(0.8)), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _FeaturesCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final int delay;
  final bool isMobile;
  const _FeaturesCard({required this.icon, required this.title, required this.description, required this.delay, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 800 + delay),
      child: Container(
        width: isMobile ? 320 : 340,
        margin: EdgeInsets.symmetric(vertical: isMobile ? 16 : 0),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: AppGradients.glass,
          boxShadow: AppShadows.glass,
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Icon(icon, size: 48, color: AppColors.primary),
            const SizedBox(height: 24),
            Text(title, style: AppTextStyles.subhead.copyWith(fontSize: 26), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text(description, style: AppTextStyles.body.copyWith(fontSize: 18, color: AppColors.textDark.withOpacity(0.8)), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _ImpactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final int delay;
  final bool isMobile;
  const _ImpactCard({required this.icon, required this.title, required this.description, required this.delay, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 800 + delay),
      child: Container(
        width: isMobile ? 320 : 340,
        margin: EdgeInsets.symmetric(vertical: isMobile ? 16 : 0),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: AppGradients.glass,
          boxShadow: AppShadows.glass,
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Icon(icon, size: 48, color: AppColors.primary),
            const SizedBox(height: 24),
            Text(title, style: AppTextStyles.subhead.copyWith(fontSize: 26), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text(description, style: AppTextStyles.body.copyWith(fontSize: 18, color: AppColors.textDark.withOpacity(0.8)), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String avatar;
  final String name;
  final String quote;
  final int delay;
  final bool isMobile;
  const _TestimonialCard({required this.avatar, required this.name, required this.quote, required this.delay, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 800 + delay),
      child: Container(
        width: isMobile ? 320 : 340,
        margin: EdgeInsets.symmetric(vertical: isMobile ? 16 : 0),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: AppGradients.glass,
          boxShadow: AppShadows.glass,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: Image.network(
                  avatar,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 64),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(name, style: AppTextStyles.subhead.copyWith(fontSize: 20)),
            const SizedBox(height: 14),
            Text('“$quote”', style: AppTextStyles.body.copyWith(fontSize: 18, fontStyle: FontStyle.italic, color: AppColors.textDark.withOpacity(0.8)), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
