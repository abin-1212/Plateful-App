import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ModernAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;

  const ModernAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppGradients.glass,
        boxShadow: AppShadows.soft,
        border: Border.all(color: Colors.white.withOpacity(0.7), width: 2),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(imageUrl!, fit: BoxFit.cover, width: size, height: size)
            : Center(
                child: Text(
                  (initials ?? '').toUpperCase(),
                  style: AppTextStyles.headline.copyWith(fontSize: size / 2.2),
                ),
              ),
      ),
    );
  }
} 