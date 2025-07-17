import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class TestimonialCard extends StatefulWidget {
  final String avatarUrl;
  final String name;
  final String testimonial;
  final int? rating; // 1-5 stars, optional

  const TestimonialCard({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.testimonial,
    this.rating,
  });

  @override
  State<TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<TestimonialCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _hovering
                  ? Colors.tealAccent.withOpacity(0.18)
                  : Colors.deepPurple.withOpacity(0.08),
              blurRadius: _hovering ? 24 : 12,
              spreadRadius: 1,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: _hovering
                ? Colors.tealAccent.withOpacity(0.5)
                : Colors.transparent,
            width: 2,
          ),
        ),
        width: isMobile ? double.infinity : 340,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(widget.avatarUrl),
                backgroundColor: Colors.tealAccent.withOpacity(0.2),
                onBackgroundImageError: (_, __) {},
                child: widget.avatarUrl.isEmpty
                    ? Icon(Icons.person, size: 36, color: Colors.tealAccent)
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                widget.name,
                style: GoogleFonts.poppins(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              if (widget.rating != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) => Icon(
                        i < widget.rating!
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      )),
                ),
              if (widget.rating != null) const SizedBox(height: 10),
              Text(
                '“${widget.testimonial}”',
                style: GoogleFonts.poppins(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 