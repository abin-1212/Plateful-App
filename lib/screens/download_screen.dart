import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

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
                          'Download Plateful App',
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
                          'Get Plateful on your device and start saving today!',
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
                    SizedBox(height: 32),
                    Row(
                      children: [
                        _GlowingButton(
                          icon: Icons.android,
                          label: 'Get it on Google Play',
                          onPressed: () {},
                        ),
                        SizedBox(width: 16),
                        _GlowingButton(
                          icon: Icons.apple,
                          label: 'Download on the App Store',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Download Content Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
            child: _Download3DCard(),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

class _GlowingButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  const _GlowingButton({required this.icon, required this.label, required this.onPressed});

  @override
  State<_GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<_GlowingButton> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: Colors.tealAccent.withOpacity(0.5),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ]
              : [],
          gradient: _hovering
              ? LinearGradient(
                  colors: [
                    Colors.deepPurpleAccent.withOpacity(0.7),
                    Colors.tealAccent.withOpacity(0.7),
                  ],
                )
              : null,
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(_hovering ? 0.85 : 0.7),
            foregroundColor: const Color(0xFF6C3EF4),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: _hovering ? 12 : 4,
            shadowColor: Colors.tealAccent.withOpacity(0.5),
          ),
          onPressed: widget.onPressed,
          icon: Icon(widget.icon),
          label: Text(widget.label),
        ),
      ),
    );
  }
}

class _Download3DCard extends StatefulWidget {
  @override
  State<_Download3DCard> createState() => _Download3DCardState();
}

class _Download3DCardState extends State<_Download3DCard> {
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
                  'How to Download',
                  style: GoogleFonts.orbitron(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
                SizedBox(height: 16),
                Text(
                  '1. Click the button above for your device.\n2. Follow the instructions to install Plateful.\n3. Sign up and start saving!',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 