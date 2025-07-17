import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class PackCardWidget extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String? offer;
  final VoidCallback? onViewDetails;

  const PackCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    this.offer,
    this.onViewDetails,
  });

  @override
  State<PackCardWidget> createState() => _PackCardWidgetState();
}

class _PackCardWidgetState extends State<PackCardWidget> {
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
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _hovering
                  ? Colors.tealAccent.withOpacity(0.25)
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
        width: isMobile ? double.infinity : 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.network(
                widget.imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 160,
                  color: Colors.grey[200],
                  child: const Icon(Icons.fastfood, size: 48, color: Colors.tealAccent),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.poppins(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: GoogleFonts.poppins(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        widget.price,
                        style: GoogleFonts.poppins(
                          color: Colors.tealAccent[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      if (widget.offer != null) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.offer!,
                            style: GoogleFonts.poppins(
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent,
                        foregroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      onPressed: widget.onViewDetails,
                      child: const Text('View Details'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 