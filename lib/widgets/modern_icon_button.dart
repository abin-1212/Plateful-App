import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ModernIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? color;

  const ModernIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 44,
    this.color,
  });

  @override
  State<ModernIconButton> createState() => _ModernIconButtonState();
}

class _ModernIconButtonState extends State<ModernIconButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.primary;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            gradient: AppGradients.glass,
            borderRadius: BorderRadius.circular(widget.size / 2),
            boxShadow: _hovered || _pressed
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.18),
                      blurRadius: 24,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : AppShadows.soft,
            border: Border.all(
              color: _hovered ? color.withOpacity(0.18) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Icon(widget.icon, color: color, size: widget.size * 0.6),
        ),
      ),
    );
  }
} 