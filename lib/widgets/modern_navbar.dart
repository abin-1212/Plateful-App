import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ModernNavbar extends StatelessWidget {
  final List<ModernNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const ModernNavbar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      decoration: BoxDecoration(
        gradient: AppGradients.glass,
        borderRadius: BorderRadius.circular(32),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(items.length, (index) {
          final selected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onItemSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary.withOpacity(0.12) : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Icon(items[index].icon, color: selected ? AppColors.primary : AppColors.textDark, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    items[index].label,
                    style: AppTextStyles.body.copyWith(
                      color: selected ? AppColors.primary : AppColors.textDark,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ModernNavItem {
  final String label;
  final IconData icon;

  ModernNavItem({required this.label, required this.icon});
} 