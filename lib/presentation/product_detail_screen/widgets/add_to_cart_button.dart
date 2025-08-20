import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class AddToCartButton extends StatelessWidget {
  final String totalPrice;
  final VoidCallback onPressed;
  final bool isLoading;

  const AddToCartButton({
    Key? key,
    required this.totalPrice,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  HapticFeedback.mediumImpact();
                  onPressed();
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.lightTheme.colorScheme.primary,
            foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.w),
            ),
            elevation: 2,
          ),
          child: isLoading
              ? SizedBox(
                  height: 6.w,
                  width: 6.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.lightTheme.colorScheme.onPrimary,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'shopping_cart',
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      size: 5.w,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'Add to Cart - $totalPrice',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
