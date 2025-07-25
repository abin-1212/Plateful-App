import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ModernShadowCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? color;

  const ModernShadowCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color ?? AppColors.glass,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.22),
            blurRadius: 64,
            offset: const Offset(0, 16),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 2),
      ),
      child: child,
    );
  }
} 