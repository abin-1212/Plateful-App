import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: GlassContainer.clearGlass(
                width: 900, // Added width for hero section glass container
                height: 220, // Added height for hero section glass container
                borderRadius: BorderRadius.circular(32),
                blur: 16,
                borderWidth: 2,
                borderColor: Colors.white.withOpacity(0.18),
                elevation: 8,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.18),
                    Colors.deepPurple.withOpacity(0.12),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'Plateful Blog',
                            textStyle: GoogleFonts.orbitron(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  blurRadius: 16,
                                  color: Colors.tealAccent.withOpacity(0.7),
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            speed: Duration(milliseconds: 40),
                          ),
                        ],
                        isRepeatingAnimation: false,
                      ),
                      SizedBox(height: 16),
                      AnimatedTextKit(
                        animatedTexts: [
                          FadeAnimatedText(
                            'Tips, stories, and updates from the world of surplus food.',
                            textStyle: GoogleFonts.orbitron(
                              fontSize: 24,
                              color: Colors.tealAccent,
                              fontWeight: FontWeight.w500,
                            ),
                            duration: Duration(milliseconds: 1800),
                          ),
                        ],
                        isRepeatingAnimation: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Blog Posts Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest Posts',
                    style: GoogleFonts.orbitron(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  SizedBox(height: 32),
                  _Blog3DCard(
                    title: 'How Plateful Empowers Consumers to Make a Difference',
                    date: '10 Apr 2025',
                    imageUrl: 'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fblog1.png&w=640&q=75',
                    excerpt: 'Discover how Plateful is redefining food consumption in India: affordable, sustainable & smart.',
                  ),
                  SizedBox(height: 32),
                  _Blog3DCard(
                    title: 'Sustainable Living with Plateful: A Step Towards a Greener India',
                    date: '6 Sept 2024',
                    imageUrl: 'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fblog2.png&w=640&q=75',
                    excerpt: 'Learn how you can make a positive impact on the environment and your wallet with Plateful.',
                  ),
                  SizedBox(height: 32),
                  _Blog3DCard(
                    title: 'Tackling Food Waste in India: How Plateful Empowers Consumers',
                    date: '6 Sept 2024',
                    imageUrl: 'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fblog3.png&w=640&q=75',
                    excerpt: 'Explore practical tips and real stories on reducing food waste and supporting local communities.',
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _Blog3DCard extends StatefulWidget {
  final String title;
  final String date;
  final String imageUrl;
  final String excerpt;
  const _Blog3DCard({required this.title, required this.date, required this.imageUrl, required this.excerpt});

  @override
  State<_Blog3DCard> createState() => _Blog3DCardState();
}

class _Blog3DCardState extends State<_Blog3DCard> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: _hovering ? (Matrix4.identity()..translate(0.0, -8.0, 0.0)..scale(1.03)) : Matrix4.identity(),
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: _hovering ? 16 : 8,
            intensity: 0.7,
            surfaceIntensity: 0.25,
            color: Colors.white.withOpacity(0.95),
            shadowLightColor: Colors.tealAccent,
            shadowDarkColor: Colors.deepPurple,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                child: Image.network(
                  widget.imageUrl,
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
                        widget.title,
                        style: GoogleFonts.orbitron(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.date,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 12),
                      Text(
                        widget.excerpt,
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
        ),
      ),
    );
  }
} 