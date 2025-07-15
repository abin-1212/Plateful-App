import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                          'Plateful FAQ',
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
                          'Frequently Asked Questions about Plateful.',
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
          // FAQ Content Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Questions & Answers',
                  style: GoogleFonts.orbitron(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                SizedBox(height: 16),
                _FAQ3DCard(
                  question: 'What is Plateful?',
                  answer: 'Plateful is India’s first food surplus marketplace.',
                ),
                SizedBox(height: 24),
                _FAQ3DCard(
                  question: 'How does Plateful work?',
                  answer: 'We connect restaurants and customers to reduce food waste.',
                ),
                // Add more FAQ items as needed
              ],
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

class _FAQ3DCard extends StatefulWidget {
  final String question;
  final String answer;
  const _FAQ3DCard({required this.question, required this.answer});

  @override
  State<_FAQ3DCard> createState() => _FAQ3DCardState();
}

class _FAQ3DCardState extends State<_FAQ3DCard> {
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.question,
                  style: GoogleFonts.orbitron(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.deepPurple),
                ),
                SizedBox(height: 8),
                Text(
                  widget.answer,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 