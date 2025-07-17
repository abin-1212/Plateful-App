import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'package:glass_kit/glass_kit.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Navbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ReviewsHeroSection(),
            _TestimonialListSection(),
            const SizedBox(height: 32),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _ReviewsHeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF23244D),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Plateful Reviews',
            style: GoogleFonts.orbitron(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Real success stories from our beloved partners and users.',
            style: GoogleFonts.orbitron(
              fontSize: 22,
              color: Colors.tealAccent,
              fontWeight: FontWeight.w500,
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          Text(
            'What Our Users Say',
            style: GoogleFonts.orbitron(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.tealAccent,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: testimonials.map((t) => _TestimonialCard(t)).toList(),
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final Map<String, String> testimonial;
  const _TestimonialCard(this.testimonial);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF23244D),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.tealAccent.withOpacity(0.08),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(testimonial['img']!),
            radius: 36,
          ),
          const SizedBox(height: 16),
          Text(
            '"${testimonial['text']}"',
            style: GoogleFonts.orbitron(
              fontSize: 15,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            testimonial['name']!,
            style: GoogleFonts.orbitron(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.tealAccent,
            ),
          ),
          Text(
            testimonial['location']!,
            style: GoogleFonts.orbitron(
              fontSize: 13,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
} 