import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../themes/modern_theme.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModernColors.deepGray,
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.poppins(
            color: ModernColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ModernColors.darkGray,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Admin Dashboard - Coming Soon',
          style: GoogleFonts.poppins(
            color: ModernColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
} 