import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class RecentlyViewedWidget extends StatelessWidget {
  final List<Map<String, dynamic>> recentlyViewedItems;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(Map<String, dynamic>) onProductTap;

  const RecentlyViewedWidget({
    Key? key,
    required this.recentlyViewedItems,
    required this.onAddToCart,
    required this.onProductTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (recentlyViewedItems.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'history',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 6.w,
                ),
                SizedBox(width: 3.w),
                Text(
                  'Recently Viewed',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Horizontal List
          SizedBox(
            height: 35.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recentlyViewedItems.length,
              separatorBuilder: (context, index) => SizedBox(width: 3.w),
              itemBuilder: (context, index) {
                final item = recentlyViewedItems[index];
                return _buildRecentlyViewedCard(context, item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedCard(
      BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => onProductTap(item),
      child: Container(
        width: 40.w,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: CustomImageWidget(
                imageUrl: item['image'] as String? ?? '',
                width: 40.w,
                height: 20.h,
                fit: BoxFit.cover,
              ),
            ),

            // Product Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] as String? ?? 'Unknown Product',
                      style: AppTheme.lightTheme.textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 0.5.h),

                    if (item['brand'] != null)
                      Text(
                        item['brand'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),

                    Spacer(),

                    // Price and Rating
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '\$${(item['price'] as double? ?? 0.0).toStringAsFixed(2)}',
                            style: AppTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (item['rating'] != null) ...[
                          CustomIconWidget(
                            iconName: 'star',
                            color: Colors.amber,
                            size: 3.w,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '${item['rating']}',
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),

                    SizedBox(height: 1.h),

                    // Add to Cart Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => onAddToCart(item),
                        icon: CustomIconWidget(
                          iconName: 'add_shopping_cart',
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          size: 4.w,
                        ),
                        label: Text(
                          'Add',
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.primary,
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
