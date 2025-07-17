import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:plateful/theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 32),
      child: SizedBox(
        height: isMobile ? 340 : 220, // Fixed height to prevent infinite height error
        child: GlassContainer.clearGlass(
          width: double.infinity,
          borderRadius: BorderRadius.circular(0),
          blur: 16,
          borderWidth: 0,
          elevation: 0,
          borderColor: Colors.transparent, // Fix for web: must not be null
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.10),
              Colors.deepPurple.withOpacity(0.08),
            ],
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _LogoTagline(),
                      const SizedBox(height: 24),
                      _FooterLinks(isMobile: true),
                      const SizedBox(height: 20),
                      _FooterSocialRow(),
                      const SizedBox(height: 20),
                      _CopyrightRow(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 2, child: _LogoTagline()),
                      Expanded(flex: 3, child: _FooterLinks(isMobile: false)),
                      Expanded(flex: 2, child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _FooterSocialRow(),
                          const SizedBox(height: 16),
                          _CopyrightRow(),
                        ],
                      )),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _LogoTagline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Colors.tealAccent,
          child: Text(
            'P',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plateful',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              'A Plenti-inspired food experience',
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FooterLinks extends StatelessWidget {
  final bool isMobile;
  const _FooterLinks({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final links = [
      {'label': 'Home', 'route': '/'},
      {'label': 'About', 'route': '/about'},
      {'label': 'Blog', 'route': '/blog'},
      {'label': 'Careers', 'route': '/careers'},
      {'label': 'FAQ', 'route': '/faq'},
      {'label': 'Contact', 'route': '/contact'},
      {'label': 'Download', 'route': '/download'},
    ];
    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      spacing: 24,
      runSpacing: 12,
      children: links.map((link) {
        return GestureDetector(
          onTap: () => context.go(link['route']!),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              link['label']!,
              style: GoogleFonts.poppins(
                color: Colors.tealAccent,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: Colors.tealAccent.withOpacity(0.5),
                decorationThickness: 1.5,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _FooterSocialRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _FooterIcon(icon: Icons.facebook, url: 'https://facebook.com'),
        const SizedBox(width: 16),
        _FooterIcon(icon: Icons.alternate_email, url: 'https://twitter.com'),
        const SizedBox(width: 16),
        _FooterIcon(icon: Icons.camera_alt, url: 'https://instagram.com'),
        const SizedBox(width: 16),
        _FooterIcon(icon: Icons.email, url: 'mailto:info@plateful.com'),
      ],
    );
  }
}

class _CopyrightRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.copyright, color: Colors.tealAccent, size: 18),
        const SizedBox(width: 8),
        Text(
          '2025 Plateful. All rights reserved.',
          style: GoogleFonts.poppins(
            color: Colors.white.withOpacity(0.85),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.1,
          ),
        ),
      ],
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