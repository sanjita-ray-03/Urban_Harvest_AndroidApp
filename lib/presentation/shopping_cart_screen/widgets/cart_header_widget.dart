import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class CartHeaderWidget extends StatelessWidget {
  final int itemCount;
  final String estimatedDeliveryTime;

  const CartHeaderWidget({
    Key? key,
    required this.itemCount,
    required this.estimatedDeliveryTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Item Count
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'shopping_cart',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 6.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    '$itemCount ${itemCount == 1 ? 'Item' : 'Items'}',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              // Delivery Time
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'access_time',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 4.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      estimatedDeliveryTime,
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 1.h),

          // Delivery Info Banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'local_shipping',
                  color: AppTheme.lightTheme.colorScheme.tertiary,
                  size: 5.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Free Delivery on orders above \$50',
                        style:
                            AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.tertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Add more items to qualify for free delivery',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme
                              .lightTheme.colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
