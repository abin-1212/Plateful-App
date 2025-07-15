import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: GlassContainer.clearGlass(
        width: 1200, // Added width for Navbar glass container
        height: 80, // Added height for Navbar glass container
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Row(
            children: [
              // Futuristic Logo with Neon Glow
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [
                      Colors.deepPurpleAccent,
                      Colors.tealAccent,
                      Colors.greenAccent,
                    ],
                  ).createShader(bounds);
                },
                child: Text(
                  'plateful',
                  style: GoogleFonts.orbitron(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 16,
                        color: Colors.tealAccent.withOpacity(0.7),
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ...[
                _NavButton('Home', '/'),
                _NavButton('About', '/about'),
                _NavButton('Blog', '/blog'),
                _NavButton('Reviews', '/reviews'),
                _NavButton('Contact', '/contact'),
                _NavButton('FAQ', '/faq'),
                _NavButton('Careers', '/careers'),
                _NavButton('Download', '/download'),
                _NavButton('Login', '/login'),
                _NavButton('Sign Up', '/signup'),
              ].map((btn) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: btn,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final String route;
  const _NavButton(this.label, this.route);

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
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
          borderRadius: BorderRadius.circular(12),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: Colors.tealAccent.withOpacity(0.4),
                    blurRadius: 16,
                    spreadRadius: 1,
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
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.orbitron(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          onPressed: () => Navigator.pushNamed(context, widget.route),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 220),
            style: GoogleFonts.orbitron(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _hovering ? Colors.tealAccent : Colors.white,
              letterSpacing: 1.2,
              shadows: _hovering
                  ? [
                      Shadow(
                        blurRadius: 12,
                        color: Colors.tealAccent.withOpacity(0.7),
                        offset: Offset(0, 0),
                      ),
                    ]
                  : [],
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
} 