import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Navbar(),
            // Hero Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: GlassContainer.clearGlass(
                width: 900, // Added width for hero section glass container
                height: 220, // Added height for hero section glass container
                borderRadius: BorderRadius.circular(32),
                blur: 16,
                borderWidth: 2,
                borderColor: Colors.white.withOpacity(0.18),
                elevation: 8,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.18),
                    Colors.deepPurple.withOpacity(0.12),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                'About Plateful',
                                textStyle: GoogleFonts.orbitron(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 16,
                                      color: Colors.tealAccent.withOpacity(0.7),
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                speed: Duration(milliseconds: 40),
                              ),
                            ],
                            isRepeatingAnimation: false,
                          ),
                          SizedBox(height: 16),
                          AnimatedTextKit(
                            animatedTexts: [
                              FadeAnimatedText(
                                "India's First Food Surplus Marketplace",
                                textStyle: GoogleFonts.orbitron(
                                  fontSize: 24,
                                  color: Colors.tealAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                                duration: Duration(milliseconds: 1800),
                              ),
                            ],
                            isRepeatingAnimation: false,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: GlassContainer.clearGlass(
                          width: 220, // Added width for Lottie glass container
                          height: 180, // Added height for Lottie glass container
                          borderRadius: BorderRadius.circular(24),
                          blur: 12,
                          borderWidth: 2,
                          borderColor: Colors.white.withOpacity(0.18),
                          elevation: 6,
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.10),
                              Colors.deepPurple.withOpacity(0.10),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Lottie.network(
                              'https://assets10.lottiefiles.com/packages/lf20_2ks3pjua.json',
                              height: 140,
                              repeat: true,
                              animate: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Mission Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        depth: 12,
                        intensity: 0.7,
                        surfaceIntensity: 0.25,
                        color: Colors.white.withOpacity(0.95),
                        shadowLightColor: Colors.tealAccent,
                        shadowDarkColor: Colors.deepPurple,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Our Mission',
                              style: GoogleFonts.orbitron(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'At Plateful, we connect restaurants, bakeries, supermarkets, and customers on one unified platform. Our mission is to make food accessible and affordable for everyone, while reducing food waste and supporting local businesses.',
                              style: TextStyle(fontSize: 18, color: Colors.black87),
                            ),
                            SizedBox(height: 32),
                            Text(
                              'How Plateful Works',
                              style: GoogleFonts.orbitron(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Discover unbeatable deals on surplus meals, baked goods, and groceries. Reserve surprise bags, pick up at your convenience, and enjoy great food at a fraction of the cost!\n\n1. Download & Explore: Download the Plateful app and sign up to get started. Discover a variety of packs and listings from nearby restaurants and supermarkets.\n2. Reserve a Surprise Bag: Choose a surprise bag from your favorite local stores and reserve it at a discounted price.\n3. Pick Up & Enjoy: Pick up your bag at the scheduled time and enjoy delicious food at unbeatable prices!',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: GlassContainer.clearGlass(
                        width: 220, // Added width for mission image glass container
                        height: 180, // Added height for mission image glass container
                        borderRadius: BorderRadius.circular(24),
                        blur: 12,
                        borderWidth: 2,
                        borderColor: Colors.white.withOpacity(0.18),
                        elevation: 6,
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.10),
                            Colors.deepPurple.withOpacity(0.10),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fmission.png&w=640&q=75',
                            fit: BoxFit.cover,
                            height: 180,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Why Use Plateful Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        depth: 12,
                        intensity: 0.7,
                        surfaceIntensity: 0.25,
                        color: Colors.white.withOpacity(0.95),
                        shadowLightColor: Colors.tealAccent,
                        shadowDarkColor: Colors.deepPurple,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Why Use Plateful?',
                              style: GoogleFonts.orbitron(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'We’ve designed Plateful to give you the best deals on fresh, surplus food—seamless, affordable, and rewarding for both you and your favorite restaurants.\n\n- Enjoy great food at half the price or less\n- Avoid the hassle of choosing the dish by ordering with a few taps\n- Support local vendors and reduce food waste\n- No hidden charges, flexible pickup time, guaranteed discount, and exclusive value packs',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: GlassContainer.clearGlass(
                        width: 220, // Added width for why use image glass container
                        height: 180, // Added height for why use image glass container
                        borderRadius: BorderRadius.circular(24),
                        blur: 12,
                        borderWidth: 2,
                        borderColor: Colors.white.withOpacity(0.18),
                        elevation: 6,
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.10),
                            Colors.deepPurple.withOpacity(0.10),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fwhyuse.png&w=640&q=75',
                            fit: BoxFit.cover,
                            height: 180,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
} 