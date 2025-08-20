import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onRemove;
  final VoidCallback onSaveForLater;
  final Function(int) onQuantityChanged;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onRemove,
    required this.onSaveForLater,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quantity = item['quantity'] as int? ?? 1;
    final price = item['price'] as double? ?? 0.0;
    final totalPrice = price * quantity;

    return Dismissible(
      key: Key(item['id'].toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Remove Item',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              content: Text(
                'Are you sure you want to remove this item from your cart?',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Remove'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) => onRemove(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.error,
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomIconWidget(
          iconName: 'delete',
          color: AppTheme.lightTheme.colorScheme.onError,
          size: 6.w,
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomImageWidget(
                imageUrl: item['image'] as String? ?? '',
                width: 20.w,
                height: 20.w,
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
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),

                  if (item['brand'] != null)
                    Text(
                      'Brand: ${item['brand']}',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),

                  if (item['size'] != null)
                    Text(
                      'Size: ${item['size']}',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),

                  SizedBox(height: 1.h),

                  // Price and Quantity Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${price.toStringAsFixed(2)}',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Total: \$${totalPrice.toStringAsFixed(2)}',
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ],
                      ),

                      // Quantity Controls
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.lightTheme.colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: quantity > 1
                                  ? () => onQuantityChanged(quantity - 1)
                                  : null,
                              child: Container(
                                padding: EdgeInsets.all(2.w),
                                child: CustomIconWidget(
                                  iconName: 'remove',
                                  color: quantity > 1
                                      ? AppTheme.lightTheme.colorScheme.primary
                                      : AppTheme.lightTheme.colorScheme.outline,
                                  size: 4.w,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: Text(
                                quantity.toString(),
                                style:
                                    AppTheme.lightTheme.textTheme.titleMedium,
                              ),
                            ),
                            InkWell(
                              onTap: () => onQuantityChanged(quantity + 1),
                              child: Container(
                                padding: EdgeInsets.all(2.w),
                                child: CustomIconWidget(
                                  iconName: 'add',
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  size: 4.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  // Action Buttons
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: onSaveForLater,
                        icon: CustomIconWidget(
                          iconName: 'favorite_border',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 4.w,
                        ),
                        label: Text(
                          'Save for Later',
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      TextButton.icon(
                        onPressed: onRemove,
                        icon: CustomIconWidget(
                          iconName: 'delete_outline',
                          color: AppTheme.lightTheme.colorScheme.error,
                          size: 4.w,
                        ),
                        label: Text(
                          'Remove',
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
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
      ),
    );
  }
}
