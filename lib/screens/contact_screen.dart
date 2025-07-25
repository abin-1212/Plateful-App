import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/modern_card.dart';
import '../widgets/modern_section.dart';
import '../constants/app_constants.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return ModernScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ModernSection(
              child: _ContactHeader(isMobile: isMobile),
            ),
            ModernSection(
              child: _ContactContent(isMobile: isMobile),
            ),
            ModernFooter(),
          ],
        ),
      ),
    );
  }
}

class _ContactHeader extends StatelessWidget {
  final bool isMobile;
  const _ContactHeader({required this.isMobile});

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
            'Contact Us',
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
            'We’d love to hear from you! Reach out with questions, feedback, or partnership inquiries.',
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

class _ContactContent extends StatelessWidget {
  final bool isMobile;
  const _ContactContent({required this.isMobile});

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
              children: [
                _ContactForm(isMobile: true),
                const SizedBox(height: 32),
                _ContactInfo(isMobile: true),
                const SizedBox(height: 32),
                _MapPlaceholder(isMobile: true),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _ContactForm(isMobile: false)),
                const SizedBox(width: 48),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      _ContactInfo(isMobile: false),
                      const SizedBox(height: 32),
                      _MapPlaceholder(isMobile: false),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  final bool isMobile;
  const _ContactForm({required this.isMobile});

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _submitting = false;
  String? _feedback;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _feedback = null;
    });
    await Future.delayed(const Duration(seconds: 2)); // Simulate network
    setState(() {
      _submitting = false;
      _feedback = 'Thank you for contacting us! We will get back to you soon.';
    });
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: widget.isMobile ? 18 : 32,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Send us a message',
              style: GoogleFonts.poppins(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w700,
                fontSize: widget.isMobile ? 20 : 24,
              ),
            ),
            const SizedBox(height: 18),
            _buildTextField(_nameController, 'Full Name',
                validator: (v) => v == null || v.isEmpty ? 'Enter your name' : null),
            const SizedBox(height: 12),
            _buildTextField(_emailController, 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null),
            const SizedBox(height: 12),
            _buildTextField(_messageController, 'Message',
                maxLines: 4,
                validator: (v) => v == null || v.isEmpty ? 'Enter a message' : null),
            const SizedBox(height: 22),
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
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                onPressed: _submitting ? null : _submit,
                child: _submitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Send'),
              ),
            ),
            if (_feedback != null) ...[
              const SizedBox(height: 18),
              Text(
                _feedback!,
                style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType? keyboardType, int maxLines = 1, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: GoogleFonts.poppins(
        color: Colors.deepPurple,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
          color: Colors.deepPurple.withOpacity(0.7),
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.tealAccent.withOpacity(0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.tealAccent.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.tealAccent.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.tealAccent, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  final bool isMobile;
  const _ContactInfo({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: isMobile ? 18 : 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 20 : 24,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Icon(Icons.email, color: Colors.tealAccent, size: 22),
              const SizedBox(width: 10),
              Text(
                'support@plateful.com',
                style: GoogleFonts.poppins(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.tealAccent, size: 22),
              const SizedBox(width: 10),
              Text(
                '+91 98765 43210',
                style: GoogleFonts.poppins(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.tealAccent, size: 22),
              const SizedBox(width: 10),
              Text(
                'Bangalore, India',
                style: GoogleFonts.poppins(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  final bool isMobile;
  const _MapPlaceholder({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? 180 : 240,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.tealAccent.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.08),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.white54, BlendMode.lighten),
        ),
      ),
      child: Center(
        child: Text(
          'Our Location',
          style: GoogleFonts.poppins(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w600,
            fontSize: isMobile ? 18 : 22,
            shadows: [
              Shadow(
                color: Colors.white.withOpacity(0.7),
                blurRadius: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 