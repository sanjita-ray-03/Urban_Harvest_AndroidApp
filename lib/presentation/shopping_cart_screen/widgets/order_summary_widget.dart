import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class OrderSummaryWidget extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double discount;
  final double total;
  final String? appliedPromoCode;

  const OrderSummaryWidget({
    Key? key,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.discount,
    required this.total,
    this.appliedPromoCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CustomIconWidget(
                iconName: 'receipt_long',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 6.w,
              ),
              SizedBox(width: 3.w),
              Text(
                'Order Summary',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Subtotal
          _buildSummaryRow(
            'Subtotal',
            '\$${subtotal.toStringAsFixed(2)}',
            isSubtitle: true,
          ),

          // Delivery Fee
          _buildSummaryRow(
            'Delivery Fee',
            deliveryFee > 0 ? '\$${deliveryFee.toStringAsFixed(2)}' : 'FREE',
            isSubtitle: true,
            valueColor: deliveryFee > 0
                ? null
                : AppTheme.lightTheme.colorScheme.tertiary,
          ),

          // Tax
          _buildSummaryRow(
            'Tax & Fees',
            '\$${tax.toStringAsFixed(2)}',
            isSubtitle: true,
          ),

          // Discount (if applicable)
          if (discount > 0) ...[
            _buildSummaryRow(
              appliedPromoCode != null
                  ? 'Discount ($appliedPromoCode)'
                  : 'Discount',
              '-\$${discount.toStringAsFixed(2)}',
              isSubtitle: true,
              valueColor: AppTheme.lightTheme.colorScheme.tertiary,
            ),
          ],

          SizedBox(height: 1.h),

          // Divider
          Divider(
            color: AppTheme.lightTheme.colorScheme.outline,
            thickness: 1,
          ),

          SizedBox(height: 1.h),

          // Total
          _buildSummaryRow(
            'Total',
            '\$${total.toStringAsFixed(2)}',
            isTotal: true,
          ),

          SizedBox(height: 2.h),

          // Savings Info (if applicable)
          if (discount > 0 || deliveryFee == 0) ...[
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
                    iconName: 'savings',
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                    size: 5.w,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You\'re saving \$${(discount + (deliveryFee > 0 ? 0 : 5.99)).toStringAsFixed(2)}!',
                          style: AppTheme.lightTheme.textTheme.labelMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.tertiary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (deliveryFee == 0)
                          Text(
                            'Free delivery applied',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
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

          SizedBox(height: 2.h),

          // Payment Methods Preview
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'payment',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 5.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    'Multiple payment options available',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                CustomIconWidget(
                  iconName: 'credit_card',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 4.w,
                ),
                SizedBox(width: 1.w),
                CustomIconWidget(
                  iconName: 'account_balance_wallet',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 4.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isSubtitle = false,
    bool isTotal = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  )
                : isSubtitle
                    ? AppTheme.lightTheme.textTheme.bodyMedium
                    : AppTheme.lightTheme.textTheme.bodySmall,
          ),
          Text(
            value,
            style: isTotal
                ? AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  )
                : isSubtitle
                    ? AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: valueColor,
                      )
                    : AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: valueColor,
                      ),
          ),
        ],
      ),
    );
  }
}
