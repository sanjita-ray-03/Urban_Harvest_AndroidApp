import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './social_login_button.dart';

class SocialLoginSection extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onGoogleLogin;
  final VoidCallback onAppleLogin;
  final VoidCallback onFacebookLogin;

  const SocialLoginSection({
    super.key,
    required this.isLoading,
    required this.onGoogleLogin,
    required this.onAppleLogin,
    required this.onFacebookLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                'Or continue with',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
                  fontSize: 12.sp,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SocialLoginButton(
              iconName: 'g_translate',
              label: 'Google',
              onPressed: isLoading ? () {} : onGoogleLogin,
              backgroundColor: AppTheme.lightTheme.colorScheme.surface,
              textColor: AppTheme.lightTheme.colorScheme.onSurface,
            ),
            SocialLoginButton(
              iconName: 'apple',
              label: 'Apple',
              onPressed: isLoading ? () {} : onAppleLogin,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            ),
            SocialLoginButton(
              iconName: 'facebook',
              label: 'Facebook',
              onPressed: isLoading ? () {} : onFacebookLogin,
              backgroundColor: const Color(0xFF1877F2),
              textColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
