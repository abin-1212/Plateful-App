import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import '../../themes/modern_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? shadows;
  final bool enableBlur;
  final double blurValue;
  final Color? backgroundColor;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final bool enableHover;
  final Duration animationDuration;
  final Curve animationCurve;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.shadows,
    this.enableBlur = true,
    this.blurValue = 10.0,
    this.backgroundColor,
    this.gradient,
    this.onTap,
    this.enableHover = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.all(ModernSpacing.md),
      child: enableHover
          ? _buildHoverableCard()
          : _buildStaticCard(),
    );
  }

  Widget _buildHoverableCard() {
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() {}),
          onExit: (_) => setState(() {}),
          child: AnimatedContainer(
            duration: animationDuration,
            curve: animationCurve,
            child: _buildStaticCard(),
          ),
        );
      },
    );
  }

  Widget _buildStaticCard() {
    if (enableBlur) {
      return GlassContainer(
        width: width,
        height: height,
        padding: padding ?? const EdgeInsets.all(ModernSpacing.lg),
        margin: margin,
        borderRadius: borderRadius ?? BorderRadius.circular(ModernBorderRadius.lg),
        borderColor: borderColor ?? ModernColors.electricBlue.withOpacity(0.3),
        borderWidth: borderWidth ?? 1.0,
        blur: blurValue,
        color: backgroundColor ?? ModernColors.glassWhite,
        gradient: gradient ?? ModernGradients.glassGradient,
        shadowColor: Colors.black.withOpacity(0.1),
        child: _buildContent(),
      );
    } else {
      return Container(
        width: width,
        height: height,
        padding: padding ?? const EdgeInsets.all(ModernSpacing.lg),
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(ModernBorderRadius.lg),
          border: Border.all(
            color: borderColor ?? ModernColors.electricBlue.withOpacity(0.3),
            width: borderWidth ?? 1.0,
          ),
          color: backgroundColor ?? ModernColors.darkGray.withOpacity(0.8),
          gradient: gradient,
          boxShadow: shadows ?? ModernShadows.glassShadow,
        ),
        child: _buildContent(),
      );
    }
  }

  Widget _buildContent() {
    Widget content = child;
    
    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(ModernBorderRadius.lg),
        child: content,
      );
    }
    
    return content;
  }
}

class GlowingGlassCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color glowColor;
  final double glowIntensity;
  final bool enablePulse;
  final Duration pulseDuration;
  final VoidCallback? onTap;
  final bool enableBlur;
  final double blurValue;

  const GlowingGlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.glowColor = ModernColors.electricBlue,
    this.glowIntensity = 0.3,
    this.enablePulse = false,
    this.pulseDuration = const Duration(seconds: 2),
    this.onTap,
    this.enableBlur = true,
    this.blurValue = 10.0,
  });

  @override
  State<GlowingGlassCard> createState() => _GlowingGlassCardState();
}

class _GlowingGlassCardState extends State<GlowingGlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: widget.pulseDuration,
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.enablePulse) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        final glowOpacity = widget.enablePulse
            ? widget.glowIntensity * (0.5 + 0.5 * _pulseAnimation.value)
            : widget.glowIntensity;

        return Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(ModernBorderRadius.lg),
            boxShadow: ModernShadows.neonGlow(widget.glowColor.withOpacity(glowOpacity)),
          ),
          child: GlassCard(
            width: widget.width,
            height: widget.height,
            padding: widget.padding,
            margin: EdgeInsets.zero,
            borderRadius: widget.borderRadius,
            borderColor: widget.glowColor.withOpacity(0.5),
            borderWidth: 2.0,
            enableBlur: widget.enableBlur,
            blurValue: widget.blurValue,
            onTap: widget.onTap,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class GradientGlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Gradient gradient;
  final Color? borderColor;
  final double? borderWidth;
  final bool enableBlur;
  final double blurValue;
  final VoidCallback? onTap;
  final bool enableHover;

  const GradientGlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    required this.gradient,
    this.borderColor,
    this.borderWidth,
    this.enableBlur = true,
    this.blurValue = 10.0,
    this.onTap,
    this.enableHover = true,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      enableBlur: enableBlur,
      blurValue: blurValue,
      gradient: gradient,
      onTap: onTap,
      enableHover: enableHover,
      child: child,
    );
  }
}

class AnimatedGlassCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final bool enableBlur;
  final double blurValue;
  final VoidCallback? onTap;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool enableScale;
  final bool enableRotation;

  const AnimatedGlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.enableBlur = true,
    this.blurValue = 10.0,
    this.onTap,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.enableScale = true,
    this.enableRotation = false,
  });

  @override
  State<AnimatedGlassCard> createState() => _AnimatedGlassCardState();
}

class _AnimatedGlassCardState extends State<AnimatedGlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    ));
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.02,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enableScale) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enableScale) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.enableScale) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.enableScale ? _scaleAnimation.value : 1.0,
            child: Transform.rotate(
              angle: widget.enableRotation ? _rotationAnimation.value : 0.0,
              child: GlassCard(
                width: widget.width,
                height: widget.height,
                padding: widget.padding,
                margin: widget.margin,
                borderRadius: widget.borderRadius,
                borderColor: widget.borderColor,
                borderWidth: widget.borderWidth,
                enableBlur: widget.enableBlur,
                blurValue: widget.blurValue,
                child: widget.child,
              ),
            ),
          );
        },
      ),
    );
  }
} 