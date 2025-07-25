import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/firebase_service.dart';
import '../../widgets/modern_card.dart';
import '../../widgets/modern_section.dart';
import '../../widgets/modern_placeholder_card.dart';
import '../../widgets/modern_scaffold.dart';
import '../../widgets/modern_loading.dart';
import '../../widgets/modern_error.dart';
import '../../widgets/modern_icon_button.dart';
import '../../constants/app_constants.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ModernScaffold(
      child: ModernSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Admin Dashboard', style: AppTextStyles.headline.copyWith(fontSize: 32)),
            const SizedBox(height: 16),
            Text('Manage users, vendors, and view analytics.', style: AppTextStyles.body.copyWith(fontSize: 18, color: AppColors.textLight)),
            const SizedBox(height: 40),
            // Inventory Insight Placeholder
            ModernPlaceholderCard(
              title: 'Inventory Insight',
              description: 'ML-powered inventory analytics will appear here soon.',
              icon: Icons.analytics,
            ),
            const SizedBox(height: 40),
            Text('All Users', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
            const SizedBox(height: 24),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseService().streamUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ModernLoading();
                }
                if (snapshot.hasError) {
                  return ModernError(message: 'Failed to load users.');
                }
                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return ModernPlaceholderCard(
                    title: 'No Users',
                    description: 'No users found in the system.',
                    icon: Icons.person_off,
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  separatorBuilder: (context, i) => const SizedBox(height: 16),
                  itemBuilder: (context, i) {
                    final data = docs[i].data();
                    return ModernCard(
                      title: data['name'] ?? 'User',
                      subtitle: '${data['email'] ?? '--'} | Role: ${data['role'] ?? '--'}',
                      trailing: ModernIconButton(
                        icon: Icons.delete,
                        onPressed: () {/* TODO: Delete user */},
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 40),
            Text('All Vendors', style: AppTextStyles.subhead.copyWith(fontSize: 24)),
            const SizedBox(height: 24),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseService().streamVendors(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ModernLoading();
                }
                if (snapshot.hasError) {
                  return ModernError(message: 'Failed to load vendors.');
                }
                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return ModernPlaceholderCard(
                    title: 'No Vendors',
                    description: 'No vendors found in the system.',
                    icon: Icons.store,
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  separatorBuilder: (context, i) => const SizedBox(height: 16),
                  itemBuilder: (context, i) {
                    final data = docs[i].data();
                    return ModernCard(
                      title: data['name'] ?? 'Vendor',
                      subtitle: '${data['email'] ?? '--'} | Role: ${data['role'] ?? '--'}',
                      trailing: ModernIconButton(
                        icon: Icons.delete,
                        onPressed: () {/* TODO: Delete vendor */},
                      ),
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