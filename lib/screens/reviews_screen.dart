import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'package:glass_kit/glass_kit.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../widgets/modern_card.dart';
import '../widgets/modern_section.dart';
import '../constants/app_constants.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return ModernScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ModernSection(
              child: _ReviewsHeroSection(isMobile: isMobile),
            ),
            ModernSection(
              child: _TestimonialListSection(isMobile: isMobile),
            ),
            const SizedBox(height: 32),
            ModernFooter(),
          ],
        ),
      ),
    );
  }
}

class _ReviewsHeroSection extends StatelessWidget {
  final bool isMobile;
  const _ReviewsHeroSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF23244D),
      padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 48, horizontal: isMobile ? 16 : 24),
      child: Column(
        children: [
          Text(
            'Plateful Reviews',
            style: AppTextStyles.h1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Real success stories from our beloved partners and users.',
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Image.network(
            'https://images.unsplash.com/photo-1465101178521-c1a9136a3b99?auto=format&fit=crop&w=800&q=80',
            height: 180,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class _TestimonialListSection extends StatelessWidget {
  final bool isMobile;
  const _TestimonialListSection({required this.isMobile});

  final List<Map<String, String>> testimonials = const [
    {
      'name': 'Ravi Sharma',
      'location': 'Trivandrum, Kerala',
      'text': 'I used to worry about throwing away unsold idlis and dosas every day. But with Plateful, I can sell them to people who appreciate a good deal. It’s extra income for me and a way to serve more customers. I’ve never felt this confident about managing my kitchen stock!',
      'img': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=80',
    },
    {
      'name': 'Priya Nair',
      'location': 'Kochi, Kerala',
      'text': 'Plateful has been a game-changer for my bakery. Every evening, I list my surplus bread and pastries, and they sell out in no time. Customers love the deals, and I love that nothing goes to waste. Plus, I’ve started making extra revenue without any extra effort!',
      'img': 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=200&q=80',
    },
    {
      'name': 'Amit Verma',
      'location': 'Bangalore, Karnataka',
      'text': 'With Plateful, I get to try new foods at great prices and support local businesses. It’s a win-win!',
      'img': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
    },
    {
      'name': 'Sunita Rao',
      'location': 'Mumbai, Maharashtra',
      'text': 'I love the surprise element in every Plateful Pack. It’s always fresh, delicious, and affordable!',
      'img': 'https://images.unsplash.com/photo-1511367461989-f85a21fda167?auto=format&fit=crop&w=200&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF181A2A),
      padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 48, horizontal: isMobile ? 16 : 24),
      child: Column(
        children: [
          Text(
            'What Our Users Say',
            style: AppTextStyles.h2,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: testimonials.map((t) => _TestimonialCard(t, isMobile: isMobile)).toList(),
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final Map<String, String> testimonial;
  final bool isMobile;
  const _TestimonialCard(this.testimonial, {required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(testimonial['img']!),
            radius: 36,
          ),
          const SizedBox(height: 16),
          Text(
            '"${testimonial['text']}"',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            testimonial['name']!,
            style: AppTextStyles.bodyMedium,
          ),
          Text(
            testimonial['location']!,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
} 