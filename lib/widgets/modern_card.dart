import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'package:flutter/foundation.dart';

class ModernCard extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? imageUrl;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Widget? child;
  const ModernCard({Key? key, this.title, this.subtitle, this.imageUrl, this.trailing, this.onTap, this.child}) : super(key: key);

  @override
  State<ModernCard> createState() => _ModernCardState();
}

class _ModernCardState extends State<ModernCard> {
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
    final isInteractive = widget.onTap != null;
    final scale = _pressed ? 0.97 : (_hovering ? 1.025 : 1.0);
    final tilt = _hovering ? 0.015 : 0.0;
    final shadow = _hovering
        ? [BoxShadow(color: AppColors.shadow.withOpacity(0.18), blurRadius: 40, offset: Offset(0, 12))]
        : AppShadows.glass;
    final highlight = _hovering
        ? BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.18), Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32),
          )
        : null;
    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      transform: Matrix4.identity()
        ..scale(scale, scale)
        ..setEntry(3, 0, tilt),
      decoration: BoxDecoration(
        gradient: AppGradients.glass,
        borderRadius: BorderRadius.circular(32),
        boxShadow: shadow,
      ),
      foregroundDecoration: highlight,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: widget.onTap,
          onHighlightChanged: isInteractive ? _setPressed : null,
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: widget.child ?? _buildContent(),
          ),
        ),
      ),
    );
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux) {
      card = MouseRegion(
        onEnter: (_) => _setHover(true),
        onExit: (_) => _setHover(false),
        child: card,
      );
    }
    return card;
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(widget.imageUrl!, height: 120, width: double.infinity, fit: BoxFit.cover),
          ),
        if (widget.title != null) ...[
          const SizedBox(height: 12),
          Text(widget.title!, style: AppTextStyles.subhead.copyWith(fontSize: 20)),
        ],
        if (widget.subtitle != null) ...[
          const SizedBox(height: 6),
          Text(widget.subtitle!, style: AppTextStyles.body.copyWith(fontSize: 16, color: AppColors.textLight)),
        ],
        if (widget.trailing != null) ...[
          const SizedBox(height: 16),
          Align(alignment: Alignment.bottomRight, child: widget.trailing!),
        ],
      ],
    );
  }
} 