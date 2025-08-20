import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './custom_text_field.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.isLoading,
    required this.onLogin,
    required this.onForgotPassword,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  bool get _isFormValid {
    return widget.emailController.text.isNotEmpty &&
        widget.passwordController.text.isNotEmpty &&
        _validateEmail(widget.emailController.text) == null &&
        _validatePassword(widget.passwordController.text) == null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Email Address',
            hint: 'Enter your email',
            iconName: 'email',
            keyboardType: TextInputType.emailAddress,
            controller: widget.emailController,
            validator: _validateEmail,
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 3.h),
          CustomTextField(
            label: 'Password',
            hint: 'Enter your password',
            iconName: 'lock',
            isPassword: true,
            controller: widget.passwordController,
            validator: _validatePassword,
            enabled: !widget.isLoading,
          ),
          SizedBox(height: 2.h),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: widget.isLoading ? null : widget.onForgotPassword,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                minimumSize: Size(20.w, 5.h),
              ),
              child: Text(
                'Forgot Password?',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: double.infinity,
            height: 6.h,
            constraints: BoxConstraints(
              minHeight: 48,
            ),
            child: ElevatedButton(
              onPressed:
                  (widget.isLoading || !_isFormValid) ? null : widget.onLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormValid && !widget.isLoading
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.6),
                foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
                elevation: _isFormValid && !widget.isLoading ? 2 : 0,
                shadowColor: AppTheme.lightTheme.colorScheme.shadow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
              ),
              child: widget.isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.lightTheme.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : Text(
                      'Login',
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
