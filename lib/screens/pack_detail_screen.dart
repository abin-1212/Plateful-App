import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';
import '../widgets/modern_card.dart';
import '../widgets/modern_button.dart';
import '../widgets/modern_section.dart';
import '../widgets/modern_scaffold.dart';
import '../widgets/modern_loading.dart';

class PackDetailScreen extends StatelessWidget {
  final String packId;
  const PackDetailScreen({super.key, required this.packId});

  @override
  Widget build(BuildContext context) {
    return ModernScaffold(
      centerContent: true,
      child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseService.firestore.collection('food_packs').doc(packId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const ModernLoading();
          final data = snapshot.data!.data();
          if (data == null) {
            return const Text('Food pack not found.');
          }
          return ModernSection(
            child: Center(
              child: ModernCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (data['imageUrl'] != null && data['imageUrl'] != '')
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(data['imageUrl'], height: 180, fit: BoxFit.cover),
                      ),
                    const SizedBox(height: 20),
                    Text(data['title'] ?? '', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text('₹${data['price'] ?? '--'}', style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text('Expiry: ${data['expiryTime'] ?? '--'}', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Text('Hygiene Rating: ${data['hygieneRating'] ?? '--'} ★', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 20),
                    ModernButton(
                      text: data['reserved'] == true ? 'Reserved' : 'Reserve',
                      isPrimary: data['reserved'] != true,
                      onPressed: data['reserved'] == true
                          ? null
                          : () async {
                              final user = FirebaseService().getCurrentUser();
                              if (user != null) {
                                await FirebaseService().reserveFoodPack(
                                  packId: packId,
                                  userId: user.uid,
                                );
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
