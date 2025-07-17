import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../mock_data.dart';

class PartnerFormWidget extends StatefulWidget {
  const PartnerFormWidget({super.key});

  @override
  State<PartnerFormWidget> createState() => _PartnerFormWidgetState();
}

class _PartnerFormWidgetState extends State<PartnerFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _businessController = TextEditingController();
  final _messageController = TextEditingController();
  bool _submitting = false;
  String? _feedback;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _businessController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _feedback = null;
    });
    try {
      await partnersCollection.add({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'business': _businessController.text,
        'message': _messageController.text,
        'createdAt': DateTime.now().toIso8601String(),
      });
      setState(() {
        _feedback = 'Thank you for reaching out! We will contact you soon.';
      });
      _formKey.currentState!.reset();
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _businessController.clear();
      _messageController.clear();
    } catch (e) {
      setState(() {
        _feedback = 'Submission failed: $e';
      });
    } finally {
      setState(() {
        _submitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: isMobile ? double.infinity : 420,
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
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
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Partner with Plateful',
                style: GoogleFonts.poppins(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              _buildTextField(_nameController, 'Full Name',
                  validator: (v) => v == null || v.isEmpty ? 'Enter your name' : null),
              const SizedBox(height: 12),
              _buildTextField(_emailController, 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null),
              const SizedBox(height: 12),
              _buildTextField(_phoneController, 'Phone',
                  keyboardType: TextInputType.phone,
                  validator: (v) => v == null || v.length < 8 ? 'Enter a valid phone' : null),
              const SizedBox(height: 12),
              _buildTextField(_businessController, 'Business Name',
                  validator: (v) => v == null || v.isEmpty ? 'Enter your business name' : null),
              const SizedBox(height: 12),
              _buildTextField(_messageController, 'Message',
                  maxLines: 3,
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
                      : const Text('Submit'),
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