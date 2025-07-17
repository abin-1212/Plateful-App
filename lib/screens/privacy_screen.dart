import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Column(
        children: [
          Navbar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 18 : 64,
                  vertical: isMobile ? 32 : 64,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: isMobile ? 26 : 36,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Your privacy is important to us. This privacy policy explains how Plateful collects, uses, and protects your information.\n\nWe only collect information necessary to provide our services. We do not share your data with third parties except as required by law.\n\nBy using Plateful, you consent to this policy. For any questions, contact us at support@plateful.com.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: isMobile ? 15 : 18,
                        color: Colors.deepPurple.withOpacity(0.85),
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
} 