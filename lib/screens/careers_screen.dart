import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class CareersScreen extends StatelessWidget {
  const CareersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(),
            _CareersHeader(isMobile: isMobile),
            _CareersIntro(isMobile: isMobile),
            _OpenPositions(isMobile: isMobile),
            _BenefitsSection(isMobile: isMobile),
            _CareersCTA(isMobile: isMobile),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class _CareersHeader extends StatelessWidget {
  final bool isMobile;
  const _CareersHeader({required this.isMobile});

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
            'Careers at Plateful',
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
            'Join our mission to revolutionize food experiences.',
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

class _CareersIntro extends StatelessWidget {
  final bool isMobile;
  const _CareersIntro({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 64,
        vertical: isMobile ? 32 : 48,
      ),
      child: Text(
        'At Plateful, we’re passionate about making curated food packs accessible to everyone. We’re a team of food lovers, technologists, and dreamers working together to build something extraordinary. If you’re looking to make an impact and grow your career, you’ll fit right in!',
        style: GoogleFonts.poppins(
          color: Colors.deepPurple.withOpacity(0.8),
          fontWeight: FontWeight.w400,
          fontSize: isMobile ? 15 : 18,
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _OpenPositions extends StatelessWidget {
  final bool isMobile;
  const _OpenPositions({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final positions = [
      {
        'title': 'Flutter Developer',
        'location': 'Remote, India',
        'type': 'Full-time',
        'desc': 'Build beautiful, scalable mobile and web apps with Flutter. 2+ years experience required.'
      },
      {
        'title': 'UI/UX Designer',
        'location': 'Bangalore, India',
        'type': 'Full-time',
        'desc': 'Design pixel-perfect, user-centric interfaces for web and mobile.'
      },
      {
        'title': 'Growth Marketer',
        'location': 'Remote, India',
        'type': 'Contract',
        'desc': 'Drive user acquisition and engagement through creative campaigns.'
      },
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 64,
        vertical: isMobile ? 32 : 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Open Positions',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 22 : 28,
            ),
          ),
          const SizedBox(height: 32),
          ...positions.map((p) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: _PositionCard(position: p, isMobile: isMobile),
              )),
        ],
      ),
    );
  }
}

class _PositionCard extends StatelessWidget {
  final Map<String, String> position;
  final bool isMobile;
  const _PositionCard({required this.position, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: 24,
        horizontal: isMobile ? 16 : 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            position['title']!,
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: isMobile ? 18 : 22,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.tealAccent, size: 18),
              const SizedBox(width: 6),
              Text(
                position['location']!,
                style: GoogleFonts.poppins(
                  color: Colors.deepPurple.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 18),
              Icon(Icons.work, color: Colors.tealAccent, size: 18),
              const SizedBox(width: 6),
              Text(
                position['type']!,
                style: GoogleFonts.poppins(
                  color: Colors.deepPurple.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            position['desc']!,
            style: GoogleFonts.poppins(
              color: Colors.deepPurple.withOpacity(0.8),
              fontWeight: FontWeight.w400,
              fontSize: isMobile ? 14 : 16,
            ),
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              onPressed: () {},
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitsSection extends StatelessWidget {
  final bool isMobile;
  const _BenefitsSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final benefits = [
      (Icons.favorite, 'Work with purpose'),
      (Icons.public, 'Remote-friendly'),
      (Icons.school, 'Learning & growth'),
      (Icons.emoji_events, 'Recognition & rewards'),
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 64,
        vertical: isMobile ? 32 : 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Why Join Plateful?',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 22 : 28,
            ),
          ),
          const SizedBox(height: 32),
          isMobile
              ? Column(
                  children: benefits
                      .map((b) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: _BenefitCard(icon: b.$1, title: b.$2),
                          ))
                      .toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: benefits
                      .map((b) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: _BenefitCard(icon: b.$1, title: b.$2),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const _BenefitCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.tealAccent, size: 32),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _CareersCTA extends StatelessWidget {
  final bool isMobile;
  const _CareersCTA({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 32),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 64,
        vertical: isMobile ? 32 : 48,
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
            'Ready to join Plateful?',
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
            'Send your resume to careers@plateful.com or apply to any open position above.',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple.withOpacity(0.85),
              fontWeight: FontWeight.w500,
              fontSize: isMobile ? 15 : 18,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ],
      ),
    );
  }
} 