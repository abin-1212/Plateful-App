import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Navbar(),
            // Hero Section
            Container(
              color: const Color(0xFF6C3EF4),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Plateful Reviews',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Real success stories from our beloved partners and customers.',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // Testimonials Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Testimonials',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _testimonialCard(
                        name: 'Ravi Sharma',
                        location: 'Trivandrum, Kerala',
                        quote: '"I used to worry about throwing away unsold idlis and dosas every day. But with Plateful, I can sell them to people who appreciate a good deal. It’s extra income for me and a way to serve more customers. I’ve never felt this confident about managing my kitchen stock!"',
                        imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
                      ),
                      _testimonialCard(
                        name: 'Priya Nair',
                        location: 'Kochi, Kerala',
                        quote: '"Plateful has been a game-changer for my bakery. Every evening, I list my surplus bread and pastries, and they sell out in no time. Customers love the deals, and I love that nothing goes to waste. Plus, I’ve started making extra revenue without any extra effort!"',
                        imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _testimonialCard(
                        name: 'Amit Patel',
                        location: 'Ahmedabad, Gujarat',
                        quote: '"Great platform to reduce food waste and support local businesses. Highly recommended!"',
                        imageUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
                      ),
                      _testimonialCard(
                        name: 'Sunita Rao',
                        location: 'Bangalore, Karnataka',
                        quote: '"I love the surprise element and the savings. Plateful is a win-win for everyone!"',
                        imageUrl: 'https://randomuser.me/api/portraits/women/65.jpg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _testimonialCard({
    required String name,
    required String location,
    required String quote,
    required String imageUrl,
  }) {
    return SizedBox(
      width: 320,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 32,
              ),
              SizedBox(height: 16),
              Text(
                quote,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                location,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 