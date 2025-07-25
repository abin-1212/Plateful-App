import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/modern_card.dart';
import '../widgets/modern_section.dart';
import '../constants/app_constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return ModernScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ModernSection(
              child: _AboutHeader(isMobile: isMobile),
            ),
            ModernSection(
              child: _AboutStory(isMobile: isMobile),
            ),
            ModernSection(
              child: _AboutMissionVision(isMobile: isMobile),
            ),
            ModernSection(
              child: _AboutValues(isMobile: isMobile),
            ),
            ModernSection(
              child: _AboutTeam(isMobile: isMobile),
            ),
            ModernFooter(),
          ],
        ),
      ),
    );
  }
}

class _AboutHeader extends StatelessWidget {
  final bool isMobile;
  const _AboutHeader({required this.isMobile});

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
            'About Plateful',
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
            'Our story, mission, and the team behind your favorite food packs.',
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

class _AboutStory extends StatelessWidget {
  final bool isMobile;
  const _AboutStory({required this.isMobile});

  @override
  Widget build(BuildContext context) {
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
            'Our Story',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 22 : 28,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Plateful was founded with a simple idea: to make curated, high-quality food packs accessible and convenient for everyone. Inspired by the best of food tech and a passion for great meals, we set out to build a platform that brings together top brands and food lovers. Today, Plateful is your go-to destination for discovering, ordering, and enjoying delicious food packs, delivered fresh to your doorstep.',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple.withOpacity(0.8),
              fontWeight: FontWeight.w400,
              fontSize: isMobile ? 15 : 18,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AboutMissionVision extends StatelessWidget {
  final bool isMobile;
  const _AboutMissionVision({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 64,
        vertical: isMobile ? 32 : 48,
      ),
      child: isMobile
          ? Column(
              children: [
                _MissionCard(isMobile: true),
                const SizedBox(height: 24),
                _VisionCard(isMobile: true),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: _MissionCard(isMobile: false)),
                const SizedBox(width: 32),
                Expanded(child: _VisionCard(isMobile: false)),
              ],
            ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  final bool isMobile;
  const _MissionCard({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 18 : 32),
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
      child: Column(
        children: [
          Icon(Icons.flag, color: Colors.tealAccent, size: 38),
          const SizedBox(height: 16),
          Text(
            'Our Mission',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: isMobile ? 18 : 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'To make high-quality, curated food packs accessible, affordable, and convenient for everyone.',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple.withOpacity(0.8),
              fontWeight: FontWeight.w400,
              fontSize: isMobile ? 14 : 16,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _VisionCard extends StatelessWidget {
  final bool isMobile;
  const _VisionCard({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 18 : 32),
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
      child: Column(
        children: [
          Icon(Icons.visibility, color: Colors.tealAccent, size: 38),
          const SizedBox(height: 16),
          Text(
            'Our Vision',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: isMobile ? 18 : 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'To be the most trusted platform for discovering and enjoying food packs, connecting people with the best brands and experiences.',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple.withOpacity(0.8),
              fontWeight: FontWeight.w400,
              fontSize: isMobile ? 14 : 16,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AboutValues extends StatelessWidget {
  final bool isMobile;
  const _AboutValues({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final values = [
      (Icons.emoji_emotions, 'Customer Delight'),
      (Icons.verified, 'Quality First'),
      (Icons.eco, 'Sustainability'),
      (Icons.group, 'Community'),
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
            'Our Values',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 22 : 28,
            ),
          ),
          const SizedBox(height: 32),
          isMobile
              ? Column(
                  children: values
                      .map((v) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: _ValueCard(icon: v.$1, title: v.$2),
                          ))
                      .toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: values
                      .map((v) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: _ValueCard(icon: v.$1, title: v.$2),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const _ValueCard({required this.icon, required this.title});

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

class _AboutTeam extends StatelessWidget {
  final bool isMobile;
  const _AboutTeam({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final team = [
      {
        'name': 'Aarav Mehta',
        'role': 'Co-Founder & CEO',
        'img': 'https://randomuser.me/api/portraits/men/11.jpg',
      },
      {
        'name': 'Saanvi Sharma',
        'role': 'Co-Founder & COO',
        'img': 'https://randomuser.me/api/portraits/women/21.jpg',
      },
      {
        'name': 'Kabir Patel',
        'role': 'CTO',
        'img': 'https://randomuser.me/api/portraits/men/31.jpg',
      },
      {
        'name': 'Meera Iyer',
        'role': 'Head of Partnerships',
        'img': 'https://randomuser.me/api/portraits/women/41.jpg',
      },
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
            'Meet the Team',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 22 : 28,
            ),
          ),
          const SizedBox(height: 32),
          isMobile
              ? Column(
                  children: team
                      .map((member) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: _TeamCard(
                              name: member['name']!,
                              role: member['role']!,
                              img: member['img']!,
                            ),
                          ))
                      .toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: team
                      .map((member) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              child: _TeamCard(
                                name: member['name']!,
                                role: member['role']!,
                                img: member['img']!,
                              ),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  final String name;
  final String role;
  final String img;
  const _TeamCard({required this.name, required this.role, required this.img});

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
          CircleAvatar(
            backgroundImage: NetworkImage(img),
            radius: 36,
          ),
          const SizedBox(height: 14),
          Text(
            name,
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            role,
            style: GoogleFonts.poppins(
              color: Colors.deepPurple.withOpacity(0.7),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
} 