import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/modern_card.dart';
import '../widgets/modern_section.dart';
import '../constants/app_constants.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return ModernScaffold(
      centerContent: true,
      child: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 32 : 48,
                horizontal: isMobile ? 16 : 32,
              ),
              decoration: BoxDecoration(
                gradient: AppGradients.glass,
                borderRadius: BorderRadius.circular(32),
                boxShadow: AppShadows.glass,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.check_circle, color: AppColors.accent, size: 80),
                  const SizedBox(height: 24),
                  Text(
                    'Success!',
                    style: AppTextStyles.headline.copyWith(fontSize: 32, color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Your action was completed successfully.',
                    style: AppTextStyles.body.copyWith(fontSize: 18, color: AppColors.textLight),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
