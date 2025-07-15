import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../firebase_options.dart';
import 'package:lottie/lottie.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Navbar(),
            // Hero Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF181A2A), Color(0xFF6C3EF4), Color(0xFF00FFD0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left: Animated Texts and buttons
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              "India's First Food Surplus Marketplace",
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
                              'Good food at even better price',
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
                        SizedBox(height: 32),
                        Row(
                          children: [
                            _GlowingButton(
                              icon: Icons.android,
                              label: 'Get it on Google Play',
                              onPressed: () {},
                            ),
                            SizedBox(width: 16),
                            _GlowingButton(
                              icon: Icons.apple,
                              label: 'Download on the App Store',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Right: Lottie/3D Animation in Glass Container
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: GlassContainer.clearGlass(
                        width: 400, // Added width for hero glass container
                        height: 320, // Already present
                        borderRadius: BorderRadius.circular(32),
                        blur: 18,
                        borderWidth: 2,
                        borderColor: Colors.white.withOpacity(0.18),
                        elevation: 12,
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.10),
                            Colors.deepPurple.withOpacity(0.10),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Lottie.network(
                            'https://assets10.lottiefiles.com/packages/lf20_2ks3pjua.json',
                            height: 260,
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
            // Impact Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: GlassContainer.clearGlass(
                width: 900, // Added width for impact section glass container
                height: 220, // Already present
                borderRadius: BorderRadius.circular(32),
                blur: 12,
                borderWidth: 2,
                borderColor: Colors.white.withOpacity(0.10),
                elevation: 6,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.10),
                    Colors.deepPurple.withOpacity(0.10),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Text(
                        'Our Impact',
                        style: GoogleFonts.orbitron(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.tealAccent,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              blurRadius: 12,
                              color: Colors.tealAccent.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _impactStat('10K+', 'Meals Saved'),
                          _impactStat('1K+', 'Users in India'),
                          _impactStat('10+', 'Happy Partners'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // How It Works Section
            Container(
              color: Color(0xFFF5F5F5),
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                children: [
                  Text(
                    'How Plateful Works',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _howItWorksStep(
                        'Download & Explore',
                        'Download the Plateful app and sign up to get started. Discover a variety of packs and listings from nearby restaurants and supermarkets.',
                        'https://www.plenti.co.in/assets/images/download.png',
                      ),
                      _howItWorksStep(
                        'Reserve a Surprise Bag',
                        'Choose a surprise bag from your favorite local stores and reserve it at a discounted price.',
                        'https://www.plenti.co.in/assets/images/reserve.png',
                      ),
                      _howItWorksStep(
                        'Pick Up & Enjoy',
                        'Pick up your bag at the scheduled time and enjoy delicious food at unbeatable prices!',
                        'https://www.plenti.co.in/assets/images/pickup.png',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Features Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Feature3DCard(
                    title: 'Save More',
                    desc: 'Get delicious meals, fresh bakes, and essential groceries at a fraction of the cost.',
                    imgUrl: 'https://www.plenti.co.in/assets/images/save.png',
                  ),
                  _Feature3DCard(
                    title: 'Support Local',
                    desc: 'Help your neighborhood restaurants, bakeries, and supermarkets reduce waste and unlock additional revenue.',
                    imgUrl: 'https://www.plenti.co.in/assets/images/support.png',
                  ),
                  _Feature3DCard(
                    title: 'Eco-Conscious',
                    desc: 'Join a movement to reduce food waste and make a positive impact on the environment.',
                    imgUrl: 'https://www.plenti.co.in/assets/images/eco.png',
                  ),
                ],
              ),
            ),
            // Testimonials Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                children: [
                  Text(
                    'Testimonials',
                    style: GoogleFonts.orbitron(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          blurRadius: 12,
                          color: Colors.tealAccent.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Testimonial3DCard(
                        name: 'Ravi Sharma',
                        quote: '"I can sell unsold food to people who appreciate a good deal. It’s extra income for me and a way to serve more customers."',
                        imgUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
                      ),
                      _Testimonial3DCard(
                        name: 'Priya Nair',
                        quote: '"Plateful has been a game-changer for my bakery. Customers love the deals, and I love that nothing goes to waste."',
                        imgUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            DemandPredictionWidget(),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _impactStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF6C3EF4)),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _howItWorksStep(String title, String desc, String imgUrl) {
    return SizedBox(
      width: 220,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(imgUrl, height: 120, fit: BoxFit.cover),
          ),
          SizedBox(height: 16),
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(desc, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _featureCard(String title, String desc, String imgUrl) {
    return SizedBox(
      width: 220,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(imgUrl, height: 100, fit: BoxFit.cover),
          ),
          SizedBox(height: 16),
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(desc, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _testimonialCard(String name, String quote, String imgUrl) {
    return SizedBox(
      width: 320,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imgUrl),
                radius: 32,
              ),
              SizedBox(height: 16),
              Text(
                quote,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DemandPredictionWidget extends StatefulWidget {
  @override
  _DemandPredictionWidgetState createState() => _DemandPredictionWidgetState();
}

class _DemandPredictionWidgetState extends State<DemandPredictionWidget> {
  int? prediction;
  bool loading = false;
  String? error;

  void predictDemand() async {
    setState(() {
      loading = true;
      error = null;
    });
    final input = {
      "center_id": 11,
      "meal_id": 1885,
      "week": 5,
      "checkout_price": 136.83
    };
    try {
      int result = await getPredictedDemand(input);
      setState(() {
        prediction = result;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: predictDemand,
          child: Text('Predict Demand'),
        ),
        if (loading) CircularProgressIndicator(),
        if (prediction != null) Text('Predicted Demand: '
            ' 24$prediction'),
        if (error != null) Text('Error: $error', style: TextStyle(color: Colors.red)),
      ],
    );
  }
}

class _GlowingButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  const _GlowingButton({required this.icon, required this.label, required this.onPressed});

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
        child: ElevatedButton.icon(
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
          icon: Icon(widget.icon),
          label: Text(widget.label),
        ),
      ),
    );
  }
}

class _Feature3DCard extends StatefulWidget {
  final String title;
  final String desc;
  final String imgUrl;
  const _Feature3DCard({required this.title, required this.desc, required this.imgUrl});

  @override
  State<_Feature3DCard> createState() => _Feature3DCardState();
}

class _Feature3DCardState extends State<_Feature3DCard> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: _hovering ? (Matrix4.identity()..translate(0.0, -8.0, 0.0)..scale(1.04)) : Matrix4.identity(),
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: _hovering ? 16 : 8,
            intensity: 0.7,
            surfaceIntensity: 0.25,
            color: Colors.white.withOpacity(0.95),
            shadowLightColor: Colors.tealAccent,
            shadowDarkColor: Colors.deepPurple,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),
          ),
          child: Container(
            width: 240,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(widget.imgUrl, height: 100, fit: BoxFit.cover),
                ),
                SizedBox(height: 16),
                Text(widget.title, style: GoogleFonts.orbitron(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                SizedBox(height: 8),
                Text(widget.desc, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black87)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Testimonial3DCard extends StatefulWidget {
  final String name;
  final String quote;
  final String imgUrl;
  const _Testimonial3DCard({required this.name, required this.quote, required this.imgUrl});

  @override
  State<_Testimonial3DCard> createState() => _Testimonial3DCardState();
}

class _Testimonial3DCardState extends State<_Testimonial3DCard> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: _hovering ? (Matrix4.identity()..translate(0.0, -8.0, 0.0)..scale(1.04)) : Matrix4.identity(),
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: _hovering ? 16 : 8,
            intensity: 0.7,
            surfaceIntensity: 0.25,
            color: Colors.white.withOpacity(0.95),
            shadowLightColor: Colors.tealAccent,
            shadowDarkColor: Colors.deepPurple,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.imgUrl),
                  radius: 32,
                ),
                SizedBox(height: 16),
                Text(
                  widget.quote,
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  widget.name,
                  style: GoogleFonts.orbitron(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepPurple),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
