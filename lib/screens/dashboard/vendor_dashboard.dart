import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firebase_service.dart';
import '../../widgets/modern_card.dart';
import '../../widgets/modern_section.dart';
import '../../widgets/modern_placeholder_card.dart';
import '../../widgets/modern_button.dart';
import '../../widgets/modern_icon_button.dart';
import '../../widgets/modern_scaffold.dart';
import '../../widgets/modern_loading.dart';
import '../../widgets/modern_error.dart';
import '../../constants/app_constants.dart';
import 'package:go_router/go_router.dart';

class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ModernScaffold(
      child: SingleChildScrollView(
        child: ModernSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vendor Welcome & Stats
              Text('Welcome, Vendor!', style: AppTextStyles.headline.copyWith(fontSize: 32)),
              const SizedBox(height: 16),
              Text('Manage your surplus food packs and view insights.', style: AppTextStyles.body.copyWith(fontSize: 18, color: AppColors.textLight)),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statCard('Total Packs', '24', Icons.fastfood, AppColors.primary),
                  _statCard('Reserved', '18', Icons.check_circle, AppColors.accent),
                  _statCard('Feedback', '12', Icons.feedback, AppColors.textLight),
                ],
              ),
              const SizedBox(height: 40),
              // Demand Forecast Chart Placeholder
              ModernPlaceholderCard(
                title: 'Demand Forecast',
                description: 'ML-powered demand chart will appear here soon.',
                icon: Icons.show_chart,
              ),
              const SizedBox(height: 40),
              // Food Packs Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Your Food Packs', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
                  ModernButton(
                    text: 'Add Food',
                    onPressed: () => context.go('/vendor/add-food'),
                    isPrimary: true,
                    height: 40,
                    width: 120,
                  ),
                ],
              ),
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
                      // Show 4 sample cards
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
                              trailing: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ModernIconButton(
                                    icon: Icons.edit,
                                    onPressed: () {/* TODO: Edit */},
                                  ),
                                  const SizedBox(width: 8),
                                  ModernIconButton(
                                    icon: Icons.delete,
                                    onPressed: () {/* TODO: Delete */},
                                  ),
                                ],
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
              const SizedBox(height: 40),
              // Recent Reservations Section
              Text('Recent Reservations', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
              const SizedBox(height: 16),
              _reservationList(),
              const SizedBox(height: 40),
              // Vendor Tips Section
              Text('Vendor Tips', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
              const SizedBox(height: 16),
              _tipsList(),
              const SizedBox(height: 40),
              // Vendor Testimonials Section
              Text('What Users Say', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
              const SizedBox(height: 16),
              _testimonialCard(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
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
            text: 'Edit',
            onPressed: () {},
            isPrimary: false,
            height: 36,
            width: 80,
          ),
          const SizedBox(height: 8),
          ModernButton(
            text: 'Delete',
            onPressed: () {},
            isPrimary: true,
            height: 36,
            width: 80,
          ),
        ],
      ),
    );
  }

  Widget _reservationList() {
    final reservations = [
      {'user': 'Riya Sharma', 'pack': 'Paneer Tikka Pack', 'image': 'assets/images/features_bg.jpg'},
      {'user': 'Amit Verma', 'pack': 'Fruit Basket', 'image': 'assets/images/community_bg.jpg'},
      {'user': 'Priya Singh', 'pack': 'Veggie Delight Pack', 'image': 'assets/images/hero_food_bg.jpg'},
    ];
    return Column(
      children: reservations.map((r) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage(r['image']!)),
          title: Text(r['user']!),
          subtitle: Text('Reserved: ${r['pack']}'),
          trailing: Icon(Icons.check_circle, color: AppColors.accent),
        ),
      )).toList(),
    );
  }

  Widget _tipsList() {
    final tips = [
      {'icon': Icons.photo_camera, 'text': 'Add clear photos to attract more users.'},
      {'icon': Icons.description, 'text': 'Write detailed descriptions for your packs.'},
      {'icon': Icons.timer, 'text': 'Update expiry times to keep info fresh.'},
      {'icon': Icons.star, 'text': 'Respond to feedback to build trust.'},
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
                Text('User Feedback', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8),
                Text('“Great experience reserving from this vendor. The food was fresh and delicious!”', style: TextStyle(fontSize: 16)),
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
} 