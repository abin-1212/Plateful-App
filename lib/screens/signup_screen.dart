import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../mock_data.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  static const Color primary = Color(0xFF6C3EF4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Navbar(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FBFF), Color(0xFFE8ECF3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),
                  Text(
                    'Create Your Plateful Account',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Sign up to start saving on great food',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.tealAccent,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: 400,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: const Color(0xFF23244D),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.tealAccent.withOpacity(0.08),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: _SignupForm(),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: Text(
                      'Already have an account? Login',
                      style: GoogleFonts.poppins(
                        color: Colors.tealAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  const Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignupForm extends StatefulWidget {
  @override
  State<_SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<_SignupForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _email, _password;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: GoogleFonts.poppins(color: Colors.white70),
              filled: true,
              fillColor: const Color(0xFF181A2A),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
            style: GoogleFonts.poppins(color: Colors.white),
            validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
            onSaved: (value) => _name = value,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: GoogleFonts.poppins(color: Colors.white70),
              filled: true,
              fillColor: const Color(0xFF181A2A),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
            style: GoogleFonts.poppins(color: Colors.white),
            validator: (value) => value == null || !value.contains('@') ? 'Please enter a valid email' : null,
            onSaved: (value) => _email = value,
          ),
          const SizedBox(height: 16),
          TextFormField(
            obscureText: _obscure,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: GoogleFonts.poppins(color: Colors.white70),
              filled: true,
              fillColor: const Color(0xFF181A2A),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              suffixIcon: IconButton(
                icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off, color: Colors.tealAccent),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
            style: GoogleFonts.poppins(color: Colors.white),
            validator: (value) => value == null || value.length < 6 ? 'Password must be at least 6 characters' : null,
            onSaved: (value) => _password = value,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  try {
                    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _email!,
                      password: _password!,
                    );
                    await usersCollection.doc(userCredential.user!.uid).set({
                      'name': _name,
                      'email': _email,
                      'createdAt': DateTime.now().toIso8601String(),
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signup successful!')),
                    );
                    // TODO: Navigate to home or dashboard
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signup failed: $e')),
                    );
                  }
                }
              },
              child: Text('Sign Up', style: GoogleFonts.poppins(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}

// Glowing Button for micro-interaction
class _GlowingButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  const _GlowingButton({required this.label, required this.onPressed});
  @override
  State<_GlowingButton> createState() => _GlowingButtonState();
}
class _GlowingButtonState extends State<_GlowingButton> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: Colors.tealAccent.withOpacity(0.5),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ]
              : [],
          gradient: _hovering
              ? LinearGradient(
                  colors: [
                    Colors.deepPurpleAccent.withOpacity(0.7),
                    Colors.tealAccent.withOpacity(0.7),
                  ],
                )
              : null,
        ),
        transform: _hovering ? (Matrix4.identity()..translate(0.0, -8.0, 0.0)..scale(1.03)) : Matrix4.identity(),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(_hovering ? 0.85 : 0.7),
            foregroundColor: const Color(0xFF6C3EF4),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: _hovering ? 12 : 4,
            shadowColor: Colors.tealAccent.withOpacity(0.5),
          ),
          onPressed: widget.onPressed,
          child: Text(widget.label, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
} 