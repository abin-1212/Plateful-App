import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
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
                                style: GoogleFonts.poppins(
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
                                    style: GoogleFonts.poppins(
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
                                style: GoogleFonts.poppins(
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
                                textStyle: GoogleFonts.poppins(
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
                height: 520, // Added height for RegisterScreen glass container
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
                        style: GoogleFonts.poppins(
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
                        style: GoogleFonts.poppins(
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
                            labelStyle: GoogleFonts.poppins(),
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
                            labelStyle: GoogleFonts.poppins(),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _GlowingButton(
                        label: "Continue",
                        onPressed: () {},
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(Icons.login, color: Colors.redAccent),
                            label: Text('Sign up with Google', style: GoogleFonts.poppins()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.deepPurple,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () async {
                              await signInWithGoogle(context);
                            },
                          ),
                          SizedBox(width: 12),
                          ElevatedButton.icon(
                            icon: Icon(Icons.phone, color: Colors.green),
                            label: Text('Phone', style: GoogleFonts.poppins()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.deepPurple,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Phone authentication coming soon!')),
                              );
                            },
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    'Welcome Back to Plateful',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Login to your account',
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
                    child: Column(
                      children: [
                        _LoginForm(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(Icons.login, color: Colors.redAccent),
                              label: Text('Sign in with Google', style: GoogleFonts.poppins()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.deepPurple,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () async {
                                await signInWithGoogle(context);
                              },
                            ),
                            SizedBox(width: 12),
                            ElevatedButton.icon(
                              icon: Icon(Icons.phone, color: Colors.green),
                              label: Text('Phone', style: GoogleFonts.poppins()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.deepPurple,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Phone authentication coming soon!')),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    child: Text(
                      'Don’t have an account? Sign Up',
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

class _LoginForm extends StatefulWidget {
  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _email!,
                      password: _password!,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login successful!')),
                    );
                    // TODO: Navigate to home or dashboard
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login failed: $e')),
                    );
                  }
                }
              },
              child: Text('Login', style: GoogleFonts.poppins(fontSize: 18)),
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

// Helper for Google Sign-In
Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Google sign-in failed: $e')));
    return null;
  }
}
