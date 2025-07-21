import 'package:flutter/material.dart';
import '../../themes/modern_theme.dart';

class ModernButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final IconData? trailingIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final Gradient? gradient;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool enableGlow;
  final Color? glowColor;
  final double glowIntensity;
  final bool enablePulse;
  final Duration pulseDuration;
  final bool enableScale;
  final Duration animationDuration;
  final Curve animationCurve;

  const ModernButton({
    super.key,
    required this.text,
    this.onPressed,
    this.onLongPress,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.trailingIcon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.gradient,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.enableGlow = true,
    this.glowColor,
    this.glowIntensity = 0.3,
    this.enablePulse = false,
    this.pulseDuration = const Duration(seconds: 2),
    this.enableScale = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
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

    if (widget.enablePulse) {
      _pulseAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enableScale && widget.isEnabled && !widget.isLoading) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enableScale && widget.isEnabled && !widget.isLoading) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.enableScale && widget.isEnabled && !widget.isLoading) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveGlowColor = widget.glowColor ?? 
        (widget.gradient != null ? ModernColors.electricBlue : widget.backgroundColor ?? ModernColors.electricBlue);
    
    final effectiveBackgroundColor = widget.backgroundColor ?? ModernColors.electricBlue;
    final effectiveTextColor = widget.textColor ?? ModernColors.textPrimary;
    final effectiveBorderColor = widget.borderColor ?? effectiveBackgroundColor;

    Widget button = GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.isEnabled && !widget.isLoading ? widget.onPressed : null,
      onLongPress: widget.isEnabled && !widget.isLoading ? widget.onLongPress : null,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = widget.enableScale ? _scaleAnimation.value : 1.0;
          final glowOpacity = widget.enablePulse && widget.enableGlow
              ? widget.glowIntensity * (0.5 + 0.5 * _pulseAnimation.value)
              : widget.glowIntensity;

          return Transform.scale(
            scale: scale,
            child: Container(
              width: widget.width,
              height: widget.height ?? 56.0,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(ModernBorderRadius.lg),
                gradient: widget.gradient,
                color: widget.gradient == null ? effectiveBackgroundColor : null,
                border: Border.all(
                  color: effectiveBorderColor,
                  width: widget.borderWidth ?? 2.0,
                ),
                boxShadow: widget.enableGlow
                    ? ModernShadows.neonGlow(effectiveGlowColor.withOpacity(glowOpacity))
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(ModernBorderRadius.lg),
                  onTap: widget.isEnabled && !widget.isLoading ? widget.onPressed : null,
                  child: Container(
                    padding: widget.padding ?? const EdgeInsets.symmetric(
                      horizontal: ModernSpacing.xl,
                      vertical: ModernSpacing.md,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.isLoading)
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                            ),
                          )
                        else ...[
                          if (widget.icon != null) ...[
                            Icon(
                              widget.icon,
                              color: effectiveTextColor,
                              size: 20,
                            ),
                            const SizedBox(width: ModernSpacing.sm),
                          ],
                          Flexible(
                            child: Text(
                              widget.text,
                              style: ModernTextStyles.labelLarge.copyWith(
                                color: effectiveTextColor,
                                fontSize: widget.fontSize,
                                fontWeight: widget.fontWeight,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.trailingIcon != null) ...[
                            const SizedBox(width: ModernSpacing.sm),
                            Icon(
                              widget.trailingIcon,
                              color: effectiveTextColor,
                              size: 20,
                            ),
                          ],
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    if (!widget.isEnabled) {
      button = Opacity(
        opacity: 0.5,
        child: button,
      );
    }

    return button;
  }
}

class ModernOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final IconData? trailingIcon;
  final Color? borderColor;
  final Color? textColor;
  final double? borderWidth;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool enableGlow;
  final Color? glowColor;
  final double glowIntensity;
  final bool enableScale;
  final Duration animationDuration;
  final Curve animationCurve;

  const ModernOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.onLongPress,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.trailingIcon,
    this.borderColor,
    this.textColor,
    this.borderWidth,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.enableGlow = true,
    this.glowColor,
    this.glowIntensity = 0.3,
    this.enableScale = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return ModernButton(
      text: text,
      onPressed: onPressed,
      onLongPress: onLongPress,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
      trailingIcon: trailingIcon,
      backgroundColor: Colors.transparent,
      textColor: textColor ?? ModernColors.electricBlue,
      borderColor: borderColor ?? ModernColors.electricBlue,
      borderWidth: borderWidth ?? 2.0,
      width: width,
      height: height,
      padding: padding,
      borderRadius: borderRadius,
      fontSize: fontSize,
      fontWeight: fontWeight,
      enableGlow: enableGlow,
      glowColor: glowColor ?? ModernColors.electricBlue,
      glowIntensity: glowIntensity,
      enableScale: enableScale,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
    );
  }
}

class ModernTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final IconData? trailingIcon;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool enableGlow;
  final Color? glowColor;
  final double glowIntensity;
  final bool enableScale;
  final Duration animationDuration;
  final Curve animationCurve;

  const ModernTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.onLongPress,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.trailingIcon,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.enableGlow = false,
    this.glowColor,
    this.glowIntensity = 0.3,
    this.enableScale = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return ModernButton(
      text: text,
      onPressed: onPressed,
      onLongPress: onLongPress,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
      trailingIcon: trailingIcon,
      backgroundColor: Colors.transparent,
      textColor: textColor ?? ModernColors.electricBlue,
      borderColor: Colors.transparent,
      borderWidth: 0,
      width: width,
      height: height,
      padding: padding,
      borderRadius: borderRadius,
      fontSize: fontSize,
      fontWeight: fontWeight,
      enableGlow: enableGlow,
      glowColor: glowColor,
      glowIntensity: glowIntensity,
      enableScale: enableScale,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
    );
  }
}

class ModernGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final IconData? trailingIcon;
  final Gradient gradient;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool enableGlow;
  final Color? glowColor;
  final double glowIntensity;
  final bool enableScale;
  final Duration animationDuration;
  final Curve animationCurve;

  const ModernGradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.onLongPress,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.trailingIcon,
    required this.gradient,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.enableGlow = true,
    this.glowColor,
    this.glowIntensity = 0.3,
    this.enableScale = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return ModernButton(
      text: text,
      onPressed: onPressed,
      onLongPress: onLongPress,
      isLoading: isLoading,
      isEnabled: isEnabled,
      icon: icon,
      trailingIcon: trailingIcon,
      gradient: gradient,
      textColor: textColor ?? ModernColors.textPrimary,
      width: width,
      height: height,
      padding: padding,
      borderRadius: borderRadius,
      fontSize: fontSize,
      fontWeight: fontWeight,
      enableGlow: enableGlow,
      glowColor: glowColor,
      glowIntensity: glowIntensity,
      enableScale: enableScale,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
    );
  }
} 