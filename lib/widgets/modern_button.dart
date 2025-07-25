import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import '../constants/app_constants.dart';
import 'package:flutter/foundation.dart';

class ModernButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isPrimary;
  final double? width;
  final double? height;

  const ModernButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isPrimary = true,
    this.width,
    this.height,
  });

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton> {
  bool _hovering = false;
  bool _pressed = false;

  void _setHover(bool value) {
    setState(() => _hovering = value);
  }

  void _setPressed(bool value) {
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final scale = _pressed ? 0.96 : (_hovering ? 1.03 : 1.0);
    final glow = _hovering && widget.isPrimary
        ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.32),
              blurRadius: 32,
              spreadRadius: 2,
            ),
          ]
        : null;
    Widget button = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      width: widget.width,
      height: widget.height,
      transform: Matrix4.identity()..scale(scale, scale),
      decoration: BoxDecoration(
        color: widget.isPrimary ? AppColors.primary : AppColors.glass,
        borderRadius: BorderRadius.circular(28),
        boxShadow: glow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: widget.onPressed,
          onHighlightChanged: _setPressed,
          child: Center(
            child: Text(
              widget.text,
              style: widget.isPrimary ? AppTextStyles.button : AppTextStyles.body.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux) {
      button = MouseRegion(
        onEnter: (_) => _setHover(true),
        onExit: (_) => _setHover(false),
        child: button,
      );
    }
    return button;
  }
} 