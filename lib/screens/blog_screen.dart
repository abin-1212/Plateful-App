import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

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
                    'Plateful Blog',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tips, stories, and updates from the world of surplus food.',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // Blog Posts Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest Posts',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32),
                  _blogPostPreview(
                    title: 'How Plateful Empowers Consumers to Make a Difference',
                    date: '10 Apr 2025',
                    imageUrl: 'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fblog1.png&w=640&q=75',
                    excerpt: 'Discover how Plateful is redefining food consumption in India: affordable, sustainable & smart.',
                  ),
                  SizedBox(height: 32),
                  _blogPostPreview(
                    title: 'Sustainable Living with Plateful: A Step Towards a Greener India',
                    date: '6 Sept 2024',
                    imageUrl: 'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fblog2.png&w=640&q=75',
                    excerpt: 'Learn how you can make a positive impact on the environment and your wallet with Plateful.',
                  ),
                  SizedBox(height: 32),
                  _blogPostPreview(
                    title: 'Tackling Food Waste in India: How Plateful Empowers Consumers',
                    date: '6 Sept 2024',
                    imageUrl: 'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fblog3.png&w=640&q=75',
                    excerpt: 'Explore practical tips and real stories on reducing food waste and supporting local communities.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blogPostPreview({
    required String title,
    required String date,
    required String imageUrl,
    required String excerpt,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.network(
              imageUrl,
              width: 180,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    date,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 12),
                  Text(
                    excerpt,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () {},
                    child: Text('Read More', style: TextStyle(color: Color(0xFF6C3EF4))),
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