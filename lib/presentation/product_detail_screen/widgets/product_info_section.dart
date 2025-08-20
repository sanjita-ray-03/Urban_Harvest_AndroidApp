import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ProductInfoSection extends StatelessWidget {
  final String productName;
  final String brand;
  final String price;
  final String originalPrice;
  final double rating;
  final int reviewCount;
  final String stockStatus;

  const ProductInfoSection({
    Key? key,
    required this.productName,
    required this.brand,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.stockStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            brand,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            productName,
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Text(
                price,
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 2.w),
              originalPrice.isNotEmpty
                  ? Text(
                      originalPrice,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return CustomIconWidget(
                    iconName: index < rating.floor() ? 'star' : 'star_border',
                    color: AppTheme.lightTheme.colorScheme.secondary,
                    size: 4.w,
                  );
                }),
              ),
              SizedBox(width: 2.w),
              Text(
                rating.toString(),
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 1.w),
              Text(
                '($reviewCount reviews)',
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: _getStatusColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.w),
              border: Border.all(
                color: _getStatusColor(),
                width: 1,
              ),
            ),
            child: Text(
              stockStatus,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: _getStatusColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (stockStatus.toLowerCase()) {
      case 'in stock':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'low stock':
        return AppTheme.warningLight;
      case 'out of stock':
        return AppTheme.lightTheme.colorScheme.error;
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }
}
