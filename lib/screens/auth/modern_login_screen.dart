import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../themes/modern_theme.dart';
import '../../widgets/modern/glass_card.dart';
import '../../widgets/modern/modern_button.dart';
import '../../constants/app_constants.dart';

class ModernLoginScreen extends StatefulWidget {
  const ModernLoginScreen({super.key});

  @override
  State<ModernLoginScreen> createState() => _ModernLoginScreenState();
}

class _ModernLoginScreenState extends State<ModernLoginScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;
  
  int _selectedRoleIndex = 0;
  final List<LoginRole> _roles = [
    LoginRole(
      title: 'User',
      subtitle: 'Find amazing food deals',
      icon: Icons.person,
      color: ModernColors.electricBlue,
      role: UserRoles.user,
    ),
    LoginRole(
      title: 'Vendor',
      subtitle: 'List your surplus food',
      icon: Icons.store,
      color: ModernColors.neonPurple,
      role: UserRoles.vendor,
    ),
    LoginRole(
      title: 'Admin',
      subtitle: 'Manage the platform',
      icon: Icons.admin_panel_settings,
      color: ModernColors.mintGreen,
      role: UserRoles.admin,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _roles.length, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRoleChanged(int index) {
    setState(() {
      _selectedRoleIndex = index;
    });
    _tabController.animateTo(index);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleRememberMe() {
    setState(() {
      _rememberMe = !_rememberMe;
    });
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement actual login logic
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        // Navigate based on role
        final role = _roles[_selectedRoleIndex].role;
        switch (role) {
          case UserRoles.user:
            Navigator.pushReplacementNamed(context, AppRoutes.userDashboard);
            break;
          case UserRoles.vendor:
            Navigator.pushReplacementNamed(context, AppRoutes.vendorDashboard);
            break;
          case UserRoles.admin:
            Navigator.pushReplacementNamed(context, AppRoutes.adminDashboard);
            break;
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
            backgroundColor: ModernColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToSignup() {
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  void _navigateToForgotPassword() {
    Navigator.pushNamed(context, AppRoutes.forgotPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: ModernGradients.darkGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ModernSpacing.lg),
            child: Column(
              children: [
                // Header
                _buildHeader(),
                
                const SizedBox(height: ModernSpacing.xxl),
                
                // Role selection tabs
                _buildRoleTabs(),
                
                const SizedBox(height: ModernSpacing.xl),
                
                // Login form
                _buildLoginForm(),
                
                const SizedBox(height: ModernSpacing.xl),
                
                // Social login options
                _buildSocialLogin(),
                
                const SizedBox(height: ModernSpacing.xl),
                
                // Sign up link
                _buildSignupLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Column(
              children: [
                // Logo
                GlassCard(
                  width: 80,
                  height: 80,
                  borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ModernBorderRadius.full),
                      gradient: ModernGradients.primaryGradient,
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      color: ModernColors.textPrimary,
                      size: 40,
                    ),
                  ),
                ),
                
                const SizedBox(height: ModernSpacing.lg),
                
                // Welcome text
                Text(
                  'Welcome Back',
                  style: ModernTextStyles.displayMedium,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: ModernSpacing.sm),
                
                Text(
                  'Sign in to continue your journey',
                  style: ModernTextStyles.bodyLarge.copyWith(
                    color: ModernColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoleTabs() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: GlassCard(
            padding: const EdgeInsets.all(ModernSpacing.sm),
            child: Row(
              children: _roles.asMap().entries.map((entry) {
                final index = entry.key;
                final role = entry.value;
                final isSelected = _selectedRoleIndex == index;
                
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onRoleChanged(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        vertical: ModernSpacing.md,
                        horizontal: ModernSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ModernBorderRadius.lg),
                        gradient: isSelected ? LinearGradient(
                          colors: [role.color, role.color.withOpacity(0.7)],
                        ) : null,
                        color: isSelected ? null : Colors.transparent,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            role.icon,
                            color: isSelected ? ModernColors.textPrimary : role.color,
                            size: 24,
                          ),
                          const SizedBox(height: ModernSpacing.xs),
                          Text(
                            role.title,
                            style: ModernTextStyles.labelMedium.copyWith(
                              color: isSelected ? ModernColors.textPrimary : role.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginForm() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: GlassCard(
              padding: const EdgeInsets.all(ModernSpacing.xl),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: ModernSpacing.lg),
                    
                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: ModernSpacing.lg),
                    
                    // Remember me and forgot password
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _toggleRememberMe,
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(ModernBorderRadius.xs),
                                  border: Border.all(
                                    color: _rememberMe ? ModernColors.electricBlue : ModernColors.textTertiary,
                                    width: 2,
                                  ),
                                  color: _rememberMe ? ModernColors.electricBlue : Colors.transparent,
                                ),
                                child: _rememberMe
                                    ? const Icon(
                                        Icons.check,
                                        color: ModernColors.textPrimary,
                                        size: 14,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: ModernSpacing.sm),
                              Text(
                                'Remember me',
                                style: ModernTextStyles.bodyMedium.copyWith(
                                  color: ModernColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        ModernTextButton(
                          text: 'Forgot Password?',
                          onPressed: _navigateToForgotPassword,
                          textColor: ModernColors.electricBlue,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: ModernSpacing.xl),
                    
                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: ModernGradientButton(
                        text: _isLoading ? 'Signing In...' : 'Sign In',
                        gradient: LinearGradient(
                          colors: [
                            _roles[_selectedRoleIndex].color,
                            _roles[_selectedRoleIndex].color.withOpacity(0.7),
                          ],
                        ),
                        onPressed: _isLoading ? null : _handleLogin,
                        isLoading: _isLoading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialLogin() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Divider(color: ModernColors.textTertiary)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: ModernSpacing.lg),
                    child: Text(
                      'Or continue with',
                      style: ModernTextStyles.bodyMedium.copyWith(
                        color: ModernColors.textTertiary,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: ModernColors.textTertiary)),
                ],
              ),
              
              const SizedBox(height: ModernSpacing.lg),
              
              Row(
                children: [
                  Expanded(
                    child: ModernOutlinedButton(
                      text: 'Google',
                      onPressed: () {
                        // TODO: Implement Google sign in
                      },
                      icon: Icons.g_mobiledata,
                    ),
                  ),
                  const SizedBox(width: ModernSpacing.md),
                  Expanded(
                    child: ModernOutlinedButton(
                      text: 'Apple',
                      onPressed: () {
                        // TODO: Implement Apple sign in
                      },
                      icon: Icons.apple,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSignupLink() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: ModernTextStyles.bodyMedium.copyWith(
                  color: ModernColors.textSecondary,
                ),
              ),
              ModernTextButton(
                text: 'Sign Up',
                onPressed: _navigateToSignup,
                textColor: ModernColors.electricBlue,
              ),
            ],
          ),
        );
      },
    );
  }
}

class LoginRole {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String role;

  LoginRole({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.role,
  });
} 