import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'modern_responsive.dart';

class ModernSection extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final bool center;

  const ModernSection({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.center = true,
  });

  @override
  Widget build(BuildContext context) {
    return ModernResponsive(
      builder: (context, deviceType) {
        double width = MediaQuery.of(context).size.width;
        double maxW = maxWidth ?? (deviceType == ModernDeviceType.desktop
            ? 1100
            : deviceType == ModernDeviceType.tablet
                ? 800
                : width - 32);
        EdgeInsetsGeometry pad = padding ?? EdgeInsets.symmetric(
          vertical: deviceType == ModernDeviceType.desktop ? 64 : 32,
          horizontal: deviceType == ModernDeviceType.desktop ? 48 : 16,
        );
        Widget content = Container(
          constraints: BoxConstraints(maxWidth: maxW),
          padding: pad,
          child: child,
        );
        return center ? Center(child: content) : content;
      },
    );
  }
} 