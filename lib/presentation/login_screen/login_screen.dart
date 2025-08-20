import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/app_logo.dart';
import './widgets/login_form.dart';
import './widgets/social_login_section.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'customer@urbanharvest.com': 'customer123',
    'admin@urbanharvest.com': 'admin123',
    'demo@urbanharvest.com': 'demo123',
  };

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Check mock credentials
    if (_mockCredentials.containsKey(email) &&
        _mockCredentials[email] == password) {
      // Success - trigger haptic feedback
      HapticFeedback.lightImpact();

      setState(() {
        _isLoading = false;
      });

      // Navigate to home screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home-screen');
      }
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Invalid email or password. Please try again.';
      });

      // Show error snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _errorMessage!,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onError,
              ),
            ),
            backgroundColor: AppTheme.lightTheme.colorScheme.error,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(4.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
  }

  void _handleForgotPassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Forgot Password',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        content: Text(
          'Password reset functionality will be implemented in the next version. Please contact support for assistance.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSocialLogin(String provider) {
    if (_isLoading) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$provider login will be implemented in the next version.',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _handleSignUp() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sign up functionality will be implemented in the next version.',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.h),
                    // App Logo
                    const AppLogo(),
                    SizedBox(height: 4.h),

                    // Welcome Text
                    Text(
                      'Welcome Back!',
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Sign in to continue your grocery shopping',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.7),
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5.h),

                    // Login Form
                    LoginForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      formKey: _formKey,
                      isLoading: _isLoading,
                      onLogin: _handleLogin,
                      onForgotPassword: _handleForgotPassword,
                    ),
                    SizedBox(height: 5.h),

                    // Social Login Section
                    SocialLoginSection(
                      isLoading: _isLoading,
                      onGoogleLogin: () => _handleSocialLogin('Google'),
                      onAppleLogin: () => _handleSocialLogin('Apple'),
                      onFacebookLogin: () => _handleSocialLogin('Facebook'),
                    ),
                    SizedBox(height: 6.h),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New user? ',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                            fontSize: 14.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: _isLoading ? null : _handleSignUp,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            minimumSize: Size(15.w, 5.h),
                          ),
                          child: Text(
                            'Sign Up',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
