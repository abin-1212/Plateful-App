import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(),
            _DownloadHeader(isMobile: isMobile),
            _DownloadContent(isMobile: isMobile),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class _DownloadHeader extends StatelessWidget {
  final bool isMobile;
  const _DownloadHeader({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 64,
        vertical: isMobile ? 48 : 72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Get the Plateful App',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w800,
              fontSize: isMobile ? 32 : 44,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          Text(
            'Order curated food packs anytime, anywhere. Download Plateful for Android and iOS.',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple.withOpacity(0.8),
              fontWeight: FontWeight.w500,
              fontSize: isMobile ? 16 : 20,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DownloadContent extends StatelessWidget {
  final bool isMobile;
  const _DownloadContent({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 64,
        vertical: isMobile ? 32 : 48,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _AppBadges(isMobile: true),
                const SizedBox(height: 32),
                _QRCode(isMobile: true),
                const SizedBox(height: 32),
                _DownloadDescription(isMobile: true),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 4, child: _AppBadges(isMobile: false)),
                const SizedBox(width: 48),
                Expanded(flex: 3, child: _QRCode(isMobile: false)),
                const SizedBox(width: 48),
                Expanded(flex: 5, child: _DownloadDescription(isMobile: false)),
              ],
            ),
    );
  }
}

class _AppBadges extends StatelessWidget {
  final bool isMobile;
  const _AppBadges({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_Store_badge_EN.svg',
            height: isMobile ? 54 : 64,
          ),
        ),
        const SizedBox(height: 18),
        GestureDetector(
          onTap: () {},
          child: Image.network(
            'https://developer.apple.com/assets/elements/badges/download-on-the-app-store.svg',
            height: isMobile ? 54 : 64,
          ),
        ),
      ],
    );
  }
}

class _QRCode extends StatelessWidget {
  final bool isMobile;
  const _QRCode({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.08),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Image.network(
        'https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=https://plateful.com',
        height: isMobile ? 120 : 180,
        width: isMobile ? 120 : 180,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _DownloadDescription extends StatelessWidget {
  final bool isMobile;
  const _DownloadDescription({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Text(
      'With the Plateful app, you can browse, order, and track curated food packs from top brands, all in one place. Enjoy exclusive app-only offers and a seamless ordering experience on Android and iOS.',
      style: GoogleFonts.poppins(
        color: Colors.deepPurple.withOpacity(0.8),
        fontWeight: FontWeight.w400,
        fontSize: isMobile ? 15 : 18,
        height: 1.6,
      ),
      textAlign: isMobile ? TextAlign.center : TextAlign.left,
    );
  }
} 