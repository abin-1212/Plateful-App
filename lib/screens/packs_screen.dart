import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/pack_card_widget.dart';
import '../mock_data.dart';

class PacksScreen extends StatelessWidget {
  const PacksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Column(
        children: [
          Navbar(),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchPacks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final packs = (snapshot.hasData && snapshot.data!.isNotEmpty)
                    ? snapshot.data!
                    : mockPacks;
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 12 : 64,
                      vertical: isMobile ? 24 : 48,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'All Food Packs',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: isMobile ? 24 : 32,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 32),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isMobile ? 1 : 3,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            childAspectRatio: 0.82,
                          ),
                          itemCount: packs.length,
                          itemBuilder: (context, i) {
                            final pack = packs[i];
                            return PackCardWidget(
                              imageUrl: pack['image'],
                              title: pack['title'],
                              description: pack['desc'],
                              price: pack['price'],
                              offer: pack['offer'],
                              onViewDetails: () {
                                Navigator.pushNamed(context, '/packs/${i + 1}');
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
} 