import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CTABanner extends StatelessWidget {
  final String headline;
  final String subheadline;
  final String buttonText;
  final VoidCallback? onPressed;

  const CTABanner({
    super.key,
    required this.headline,
    required this.subheadline,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 0),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32 : 48,
        horizontal: isMobile ? 18 : 48,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.tealAccent.withOpacity(0.85),
            Colors.deepPurpleAccent.withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.10),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            headline,
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w800,
              fontSize: isMobile ? 22 : 28,
              letterSpacing: 1.1,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
          const SizedBox(height: 12),
          Text(
            subheadline,
            style: GoogleFonts.poppins(
              color: Colors.deepPurple.withOpacity(0.85),
              fontWeight: FontWeight.w500,
              fontSize: isMobile ? 15 : 18,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
          const SizedBox(height: 24),
          Align(
            alignment: isMobile ? Alignment.center : Alignment.centerLeft,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
} 