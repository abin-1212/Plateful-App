import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
                            'Plateful Reviews',
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
                            'Real success stories from our beloved partners and customers.',
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
            // Testimonials Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Testimonials',
                    style: GoogleFonts.orbitron(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Testimonial3DCard(
                        name: 'Ravi Sharma',
                        location: 'Trivandrum, Kerala',
                        quote: '"I used to worry about throwing away unsold idlis and dosas every day. But with Plateful, I can sell them to people who appreciate a good deal. It’s extra income for me and a way to serve more customers. I’ve never felt this confident about managing my kitchen stock!"',
                        imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
                      ),
                      _Testimonial3DCard(
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
                      _Testimonial3DCard(
                        name: 'Amit Patel',
                        location: 'Ahmedabad, Gujarat',
                        quote: '"Great platform to reduce food waste and support local businesses. Highly recommended!"',
                        imageUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
                      ),
                      _Testimonial3DCard(
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
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class _Testimonial3DCard extends StatefulWidget {
  final String name;
  final String location;
  final String quote;
  final String imageUrl;
  const _Testimonial3DCard({required this.name, required this.location, required this.quote, required this.imageUrl});

  @override
  State<_Testimonial3DCard> createState() => _Testimonial3DCardState();
}

class _Testimonial3DCardState extends State<_Testimonial3DCard> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: _hovering ? (Matrix4.identity()..translate(0.0, -8.0, 0.0)..scale(1.04)) : Matrix4.identity(),
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageUrl),
                  radius: 32,
                ),
                SizedBox(height: 16),
                Text(
                  widget.quote,
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  widget.name,
                  style: GoogleFonts.orbitron(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
                ),
                SizedBox(height: 8),
                Text(
                  widget.location,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 