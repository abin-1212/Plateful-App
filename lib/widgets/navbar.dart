import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import 'primary_button.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  Navbar({Key? key}) : super(key: key);

  final List<_NavItem> navItems = const [
    _NavItem('Home', '/'),
    _NavItem('Packs', '/packs'),
    _NavItem('About', '/about'),
    _NavItem('Blog', '/blog'),
    _NavItem('Reviews', '/reviews'),
    _NavItem('FAQ', '/faq'),
    _NavItem('Contact', '/contact'),
    _NavItem('Careers', '/careers'),
    _NavItem('Download', '/download'),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 48, vertical: 8),
        constraints: BoxConstraints(maxWidth: 1440),
        child: Row(
          children: [
            // Logo
            GestureDetector(
              onTap: () => context.go('/'),
              child: Row(
                children: [
                  // Replace with your logo asset if available
                  Icon(Icons.restaurant_menu, color: PlatefulColors.primaryGradientStart, size: 32),
                  SizedBox(width: 10),
                  Text(
                    'Plateful',
                    style: GoogleFonts.poppins(
                      color: PlatefulColors.primaryGradientStart,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            if (!isMobile)
              Row(
                children: [
                  ...navItems.map((item) => _NavLink(item: item)),
                  SizedBox(width: 16),
                  PrimaryButton(
                    label: 'Get Started',
                    onPressed: () => context.go('/signup'),
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ],
              )
            else
              _MobileMenu(navItems: navItems),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(64);
}

class _NavItem {
  final String label;
  final String route;
  const _NavItem(this.label, this.route);
}

class _NavLink extends StatelessWidget {
  final _NavItem item;
  const _NavLink({required this.item});

  @override
  Widget build(BuildContext context) {
    // Remove isActive logic or use a fallback if not available
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => context.go(item.route),
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 120),
          style: GoogleFonts.poppins(
            color: PlatefulColors.textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          child: Text(item.label),
        ),
      ),
    );
  }
}

class _MobileMenu extends StatefulWidget {
  final List<_NavItem> navItems;
  const _MobileMenu({required this.navItems});

  @override
  State<_MobileMenu> createState() => _MobileMenuState();
}

class _MobileMenuState extends State<_MobileMenu> {
  bool open = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(open ? Icons.close : Icons.menu, color: PlatefulColors.primaryGradientStart, size: 32),
          onPressed: () => setState(() => open = !open),
        ),
        if (open)
          Positioned(
            right: 0,
            top: 48,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 220,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: PlatefulColors.primaryGradientStart.withOpacity(0.08),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...widget.navItems.map((item) => ListTile(
                          title: Text(
                            item.label,
                            style: GoogleFonts.poppins(
                              color: PlatefulColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            setState(() => open = false);
                            context.go(item.route);
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: PrimaryButton(
                        label: 'Get Started',
                        onPressed: () {
                          setState(() => open = false);
                          context.go('/signup');
                        },
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
} 