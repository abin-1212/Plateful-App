import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';
import '../widgets/modern_card.dart';
import '../widgets/modern_section.dart';
import '../widgets/modern_scaffold.dart';
import '../widgets/modern_loading.dart';
import '../widgets/modern_error.dart';
import '../widgets/modern_placeholder_card.dart';
import '../constants/app_constants.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ModernScaffold(
      child: ModernSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notifications', style: AppTextStyles.headline.copyWith(fontSize: 32)),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: FirebaseService().getCurrentUser() == null
                  ? null
                  : FirebaseService().streamNotifications(FirebaseService().getCurrentUser()!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ModernLoading();
                }
                if (snapshot.hasError) {
                  return ModernError(message: 'Failed to load notifications.');
                }
                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return ModernPlaceholderCard(
                    title: 'No Notifications',
                    description: 'You have no notifications yet.',
                    icon: Icons.notifications_off,
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
                      title: data['title'] ?? 'Notification',
                      subtitle: data['body'] ?? '',
                      trailing: Icon(Icons.notifications, color: AppColors.primary),
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

String _formatTimestamp(dynamic ts) {
  if (ts is Timestamp) {
    final dt = ts.toDate();
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
  return '';
} 