import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/pack_card_widget.dart';
import '../widgets/testimonial_card.dart';
import '../widgets/cta_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(),
            _HeroSection(isMobile: isMobile),
            _HowItWorksSection(isMobile: isMobile),
            _FeaturedPacksSection(isMobile: isMobile),
            _TestimonialsSection(isMobile: isMobile),
            CTABanner(
              headline: 'Ready to experience Plateful?',
              subheadline: 'Sign up now and enjoy curated food packs delivered to your doorstep.',
              buttonText: 'Get Started',
            ),
            const SizedBox(height: 12), // Add bottom padding to prevent overflow
            Footer(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool isMobile;
  const _HeroSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 64,
        vertical: isMobile ? 36 : 64,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _HeroText(isMobile: true),
                const SizedBox(height: 32),
                _HeroImage(isMobile: true),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 5, child: _HeroText(isMobile: false)),
                const SizedBox(width: 48),
                Expanded(flex: 5, child: _HeroImage(isMobile: false)),
              ],
            ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final bool isMobile;
  const _HeroText({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Curated Food Packs, Delivered Fresh',
          style: GoogleFonts.poppins(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w800,
            fontSize: isMobile ? 28 : 40,
            letterSpacing: 1.2,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 18),
        Text(
          'Discover, order, and enjoy delicious food packs from top brands, all in one place.',
          style: GoogleFonts.poppins(
            color: Colors.deepPurple.withOpacity(0.8),
            fontWeight: FontWeight.w500,
            fontSize: isMobile ? 16 : 20,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.tealAccent,
            foregroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
            textStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/packs');
          },
          child: const Text('Explore Packs'),
        ),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  final bool isMobile;
  const _HeroImage({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? 220 : 340,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.10),
            blurRadius: 32,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
    );
  }
}

class _HowItWorksSection extends StatelessWidget {
  final bool isMobile;
  const _HowItWorksSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'icon': Icons.search,
        'title': 'Browse Packs',
        'desc': 'Explore curated food packs from top brands.'
      },
      {
        'icon': Icons.shopping_cart_checkout,
        'title': 'Order Easily',
        'desc': 'Add your favorite packs to cart and checkout securely.'
      },
      {
        'icon': Icons.delivery_dining,
        'title': 'Fast Delivery',
        'desc': 'Get your packs delivered fresh to your doorstep.'
      },
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 64,
        vertical: isMobile ? 32 : 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'How It Works',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 22 : 28,
            ),
          ),
          const SizedBox(height: 32),
          isMobile
              ? Column(
                  children: steps.map((step) => _HowItWorksStep(step: step, isMobile: true)).toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: steps.map((step) => Expanded(child: _HowItWorksStep(step: step, isMobile: false))).toList(),
                ),
        ],
      ),
    );
  }
}

class _HowItWorksStep extends StatelessWidget {
  final Map<String, dynamic> step;
  final bool isMobile;
  const _HowItWorksStep({required this.step, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 18, vertical: isMobile ? 18 : 0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.tealAccent.withOpacity(0.18),
            child: Icon(step['icon'], color: Colors.deepPurple, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            step['title'],
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step['desc'],
            style: GoogleFonts.poppins(
              color: Colors.deepPurple.withOpacity(0.7),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FeaturedPacksSection extends StatelessWidget {
  final bool isMobile;
  const _FeaturedPacksSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final packs = [
      {
        'image': 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=400&q=80',
        'title': 'Protein Power Pack',
        'desc': 'High-protein meals for fitness lovers.',
        'price': '₹499',
        'offer': '10% OFF',
      },
      {
        'image': 'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=400&q=80',
        'title': 'Vegan Delight',
        'desc': 'Delicious plant-based food packs.',
        'price': '₹399',
        'offer': '15% OFF',
      },
      {
        'image': 'https://images.unsplash.com/photo-1464306076886-debca5e8a6b0?auto=format&fit=crop&w=400&q=80',
        'title': 'Family Feast',
        'desc': 'Perfect for sharing with loved ones.',
        'price': '₹899',
        'offer': '20% OFF',
      },
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 64,
        vertical: isMobile ? 32 : 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Featured Packs',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 22 : 28,
            ),
          ),
          const SizedBox(height: 32),
          CarouselWidget(
            items: packs
                .map((pack) => PackCardWidget(
                      imageUrl: pack['image']!,
                      title: pack['title']!,
                      description: pack['desc']!,
                      price: pack['price']!,
                      offer: pack['offer'],
                      onViewDetails: () {},
                    ))
                .toList(),
            height: isMobile ? 340 : 380,
          ),
        ],
      ),
    );
  }
}

class _TestimonialsSection extends StatelessWidget {
  final bool isMobile;
  const _TestimonialsSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final testimonials = [
      {
        'avatar': 'https://randomuser.me/api/portraits/men/32.jpg',
        'name': 'Amit S.',
        'testimonial': 'Plateful made healthy eating so easy! The packs are delicious and always fresh.',
        'rating': 5,
      },
      {
        'avatar': 'https://randomuser.me/api/portraits/women/44.jpg',
        'name': 'Priya K.',
        'testimonial': 'Love the variety and convenience. Highly recommend to anyone!',
        'rating': 5,
      },
      {
        'avatar': 'https://randomuser.me/api/portraits/men/65.jpg',
        'name': 'Rahul D.',
        'testimonial': 'Great service and tasty food. My family loves the Family Feast pack!',
        'rating': 4,
      },
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 64,
        vertical: isMobile ? 32 : 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'What Our Customers Say',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 22 : 28,
            ),
          ),
          const SizedBox(height: 32),
          CarouselWidget(
            items: testimonials
                .map((t) => TestimonialCard(
                      avatarUrl: t['avatar'] as String,
                      name: t['name'] as String,
                      testimonial: t['testimonial'] as String,
                      rating: t['rating'] as int?,
                    ))
                .toList(),
            height: isMobile ? 260 : 280,
          ),
        ],
      ),
    );
  }
}
