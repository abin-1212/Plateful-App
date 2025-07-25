import 'package:flutter/material.dart';

class ModernResponsive extends StatelessWidget {
  final Widget Function(BuildContext context, ModernDeviceType deviceType) builder;

  const ModernResponsive({super.key, required this.builder});

  static ModernDeviceType deviceTypeOf(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1100) return ModernDeviceType.desktop;
    if (width >= 700) return ModernDeviceType.tablet;
    return ModernDeviceType.mobile;
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = deviceTypeOf(context);
    return builder(context, deviceType);
  }
}

enum ModernDeviceType { mobile, tablet, desktop } 