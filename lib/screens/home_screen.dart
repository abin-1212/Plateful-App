import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

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
              color: const Color(0xFF6C3EF4),
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left: Texts and buttons
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "India's First Food Surplus Marketplace",
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Good food at even better price',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 32),
                        Row(
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF6C3EF4),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              icon: Icon(Icons.android),
                              label: Text('Get it on Google Play'),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF6C3EF4),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              icon: Icon(Icons.apple),
                              label: Text('Download on the App Store'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Right: Hero image (Plenti-style)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: AspectRatio(
                        aspectRatio: 1.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            'https://www.plenti.co.in/_next/image?url=%2Fassets%2Fimages%2Fhero.png&w=640&q=75',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Impact Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                children: [
                  Text(
                    'Our Impact',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                children: [
                  Text(
                    'Why Use Plateful?',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _featureCard(
                        'Save More',
                        'Get delicious meals, fresh bakes, and essential groceries at a fraction of the cost.',
                        'https://www.plenti.co.in/assets/images/save.png',
                      ),
                      _featureCard(
                        'Support Local',
                        'Help your neighborhood restaurants, bakeries, and supermarkets reduce waste and unlock additional revenue.',
                        'https://www.plenti.co.in/assets/images/support.png',
                      ),
                      _featureCard(
                        'Eco-Conscious',
                        'Join a movement to reduce food waste and make a positive impact on the environment.',
                        'https://www.plenti.co.in/assets/images/eco.png',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Testimonials Section
            Container(
              color: Color(0xFFF5F5F5),
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                children: [
                  Text(
                    'Testimonials',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _testimonialCard(
                        'Ravi Sharma',
                        '"I can sell unsold food to people who appreciate a good deal. It’s extra income for me and a way to serve more customers."',
                        'https://randomuser.me/api/portraits/men/32.jpg',
                      ),
                      _testimonialCard(
                        'Priya Nair',
                        '"Plateful has been a game-changer for my bakery. Customers love the deals, and I love that nothing goes to waste."',
                        'https://randomuser.me/api/portraits/women/44.jpg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
