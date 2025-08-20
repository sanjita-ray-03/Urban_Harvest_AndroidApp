import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SavedItemWidget extends StatelessWidget {
  final String name;
  final String price;
  final String originalPrice;
  final String imageUrl;
  final bool inStock;
  final VoidCallback? onAddToCart;
  final VoidCallback? onRemove;

  const SavedItemWidget({
    super.key,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.inStock,
    this.onAddToCart,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow.withAlpha(26),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
                color: AppTheme.lightTheme.colorScheme.outline.withAlpha(51),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.w),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color:
                        AppTheme.lightTheme.colorScheme.outline.withAlpha(51),
                    child: CustomIconWidget(
                      iconName: 'image',
                      size: 8.w,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 3.w),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 1.h),

                  Row(
                    children: [
                      Text(
                        price,
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.lightTheme.colorScheme.primary,
                        ),
                      ),
                      if (originalPrice.isNotEmpty) ...[
                        SizedBox(width: 2.w),
                        Text(
                          originalPrice,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),

                  SizedBox(height: 1.h),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: inStock
                              ? AppTheme.lightTheme.colorScheme.tertiary
                                  .withAlpha(26)
                              : AppTheme.lightTheme.colorScheme.error
                                  .withAlpha(26),
                          borderRadius: BorderRadius.circular(1.5.w),
                        ),
                        child: Text(
                          inStock ? 'In Stock' : 'Out of Stock',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: inStock
                                ? AppTheme.lightTheme.colorScheme.tertiary
                                : AppTheme.lightTheme.colorScheme.error,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onRemove != null
                              ? () {
                                  HapticFeedback.lightImpact();
                                  onRemove!();
                                }
                              : null,
                          icon: CustomIconWidget(
                            iconName: 'delete',
                            size: 4.w,
                            color: AppTheme.lightTheme.colorScheme.error,
                          ),
                          label: Text(
                            'Remove',
                            style: TextStyle(
                              color: AppTheme.lightTheme.colorScheme.error,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppTheme.lightTheme.colorScheme.error,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: inStock && onAddToCart != null
                              ? () {
                                  HapticFeedback.lightImpact();
                                  onAddToCart!();
                                }
                              : null,
                          icon: CustomIconWidget(
                            iconName: 'add_shopping_cart',
                            size: 4.w,
                            color: AppTheme.lightTheme.colorScheme.onPrimary,
                          ),
                          label: Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
