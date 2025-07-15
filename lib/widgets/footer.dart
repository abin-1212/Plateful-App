import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: GlassContainer.clearGlass(
        width: 800, // Added width for Footer glass container
        height: 120, // Added height for GlassContainer
        borderRadius: BorderRadius.circular(32),
        blur: 16,
        borderWidth: 2,
        borderColor: Colors.white.withOpacity(0.18),
        elevation: 8,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.12),
            Colors.deepPurple.withOpacity(0.10),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.copyright, color: Colors.tealAccent, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    '2025 Plateful. All rights reserved.',
                    style: GoogleFonts.orbitron(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FooterIcon(icon: Icons.facebook, url: 'https://facebook.com'),
                  const SizedBox(width: 16),
                  _FooterIcon(icon: Icons.alternate_email, url: 'https://twitter.com'), // Replaced Icons.twitter
                  const SizedBox(width: 16),
                  _FooterIcon(icon: Icons.camera_alt, url: 'https://instagram.com'), // Replaced Icons.instagram
                  const SizedBox(width: 16),
                  _FooterIcon(icon: Icons.email, url: 'mailto:info@plateful.com'),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 4,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [
                      Colors.tealAccent,
                      Colors.deepPurpleAccent,
                      Colors.greenAccent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.tealAccent.withOpacity(0.5),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  const _FooterIcon({required this.icon, required this.url});

  @override
  State<_FooterIcon> createState() => _FooterIconState();
}

class _FooterIconState extends State<_FooterIcon> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () {
          // You can use url_launcher for real links
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: Colors.tealAccent.withOpacity(0.5),
                      blurRadius: 16,
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
          child: Icon(
            widget.icon,
            color: _hovering ? Colors.tealAccent : Colors.white.withOpacity(0.85),
            size: 22,
          ),
        ),
      ),
    );
  }
} 