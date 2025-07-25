import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_constants.dart';
import 'modern_button.dart';
import 'modern_section.dart';

class ModernHeroSection extends StatelessWidget {
  final String headline;
  final String subheadline;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final String? imageAsset;

  const ModernHeroSection({
    super.key,
    required this.headline,
    required this.subheadline,
    required this.buttonText,
    required this.onButtonPressed,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    Widget? animationWidget;
    if (imageAsset != null && imageAsset!.endsWith('.json')) {
      animationWidget = FutureBuilder(
        future: AssetLottieLoader.load(imageAsset!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(height: 320);
          } else if (snapshot.hasError) {
            return Image.asset('assets/images/food_fallback.png', height: 220, fit: BoxFit.contain);
          } else {
            return Lottie.asset(imageAsset!, height: 320, fit: BoxFit.contain);
          }
        },
      );
    } else if (imageAsset != null) {
      animationWidget = Image.asset(imageAsset!, height: 320, fit: BoxFit.contain);
    }
    return ModernSection(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (animationWidget != null) ...[
            AnimatedOpacity(
              opacity: 1,
              duration: const Duration(milliseconds: 1400),
              child: animationWidget,
            ),
            const SizedBox(height: 32),
          ],
          AnimatedOpacity(
            opacity: 1,
            duration: const Duration(milliseconds: 800),
            child: Text(
              headline,
              style: AppTextStyles.headline.copyWith(fontSize: 40),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          AnimatedOpacity(
            opacity: 1,
            duration: const Duration(milliseconds: 1200),
            child: Text(
              subheadline,
              style: AppTextStyles.body.copyWith(fontSize: 22, color: AppColors.textLight),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          ModernButton(
            text: buttonText,
            onPressed: onButtonPressed,
            isPrimary: true,
          ),
        ],
      ),
    );
  }
}

class AssetLottieLoader {
  static Future<bool> load(String assetPath) async {
    try {
      await Future.delayed(const Duration(milliseconds: 100));
      await Lottie.asset(assetPath);
      return true;
    } catch (_) {
      return false;
    }
  }
} 