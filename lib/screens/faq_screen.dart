import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Navbar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Hero Section
                  Container(
                    color: const Color(0xFF6C3EF4),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plateful FAQ',
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Frequently Asked Questions about Plateful.',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // FAQ Content Section
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Questions & Answers',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        // Placeholder for FAQ items
                        Container(
                          height: 80,
                          color: Colors.grey[200],
                          child: Center(child: Text('Q: What is Plateful?\nA: Plateful is India’s first food surplus marketplace.')),
                        ),
                        SizedBox(height: 24),
                        Container(
                          height: 80,
                          color: Colors.grey[200],
                          child: Center(child: Text('Q: How does Plateful work?\nA: We connect restaurants and customers to reduce food waste.')),
                        ),
                        // Add more FAQ items as needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 