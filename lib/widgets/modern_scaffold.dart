import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'modern_navbar.dart';

class ModernScaffold extends StatelessWidget {
  final Widget child;
  final List<ModernNavItem>? navItems;
  final int? selectedIndex;
  final ValueChanged<int>? onNavSelected;
  final bool centerContent;

  const ModernScaffold({
    super.key,
    required this.child,
    this.navItems,
    this.selectedIndex,
    this.onNavSelected,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.background,
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (navItems != null && selectedIndex != null && onNavSelected != null)
                ModernNavbar(
                  items: navItems!,
                  selectedIndex: selectedIndex!,
                  onItemSelected: onNavSelected!,
                ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: centerContent
                      ? Center(child: child)
                      : child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 