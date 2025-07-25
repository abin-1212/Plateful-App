import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ModernDivider extends StatelessWidget {
  final double thickness;
  final double indent;
  final double endIndent;
  final double radius;

  const ModernDivider({
    super.key,
    this.thickness = 2,
    this.indent = 0,
    this.endIndent = 0,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: indent, right: endIndent, top: 24, bottom: 24),
      height: thickness,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          colors: [AppColors.glass, AppColors.primary.withOpacity(0.18), AppColors.glass],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
} 