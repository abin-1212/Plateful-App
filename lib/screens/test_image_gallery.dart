import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class TestImageGallery extends StatelessWidget {
  const TestImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      {'label': 'Hero Food Background', 'path': AppImages.heroBg},
      {'label': 'How It Works Background', 'path': AppImages.howItWorksBg},
      {'label': 'Features Background', 'path': AppImages.featuresBg},
      {'label': 'Community Background', 'path': AppImages.communityBg},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Test Image Gallery')),
      body: ListView.separated(
        padding: const EdgeInsets.all(32),
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(height: 40),
        itemBuilder: (context, i) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(images[i]['label']!, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                images[i]['path']!,
                fit: BoxFit.cover,
                height: 260,
                width: double.infinity,
                errorBuilder: (context, error, stack) => Container(
                  color: Colors.red[100],
                  height: 260,
                  width: double.infinity,
                  child: const Center(child: Text('Image not found or failed to load', style: TextStyle(color: Colors.red))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 