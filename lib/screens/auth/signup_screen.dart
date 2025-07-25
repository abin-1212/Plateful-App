import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/firebase_service.dart';
import '../../widgets/modern_text_field.dart';
import '../../widgets/modern_dropdown.dart';
import '../../widgets/modern_button.dart';
import '../../widgets/modern_error.dart';
import '../../widgets/modern_scaffold.dart';
import '../../constants/app_constants.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animations/animations.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _role = AppRoles.user;
  bool _loading = false;
  String? _error;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    WidgetsBinding.instance.addPostFrameCallback((_) => _animController.forward());
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await FirebaseService().signUpWithEmail(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        role: _role!,
      );
      if (user != null) {
        if (_role == AppRoles.user) {
          if (mounted) context.go('/dashboard/user');
        } else if (_role == AppRoles.vendor) {
          if (mounted) context.go('/dashboard/vendor');
        } else if (_role == AppRoles.admin) {
          if (mounted) context.go('/dashboard/admin');
        }
      } else {
        setState(() => _error = 'Signup failed.');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Animated pastel gradient background
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFe0eafc),
                  const Color(0xFFcfdef3),
                  const Color(0xFFf5f7fa),
                  const Color(0xFFc9e7ff),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/hero_food_bg.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
                colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.18), BlendMode.lighten),
              ),
            ),
            child: Stack(
              children: [
                // Soft white overlay for balance
                Container(
                  color: Colors.white.withOpacity(0.22),
                ),
              ],
            ),
          ),
          // Centered glassmorphic card with fade/slide animation
          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      double cardWidth;
                      EdgeInsets cardPadding;
                      if (width < 600) {
                        cardWidth = width * 0.96;
                        cardPadding = const EdgeInsets.symmetric(vertical: 28, horizontal: 10);
                      } else if (width < 900) {
                        cardWidth = 420;
                        cardPadding = const EdgeInsets.symmetric(vertical: 36, horizontal: 32);
                      } else {
                        cardWidth = 500;
                        cardPadding = const EdgeInsets.symmetric(vertical: 48, horizontal: 48);
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        clipBehavior: Clip.antiAlias,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                          child: Container(
                            width: cardWidth,
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height * 0.90,
                              minHeight: 0,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            padding: cardPadding,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.32),
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.10),
                                  blurRadius: 48,
                                  offset: Offset(0, 16),
                                ),
                              ],
                              border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.5),
                            ),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Glowing Plateful logo
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 18),
                                    child: Text(
                                      'Plateful',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.headline.copyWith(
                                        fontSize: 38,
                                        color: AppColors.primary,
                                        shadows: [
                                          Shadow(
                                            color: AppColors.primary.withOpacity(0.32),
                                            blurRadius: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text('Sign Up', style: AppTextStyles.headline.copyWith(fontSize: 32, color: AppColors.textDark), textAlign: TextAlign.center),
                                  const SizedBox(height: 32),
                                  // Neumorphic input fields with icons
                                  _NeumorphicInput(
                                    icon: Icons.person_outline,
                                    label: 'Name',
                                    controller: _nameController,
                                    enabled: !_loading,
                                  ),
                                  _NeumorphicInput(
                                    icon: Icons.email_outlined,
                                    label: 'Email',
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    enabled: !_loading,
                                  ),
                                  _NeumorphicInput(
                                    icon: Icons.lock_outline,
                                    label: 'Password',
                                    controller: _passwordController,
                                    isPassword: true,
                                    enabled: !_loading,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: ModernDropdown<String>(
                                      label: 'Role',
                                      value: _role,
                                      items: const [
                                        DropdownMenuItem(value: AppRoles.user, child: Text('User')),
                                        DropdownMenuItem(value: AppRoles.vendor, child: Text('Vendor')),
                                        DropdownMenuItem(value: AppRoles.admin, child: Text('Admin')),
                                      ],
                                      onChanged: (val) { if (!_loading) setState(() => _role = val); },
                                      enabled: !_loading,
                                    ),
                                  ),
                                  if (_error != null) ...[
                                    const SizedBox(height: 12),
                                    ModernError(message: _error!),
                                  ],
                                  const SizedBox(height: 24),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 350),
                                    child: _AnimatedSignUpButton(
                                      key: ValueKey(_loading),
                                      loading: _loading,
                                      onPressed: _loading ? null : _signup,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  TextButton(
                                    onPressed: _loading ? null : () => context.go('/login'),
                                    child: const Text('Already have an account? Sign In'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Neumorphic input with icon
class _NeumorphicInput extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? keyboardType;
  final bool enabled;
  const _NeumorphicInput({
    required this.icon,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.enabled = true,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.65),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.10),
              blurRadius: 16,
              offset: Offset(4, 8),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              blurRadius: 8,
              offset: Offset(-4, -4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          enabled: enabled,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary.withOpacity(0.85)),
            labelText: label,
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          ),
        ),
      ),
    );
  }
}

// Animated Sign Up button
class _AnimatedSignUpButton extends StatefulWidget {
  final bool loading;
  final VoidCallback? onPressed;
  const _AnimatedSignUpButton({super.key, required this.loading, this.onPressed});
  @override
  State<_AnimatedSignUpButton> createState() => _AnimatedSignUpButtonState();
}
class _AnimatedSignUpButtonState extends State<_AnimatedSignUpButton> {
  bool _hovering = false;
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    final scale = _pressed ? 0.96 : (_hovering ? 1.04 : 1.0);
    final glow = _hovering
        ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.32),
              blurRadius: 32,
              spreadRadius: 2,
            ),
          ]
        : null;
    Widget button = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      width: double.infinity,
      height: 56,
      transform: Matrix4.identity()..scale(scale, scale),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(28),
        boxShadow: glow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: widget.onPressed,
          onHighlightChanged: (v) => setState(() => _pressed = v),
          child: Center(
            child: widget.loading
                ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
                : Text('Sign Up', style: AppTextStyles.button),
          ),
        ),
      ),
    );
    button = MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: button,
    );
    return button;
  }
} 