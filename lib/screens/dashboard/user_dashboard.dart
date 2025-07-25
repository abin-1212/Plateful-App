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
import '../../widgets/modern_icon_button.dart';
import '../../constants/app_constants.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ModernScaffold(
      child: ModernSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome to Plateful', style: AppTextStyles.headline.copyWith(fontSize: 32)),
            const SizedBox(height: 16),
            Text('Discover surplus meals and reserve your favorites.', style: AppTextStyles.body.copyWith(fontSize: 18, color: AppColors.textLight)),
            const SizedBox(height: 40),
            // AI Recommendations Placeholder
            ModernPlaceholderCard(
              title: 'Recommended Packs',
              description: 'AI-powered suggestions will appear here soon.',
              icon: Icons.auto_awesome,
            ),
            const SizedBox(height: 40),
            Text('Available Food Packs', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
            const SizedBox(height: 24),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                  return ModernPlaceholderCard(
                    title: 'No Food Packs',
                    description: 'Check back soon for new surplus meals!',
                    icon: Icons.fastfood,
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
          ],
        ),
      ),
    );
  }
} 