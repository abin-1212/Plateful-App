import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ModernLoading extends StatelessWidget {
  final double size;
  const ModernLoading({super.key, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size + 32,
        height: size + 32,
        decoration: BoxDecoration(
          gradient: AppGradients.glass,
          borderRadius: BorderRadius.circular(32),
          boxShadow: AppShadows.soft,
        ),
        child: Center(
          child: SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
              backgroundColor: AppColors.glass,
            ),
          ),
        ),
      ),
    );
  }
} 