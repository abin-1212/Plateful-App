import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ModernFooter extends StatelessWidget {
  const ModernFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Container(
      margin: const EdgeInsets.only(top: 48),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32 : 40,
        horizontal: isMobile ? 16 : 48,
      ),
      decoration: BoxDecoration(
        gradient: AppGradients.glass,
        borderRadius: BorderRadius.circular(32),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo and nav
          isMobile
              ? Column(
                  children: [
                    _FooterLogo(),
                    const SizedBox(height: 24),
                    _FooterNav(isMobile: true),
                    const SizedBox(height: 24),
                    _FooterSocial(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _FooterLogo(),
                    _FooterNav(isMobile: false),
                    _FooterSocial(),
                  ],
                ),
          const SizedBox(height: 32),
          Divider(color: AppColors.glassBorder, thickness: 1, height: 1),
          const SizedBox(height: 18),
          Text(
            '© 2024 Plateful. All rights reserved.',
            style: AppTextStyles.body.copyWith(fontSize: 14, color: AppColors.textLight),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FooterLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Plateful',
      style: AppTextStyles.headline.copyWith(
        fontSize: 28,
        color: AppColors.primary,
        letterSpacing: -1.2,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _FooterNav extends StatelessWidget {
  final bool isMobile;
  const _FooterNav({required this.isMobile});
  @override
  Widget build(BuildContext context) {
    final navLinks = [
      {'label': 'Home', 'onTap': () {/* TODO: Implement navigation */}},
      {'label': 'About', 'onTap': () {/* TODO: Implement navigation */}},
      {'label': 'Contact', 'onTap': () {/* TODO: Implement navigation */}},
      {'label': 'Privacy', 'onTap': () {/* TODO: Implement navigation */}},
    ];
    return isMobile
        ? Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            children: navLinks
                .map((link) => TextButton(
                      onPressed: link['onTap'] as void Function(),
                      child: Text(link['label'] as String, style: AppTextStyles.body.copyWith(fontSize: 15)),
                    ))
                .toList(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: navLinks
                .map((link) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextButton(
                        onPressed: link['onTap'] as void Function(),
                        child: Text(link['label'] as String, style: AppTextStyles.body.copyWith(fontSize: 15)),
                      ),
                    ))
                .toList(),
          );
  }
}

class _FooterSocial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.facebook, size: 28, color: AppColors.textLight),
          onPressed: () {},
          tooltip: 'Facebook',
        ),
        IconButton(
          icon: const Icon(Icons.alternate_email, size: 28, color: AppColors.textLight),
          onPressed: () {},
          tooltip: 'Twitter',
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt, size: 28, color: AppColors.textLight),
          onPressed: () {},
          tooltip: 'Instagram',
        ),
      ],
    );
  }
} 