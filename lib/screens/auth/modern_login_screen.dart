import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/firebase_service.dart';
import '../../widgets/modern_text_field.dart';
import '../../widgets/modern_button.dart';
import '../../widgets/modern_error.dart';
import '../../widgets/modern_scaffold.dart';
import '../../constants/app_constants.dart';

class ModernLoginScreen extends StatefulWidget {
  const ModernLoginScreen({super.key});

  @override
  State<ModernLoginScreen> createState() => _ModernLoginScreenState();
}

class _ModernLoginScreenState extends State<ModernLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await FirebaseService().signInWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (user != null) {
        final role = await FirebaseService().getUserRole(user.uid);
        if (role == AppRoles.user) {
          if (mounted) context.go('/dashboard/user');
        } else if (role == AppRoles.vendor) {
          if (mounted) context.go('/dashboard/vendor');
        } else if (role == AppRoles.admin) {
          if (mounted) context.go('/dashboard/admin');
        } else {
          setState(() => _error = 'Unknown user role.');
        }
      } else {
        setState(() => _error = 'Login failed.');
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
    return ModernScaffold(
      centerContent: true,
      child: Center(
          child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
                  child: Container(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 32 : 48,
                horizontal: isMobile ? 16 : 32,
                      ),
                      decoration: BoxDecoration(
                gradient: AppGradients.glass,
                borderRadius: BorderRadius.circular(32),
                boxShadow: AppShadows.glass,
              ),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Text('Plateful', style: AppTextStyles.headline.copyWith(fontSize: 32, color: AppColors.primary), textAlign: TextAlign.center),
                  const SizedBox(height: 32),
                  Text('Sign In', style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
                  const SizedBox(height: 32),
                  ModernTextField(label: 'Email', controller: _emailController, keyboardType: TextInputType.emailAddress),
                  ModernTextField(label: 'Password', controller: _passwordController, isPassword: true),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    ModernError(message: _error!),
                  ],
                  const SizedBox(height: 24),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: ModernButton(
                      key: ValueKey(_loading),
                      text: _loading ? 'Signing In...' : 'Sign In',
                      onPressed: _loading ? null : _login,
                      isPrimary: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: _loading ? null : () => context.go('/signup'),
                    child: const Text('Don\'t have an account? Sign Up'),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 