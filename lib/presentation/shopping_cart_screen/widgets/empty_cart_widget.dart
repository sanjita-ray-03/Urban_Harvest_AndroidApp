import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class EmptyCartWidget extends StatelessWidget {
  final VoidCallback onStartShopping;

  const EmptyCartWidget({
    Key? key,
    required this.onStartShopping,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty Cart Illustration
            Container(
              width: 50.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'shopping_cart_outlined',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20.w,
                  ),
                  SizedBox(height: 2.h),
                  CustomIconWidget(
                    iconName: 'sentiment_dissatisfied',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 8.w,
                  ),
                ],
              ),
            ),

            SizedBox(height: 4.h),

            // Empty State Text
            Text(
              'Your Cart is Empty',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 1.h),

            Text(
              'Looks like you haven\'t added anything to your cart yet. Start shopping to fill it up!',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 4.h),

            // Start Shopping Button
            SizedBox(
              width: double.infinity,
              height: 6.h,
              child: ElevatedButton.icon(
                onPressed: onStartShopping,
                icon: CustomIconWidget(
                  iconName: 'shopping_bag',
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                  size: 5.w,
                ),
                label: Text(
                  'Start Shopping',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Browse Categories
            OutlinedButton.icon(
              onPressed: onStartShopping,
              icon: CustomIconWidget(
                iconName: 'category',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 5.w,
              ),
              label: Text(
                'Browse Categories',
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
