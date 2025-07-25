import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/modern_card.dart';
import '../widgets/modern_section.dart';
import '../constants/app_constants.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return ModernScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ModernSection(
              child: _FAQHeader(isMobile: isMobile),
            ),
            ModernSection(
              child: _FAQList(isMobile: isMobile),
            ),
            ModernFooter(),
          ],
        ),
      ),
    );
  }
}

class _FAQHeader extends StatelessWidget {
  final bool isMobile;
  const _FAQHeader({required this.isMobile});

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
            'Frequently Asked Questions',
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
            'Find answers to common questions about Plateful.',
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

class _FAQList extends StatefulWidget {
  final bool isMobile;
  const _FAQList({required this.isMobile});

  @override
  State<_FAQList> createState() => _FAQListState();
}

class _FAQListState extends State<_FAQList> {
  int? _expandedIndex;

  final faqs = [
    {
      'q': 'What is Plateful?',
      'a': 'Plateful is a platform for discovering, ordering, and enjoying curated food packs from top brands, delivered fresh to your doorstep.'
    },
    {
      'q': 'How do I order a food pack?',
      'a': 'Browse our featured packs, add your favorites to cart, and checkout securely. Your food will be delivered fresh and fast.'
    },
    {
      'q': 'Is Plateful available in my city?',
      'a': 'We are rapidly expanding! Enter your location on the home page to check availability.'
    },
    {
      'q': 'How do I become a partner?',
      'a': 'Visit our Partner page and fill out the form. Our team will get in touch with you soon.'
    },
    {
      'q': 'What payment methods are accepted?',
      'a': 'We accept all major credit/debit cards, UPI, and popular wallets.'
    },
    {
      'q': 'How do I contact support?',
      'a': 'You can reach us via the Contact page or email us at support@plateful.com.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 8 : 64,
        vertical: widget.isMobile ? 32 : 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...faqs.asMap().entries.map((entry) {
            final i = entry.key;
            final faq = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                elevation: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => setState(() => _expandedIndex = _expandedIndex == i ? null : i),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.isMobile ? 18 : 32,
                      vertical: widget.isMobile ? 18 : 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                faq['q']!,
                                style: GoogleFonts.poppins(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w600,
                                  fontSize: widget.isMobile ? 16 : 18,
                                ),
                              ),
                            ),
                            Icon(
                              _expandedIndex == i ? Icons.expand_less : Icons.expand_more,
                              color: Colors.tealAccent,
                              size: 28,
                            ),
                          ],
                        ),
                        AnimatedCrossFade(
                          firstChild: const SizedBox.shrink(),
                          secondChild: Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Text(
                              faq['a']!,
                              style: GoogleFonts.poppins(
                                color: Colors.deepPurple.withOpacity(0.8),
                                fontWeight: FontWeight.w400,
                                fontSize: widget.isMobile ? 14 : 16,
                                height: 1.5,
                              ),
                            ),
                          ),
                          crossFadeState: _expandedIndex == i ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 250),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
} 