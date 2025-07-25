import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ModernError extends StatelessWidget {
  final String message;
  final EdgeInsetsGeometry? padding;

  const ModernError({
    super.key,
    required this.message,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        gradient: AppGradients.glass,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.soft,
        border: Border.all(color: Colors.red.withOpacity(0.18), width: 2),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.withOpacity(0.7)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.body.copyWith(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
} 