import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../mock_data.dart';

class PackDetailScreen extends StatelessWidget {
  final int packId;
  const PackDetailScreen({super.key, required this.packId});

  @override
  Widget build(BuildContext context) {
    final pack = (packId > 0 && packId <= mockPacks.length) ? mockPacks[packId - 1] : null;
    if (pack == null) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Navbar(),
        ),
        body: Center(
          child: Text(
            'Pack not found',
            style: GoogleFonts.poppins(fontSize: 24, color: Colors.deepPurple, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Navbar(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              Text(
                pack['title'],
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  pack['image'],
                  height: 220,
                  width: 340,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                pack['desc'],
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.deepPurple.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                pack['price'],
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent[700],
                ),
              ),
              if (pack['offer'] != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.tealAccent.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    pack['offer'],
                    style: GoogleFonts.poppins(
                      color: Colors.tealAccent[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  foregroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                  textStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/confirmation'),
                child: const Text('Reserve Now'),
              ),
              const SizedBox(height: 48),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
