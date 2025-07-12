import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Navbar(),
            // Hero Section
            Container(
              color: const Color(0xFF6C3EF4),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Plateful',
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "India's First Food Surplus Marketplace",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fabout-hero.png&w=640&q=75',
                          fit: BoxFit.cover,
                          height: 180,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Mission Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Our Mission',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'At Plateful, we connect restaurants, bakeries, supermarkets, and customers on one unified platform. Our mission is to make food accessible and affordable for everyone, while reducing food waste and supporting local businesses.',
                          style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                        ),
                        SizedBox(height: 32),
                        Text(
                          'How Plateful Works',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Discover unbeatable deals on surplus meals, baked goods, and groceries. Reserve surprise bags, pick up at your convenience, and enjoy great food at a fraction of the cost!\n\n1. Download & Explore: Download the Plateful app and sign up to get started. Discover a variety of packs and listings from nearby restaurants and supermarkets.\n2. Reserve a Surprise Bag: Choose a surprise bag from your favorite local stores and reserve it at a discounted price.\n3. Pick Up & Enjoy: Pick up your bag at the scheduled time and enjoy delicious food at unbeatable prices!',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fmission.png&w=640&q=75',
                          fit: BoxFit.cover,
                          height: 220,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Why Use Plateful Section
            Container(
              color: Color(0xFFF5F5F5),
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Why Use Plateful?',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'We’ve designed Plateful to give you the best deals on fresh, surplus food—seamless, affordable, and rewarding for both you and your favorite restaurants.\n\n- Enjoy great food at half the price or less\n- Avoid the hassle of choosing the dish by ordering with a few taps\n- Support local vendors and reduce food waste\n- No hidden charges, flexible pickup time, guaranteed discount, and exclusive value packs',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fwhyuse.png&w=640&q=75',
                          fit: BoxFit.cover,
                          height: 180,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 