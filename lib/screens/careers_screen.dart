import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

class CareersScreen extends StatelessWidget {
  const CareersScreen({super.key});

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
                          'Plateful Careers',
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Join our mission to reduce food waste and make a difference.',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Careers Content Section
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Open Positions',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        // Placeholder for job listings
                        Container(
                          height: 100,
                          color: Colors.grey[200],
                          child: Center(child: Text('Job listing 1')),
                        ),
                        SizedBox(height: 24),
                        Container(
                          height: 100,
                          color: Colors.grey[200],
                          child: Center(child: Text('Job listing 2')),
                        ),
                        // Add more job listings as needed
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