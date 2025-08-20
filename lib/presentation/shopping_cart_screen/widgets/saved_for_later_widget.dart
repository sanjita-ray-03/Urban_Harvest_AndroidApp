import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class SavedForLaterWidget extends StatelessWidget {
  final List<Map<String, dynamic>> savedItems;
  final Function(Map<String, dynamic>) onMoveToCart;
  final Function(Map<String, dynamic>) onRemoveFromSaved;

  const SavedForLaterWidget({
    Key? key,
    required this.savedItems,
    required this.onMoveToCart,
    required this.onRemoveFromSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (savedItems.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'favorite',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 6.w,
                ),
                SizedBox(width: 3.w),
                Text(
                  'Saved for Later (${savedItems.length})',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Divider(
            color: AppTheme.lightTheme.colorScheme.outline,
            height: 1,
          ),

          // Saved Items List
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: savedItems.length,
            separatorBuilder: (context, index) => Divider(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.3),
              height: 1,
            ),
            itemBuilder: (context, index) {
              final item = savedItems[index];
              return _buildSavedItem(context, item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSavedItem(BuildContext context, Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomImageWidget(
              imageUrl: item['image'] as String? ?? '',
              width: 15.w,
              height: 15.w,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 3.w),

          // Product Details
          Expanded(
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
                    'Brand: ${item['brand']}',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                SizedBox(height: 0.5.h),

                Text(
                  '\$${(item['price'] as double? ?? 0.0).toStringAsFixed(2)}',
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 1.h),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => onMoveToCart(item),
                        icon: CustomIconWidget(
                          iconName: 'shopping_cart',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 4.w,
                        ),
                        label: Text(
                          'Move to Cart',
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 1.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    OutlinedButton(
                      onPressed: () => onRemoveFromSaved(item),
                      child: CustomIconWidget(
                        iconName: 'delete_outline',
                        color: AppTheme.lightTheme.colorScheme.error,
                        size: 4.w,
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(1.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        side: BorderSide(
                          color: AppTheme.lightTheme.colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
