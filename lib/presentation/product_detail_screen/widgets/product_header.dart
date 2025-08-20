import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ProductHeader extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onSharePressed;
  final VoidCallback onWishlistPressed;
  final bool isWishlisted;

  const ProductHeader({
    Key? key,
    required this.onBackPressed,
    required this.onSharePressed,
    required this.onWishlistPressed,
    required this.isWishlisted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onBackPressed,
              child: Container(
                width: 10.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(2.w),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.shadowLight,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'arrow_back',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 6.w,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: onSharePressed,
                  child: Container(
                    width: 10.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(2.w),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.shadowLight,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'share',
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        size: 5.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                GestureDetector(
                  onTap: onWishlistPressed,
                  child: Container(
                    width: 10.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(2.w),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.shadowLight,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: isWishlisted ? 'favorite' : 'favorite_border',
                        color: isWishlisted
                            ? AppTheme.lightTheme.colorScheme.error
                            : AppTheme.lightTheme.colorScheme.onSurface,
                        size: 5.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
