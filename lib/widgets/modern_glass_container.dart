import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ModernGlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const ModernGlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 32,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: AppGradients.glass,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: AppShadows.soft,
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 2),
      ),
      child: child,
    );
  }
} 