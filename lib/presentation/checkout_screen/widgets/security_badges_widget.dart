import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SecurityBadgesWidget extends StatelessWidget {
  const SecurityBadgesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSecurityBadge(
            'security',
            'SSL Secured',
            AppTheme.lightTheme.colorScheme.tertiary,
          ),
          Container(
            width: 1,
            height: 6.h,
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          ),
          _buildSecurityBadge(
            'verified',
            'Verified Safe',
            AppTheme.lightTheme.colorScheme.primary,
          ),
          Container(
            width: 1,
            height: 6.h,
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          ),
          _buildSecurityBadge(
            'lock',
            'Protected',
            AppTheme.lightTheme.colorScheme.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityBadge(String iconName, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: color,
          size: 24,
        ),
        SizedBox(height: 1.h),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
