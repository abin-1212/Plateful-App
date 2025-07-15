import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

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
                          'Contact Plateful',
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
                          'We would love to hear from you! Fill out the form below to get in touch.',
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
          // Contact Form Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
            child: _Contact3DCard(),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

class _Contact3DCard extends StatefulWidget {
  @override
  State<_Contact3DCard> createState() => _Contact3DCardState();
}

class _Contact3DCardState extends State<_Contact3DCard> {
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
                  'Contact Form',
                  style: GoogleFonts.orbitron(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                SizedBox(height: 16),
                // Placeholder for contact form
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Contact form goes here',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 