import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      height: 12.h,
      constraints: BoxConstraints(
        minWidth: 100,
        minHeight: 100,
        maxWidth: 120,
        maxHeight: 120,
      ),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'shopping_cart',
            size: 32,
            color: AppTheme.lightTheme.colorScheme.onPrimary,
          ),
          SizedBox(height: 1.h),
          Text(
            'Urban',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onPrimary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            'Harvest',
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onPrimary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
