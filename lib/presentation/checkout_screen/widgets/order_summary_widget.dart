import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OrderSummaryWidget extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final bool isExpanded;
  final VoidCallback onToggleExpanded;

  const OrderSummaryWidget({
    super.key,
    required this.cartItems,
    required this.isExpanded,
    required this.onToggleExpanded,
  });

  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  double get subtotal {
    return widget.cartItems.fold(0.0, (sum, item) {
      final price = item['price'] as double? ?? 0.0;
      final quantity = item['quantity'] as int? ?? 0;
      return sum + (price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: widget.onToggleExpanded,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'shopping_bag',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      'Order Summary (${widget.cartItems.length} items)',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '\$${subtotal.toStringAsFixed(2)}',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  CustomIconWidget(
                    iconName: widget.isExpanded ? 'expand_less' : 'expand_more',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (widget.isExpanded) ...[
            Divider(
              height: 1,
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.2),
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  ...widget.cartItems.map((item) => _buildOrderItem(item)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Row(
        children: [
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String? ?? 'Unknown Product',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'Qty: ${item['quantity'] ?? 0}',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${((item['price'] as double? ?? 0.0) * (item['quantity'] as int? ?? 0)).toStringAsFixed(2)}',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
