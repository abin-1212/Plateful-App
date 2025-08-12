import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firebase_service.dart';
import '../../widgets/modern_card.dart';
import '../../widgets/modern_section.dart';
import '../../widgets/modern_placeholder_card.dart';
import '../../widgets/modern_button.dart';
import '../../widgets/modern_scaffold.dart';
import '../../widgets/modern_loading.dart';
import '../../widgets/modern_error.dart';
import '../../constants/app_constants.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ModernScaffold(
      child: SingleChildScrollView(
        child: ModernSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TEST: Show a visible image to confirm asset loading
              Container(
                height: 180,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 24),
                child: Image.asset('assets/images/hero_food_bg.jpg', fit: BoxFit.cover),
              ),
              // Section 1: Welcome
              Text('Welcome to Plateful', style: AppTextStyles.headline.copyWith(fontSize: 32)),
              const SizedBox(height: 16),
              Text('Discover surplus meals and reserve your favorites.', style: AppTextStyles.body.copyWith(fontSize: 18, color: AppColors.textLight)),
              const SizedBox(height: 40),
              // Section 2: Recommended Packs (Horizontal List with more cards)
              Text('Recommended Packs', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
              const SizedBox(height: 16),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _samplePackCard('Veggie Delight Pack', 'assets/images/hero_food_bg.jpg'),
                    const SizedBox(width: 16),
                    _samplePackCard('Paneer Tikka Pack', 'assets/images/features_bg.jpg'),
                    const SizedBox(width: 16),
                    _samplePackCard('Fruit Basket', 'assets/images/community_bg.jpg'),
                    const SizedBox(width: 16),
                    _samplePackCard('How It Works Special', 'assets/images/how_it_works_bg.jpg'),
                    const SizedBox(width: 16),
                    _samplePackCard('Chef’s Choice', 'assets/images/hero_food_bg.jpg'),
                    const SizedBox(width: 16),
                    _samplePackCard('Spicy Fiesta', 'assets/images/features_bg.jpg'),
                    const SizedBox(width: 16),
                    _samplePackCard('Healthy Bites', 'assets/images/community_bg.jpg'),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              // Section 3: Available Food Packs (More sample cards if empty)
              Text('Available Food Packs', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
              const SizedBox(height: 24),
              Container(
                constraints: const BoxConstraints(minHeight: 180),
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseService().streamFoodPacks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ModernLoading();
                    }
                    if (snapshot.hasError) {
                      return ModernError(message: 'Failed to load food packs.');
                    }
                    final docs = snapshot.data?.docs ?? [];
                    if (docs.isEmpty) {
                      // Show 6 sample cards in a grid
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.25,
                        children: [
                          _samplePackCard('Paneer Tikka Pack', 'assets/images/features_bg.jpg'),
                          _samplePackCard('Fruit Basket', 'assets/images/community_bg.jpg'),
                          _samplePackCard('How It Works Special', 'assets/images/how_it_works_bg.jpg'),
                          _samplePackCard('Veggie Delight Pack', 'assets/images/hero_food_bg.jpg'),
                          _samplePackCard('Spicy Fiesta', 'assets/images/features_bg.jpg'),
                          _samplePackCard('Healthy Bites', 'assets/images/community_bg.jpg'),
                        ],
                      );
                    }
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 800;
                        final crossAxisCount = isMobile ? 1 : 3;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            childAspectRatio: 1.25,
                          ),
                          itemCount: docs.length,
                          itemBuilder: (context, i) {
                            final data = docs[i].data();
                            return ModernCard(
                              title: data['title'] ?? 'Food Pack',
                              subtitle: '₹${data['price'] ?? '--'} | Expires: ${data['expiry'] ?? '--'}',
                              imageUrl: data['imageUrl'],
                              trailing: ModernButton(
                                text: 'Reserve',
                                onPressed: () {/* TODO: Implement reserve */},
                                isPrimary: true,
                                height: 40,
                                width: 120,
                              ),
                              onTap: () {/* TODO: Navigate to detail */},
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 60),
              // Section 4: Community Highlights (Two Testimonial Cards)
              Text('Community Highlights', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
              const SizedBox(height: 16),
              _communityStoryCard(),
              const SizedBox(height: 24),
              _communityStoryCard2(),
              const SizedBox(height: 60),
              // Section 5: Food Rescue Tips (More tips)
              Text('Food Rescue Tips', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
              const SizedBox(height: 16),
              _tipsList(),
              const SizedBox(height: 60),
              // Section 6: Feedback & Testimonials (Two Testimonial Cards)
              Text('Feedback & Testimonials', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
              const SizedBox(height: 16),
              _testimonialCard(),
              const SizedBox(height: 24),
              _testimonialCard2(),
              const SizedBox(height: 60),
              // Section 7: Recent Activity (More timeline items)
              Text('Recent Activity', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
              const SizedBox(height: 16),
              _activityTimeline(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _samplePackCard(String title, String imageAsset) {
    return Container(
      width: 220,
      height: 160,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.darken),
        ),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ModernButton(
            text: 'Reserve',
            onPressed: () {},
            isPrimary: true,
            height: 36,
            width: 100,
          ),
        ],
      ),
    );
  }

  Widget _communityStoryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage('assets/images/community_bg.jpg'),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Riya Sharma', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8),
                Text('“I saved 10 meals last week and met amazing people in my community!”', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _communityStoryCard2() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage('assets/images/hero_food_bg.jpg'),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Sahil Gupta', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8),
                Text('“Thanks to Plateful, I was able to donate extra food from my restaurant!”', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tipsList() {
    final tips = [
      {'icon': Icons.kitchen, 'text': 'Store cooked food in airtight containers.'},
      {'icon': Icons.timer, 'text': 'Label leftovers with dates to avoid waste.'},
      {'icon': Icons.recycling, 'text': 'Compost food scraps when possible.'},
      {'icon': Icons.volunteer_activism, 'text': 'Share surplus food with neighbors.'},
      {'icon': Icons.eco, 'text': 'Plan meals ahead to reduce waste.'},
      {'icon': Icons.shopping_cart, 'text': 'Shop with a list to avoid overbuying.'},
    ];
    return Column(
      children: tips.map((tip) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(tip['icon'] as IconData, color: AppColors.primary, size: 28),
            const SizedBox(width: 16),
            Expanded(child: Text(tip['text'] as String, style: const TextStyle(fontSize: 16))),
          ],
        ),
      )).toList(),
    );
  }

  Widget _testimonialCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.person, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Amit Verma', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8),
                Text('“The app made it so easy to donate and reserve food. Highly recommended!”', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.amber, size: 22),
              Icon(Icons.star, color: Colors.amber, size: 22),
              Icon(Icons.star, color: Colors.amber, size: 22),
              Icon(Icons.star, color: Colors.amber, size: 22),
              Icon(Icons.star_half, color: Colors.amber, size: 22),
            ],
          ),
        ],
      ),
    );
  }

  Widget _testimonialCard2() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.accent,
            child: const Icon(Icons.person_outline, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Priya Singh', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8),
                Text('“I love how easy it is to find and reserve surplus meals. Great initiative!”', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.amber, size: 22),
              Icon(Icons.star, color: Colors.amber, size: 22),
              Icon(Icons.star, color: Colors.amber, size: 22),
              Icon(Icons.star, color: Colors.amber, size: 22),
              Icon(Icons.star, color: Colors.amber, size: 22),
            ],
          ),
        ],
      ),
    );
  }

  Widget _activityTimeline() {
    final activities = [
      {'icon': Icons.fastfood, 'text': 'You reserved a Veggie Delight Pack yesterday.'},
      {'icon': Icons.feedback, 'text': 'You left feedback for Paneer Tikka Pack.'},
      {'icon': Icons.people, 'text': 'You joined the Community Group.'},
      {'icon': Icons.star, 'text': 'You rated Chef’s Choice 5 stars.'},
      {'icon': Icons.shopping_basket, 'text': 'You picked up a Fruit Basket.'},
    ];
    return Column(
      children: activities.map((activity) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(activity['icon'] as IconData, color: AppColors.accent, size: 26),
            const SizedBox(width: 16),
            Expanded(child: Text(activity['text'] as String, style: const TextStyle(fontSize: 16))),
          ],
        ),
      )).toList(),
    );
  }
} 