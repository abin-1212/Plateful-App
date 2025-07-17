import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(),
            _BlogHeader(isMobile: isMobile),
            _BlogList(isMobile: isMobile),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class _BlogHeader extends StatelessWidget {
  final bool isMobile;
  const _BlogHeader({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 64,
        vertical: isMobile ? 48 : 72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Plateful Blog',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w800,
              fontSize: isMobile ? 32 : 44,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          Text(
            'Tips, stories, and updates from the world of food packs.',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple.withOpacity(0.8),
              fontWeight: FontWeight.w500,
              fontSize: isMobile ? 16 : 20,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BlogList extends StatelessWidget {
  final bool isMobile;
  const _BlogList({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final posts = [
      {
        'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=600&q=80',
        'title': '5 Reasons to Try Curated Food Packs',
        'excerpt': 'Discover why food packs are the next big thing in convenient, healthy eating.',
        'author': 'Aarav Mehta',
        'date': 'May 2024',
      },
      {
        'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=600&q=80',
        'title': 'How Plateful Ensures Freshness',
        'excerpt': 'A behind-the-scenes look at our quality and delivery process.',
        'author': 'Saanvi Sharma',
        'date': 'April 2024',
      },
      {
        'image': 'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=600&q=80',
        'title': 'Meet Our Partner Brands',
        'excerpt': 'Get to know the amazing brands that make Plateful possible.',
        'author': 'Kabir Patel',
        'date': 'March 2024',
      },
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 64,
        vertical: isMobile ? 32 : 48,
      ),
      child: isMobile
          ? Column(
              children: posts
                  .map((post) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: _BlogCard(post: post, isMobile: true),
                      ))
                  .toList(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: posts
                  .map((post) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: _BlogCard(post: post, isMobile: false),
                        ),
                      ))
                  .toList(),
            ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final Map<String, String> post;
  final bool isMobile;
  const _BlogCard({required this.post, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.08),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Image.network(
              post['image']!,
              height: isMobile ? 180 : 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['title']!,
                  style: GoogleFonts.poppins(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w700,
                    fontSize: isMobile ? 18 : 22,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  post['excerpt']!,
                  style: GoogleFonts.poppins(
                    color: Colors.deepPurple.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                    fontSize: isMobile ? 14 : 16,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.tealAccent.withOpacity(0.18),
                      child: Icon(Icons.person, color: Colors.deepPurple, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      post['author']!,
                      style: GoogleFonts.poppins(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.calendar_today, color: Colors.deepPurple.withOpacity(0.6), size: 16),
                    const SizedBox(width: 6),
                    Text(
                      post['date']!,
                      style: GoogleFonts.poppins(
                        color: Colors.deepPurple.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      foregroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Read More'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 