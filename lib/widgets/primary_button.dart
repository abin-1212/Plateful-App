import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const PrimaryButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.icon,
    this.width,
    this.height,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonContent = loading
        ? SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(PlatefulColors.textPrimary),
              strokeWidth: 2.5,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: PlatefulColors.textPrimary, size: 22),
                SizedBox(width: 8),
              ],
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: PlatefulColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          );

    return AnimatedContainer(
      duration: Duration(milliseconds: 120),
      width: width,
      height: height ?? 48,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: PlatefulColors.primaryGradientStart.withOpacity(0.18),
        ).copyWith(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) => null),
          foregroundColor: MaterialStateProperty.all(PlatefulColors.textPrimary),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: platefulGradient,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Container(
            alignment: Alignment.center,
            child: buttonContent,
          ),
        ),
      ),
    );
  }
} 