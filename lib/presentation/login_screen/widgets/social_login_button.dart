import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SocialLoginButton extends StatelessWidget {
  final String iconName;
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const SocialLoginButton({
    super.key,
    required this.iconName,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 6.h,
      constraints: BoxConstraints(
        minHeight: 48,
        minWidth: 100.w / 3.2,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? AppTheme.lightTheme.colorScheme.surface,
          foregroundColor:
              textColor ?? AppTheme.lightTheme.colorScheme.onSurface,
          elevation: 1,
          shadowColor: AppTheme.lightTheme.colorScheme.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: iconName,
              size: 20,
              color: textColor ?? AppTheme.lightTheme.colorScheme.onSurface,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: textColor ?? AppTheme.lightTheme.colorScheme.onSurface,
                fontSize: 10.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
