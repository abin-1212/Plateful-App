import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  static const Color primary = Color(0xFF6C3EF4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side: Animated Hero with Lottie and AnimatedText
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary, Color(0xFF181A2A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(
                    opacity: 0.12,
                    child: Image.network(
                      'https://svgshare.com/i/13kA.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'pla',
                                style: GoogleFonts.orbitron(
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 16,
                                      color: Colors.tealAccent.withOpacity(0.7),
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    't',
                                    style: GoogleFonts.orbitron(
                                      fontSize: 56,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    child: Icon(
                                      Icons.restaurant,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'eful',
                                style: GoogleFonts.orbitron(
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Container(
                            width: 320,
                            child: const Divider(
                              color: Colors.white,
                              thickness: 3,
                            ),
                          ),
                          const SizedBox(height: 24),
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                "India's first\nsurplus Food Marketspace",
                                textStyle: GoogleFonts.orbitron(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2,
                                ),
                                speed: Duration(milliseconds: 40),
                              ),
                            ],
                            isRepeatingAnimation: false,
                          ),
                          const SizedBox(height: 32),
                          Lottie.network(
                            'https://assets10.lottiefiles.com/packages/lf20_2ks3pjua.json',
                            height: 120,
                            repeat: true,
                            animate: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Side: Glassmorphic/Neumorphic Form
          Expanded(
            flex: 3,
            child: Center(
              child: GlassContainer.clearGlass(
                width: 500,
                height: 600, // Added height for SignupScreen glass container
                borderRadius: BorderRadius.circular(32),
                blur: 18,
                borderWidth: 2,
                borderColor: Colors.white.withOpacity(0.18),
                elevation: 12,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.18),
                    Colors.deepPurple.withOpacity(0.12),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register Your Business",
                        style: GoogleFonts.orbitron(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          shadows: [
                            Shadow(
                              blurRadius: 12,
                              color: Colors.tealAccent.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Enter your email and password to register",
                        style: GoogleFonts.orbitron(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Neumorphic(
                        style: NeumorphicStyle(
                          depth: 6,
                          intensity: 0.7,
                          color: Colors.white.withOpacity(0.95),
                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: GoogleFonts.orbitron(),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Neumorphic(
                        style: NeumorphicStyle(
                          depth: 6,
                          intensity: 0.7,
                          color: Colors.white.withOpacity(0.95),
                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                        ),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: GoogleFonts.orbitron(),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Neumorphic(
                        style: NeumorphicStyle(
                          depth: 6,
                          intensity: 0.7,
                          color: Colors.white.withOpacity(0.95),
                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                        ),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            labelStyle: GoogleFonts.orbitron(),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _GlowingButton(
                        label: "Sign Up",
                        onPressed: () {},
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              "Already have an account? Login",
                              style: GoogleFonts.orbitron(
                                color: Color(0xFF6C3EF4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
          child: Text(widget.label, style: GoogleFonts.orbitron(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
} 