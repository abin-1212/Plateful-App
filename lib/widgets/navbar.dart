import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF6C3EF4),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: Row(
        children: [
          Text(
            'plateful',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
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
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final String route;
  const _NavButton(this.label, this.route);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
} 