import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/app_constants.dart';
import 'modern_card.dart';

class ModernPlaceholderCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final double? width;
  final double? height;

  const ModernPlaceholderCard({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      child: Shimmer.fromColors(
        baseColor: AppColors.glass.withOpacity(0.7),
        highlightColor: Colors.white.withOpacity(0.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: AppColors.primary.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.subhead.copyWith(color: AppColors.textDark.withOpacity(0.7)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyles.body.copyWith(color: AppColors.textLight),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 