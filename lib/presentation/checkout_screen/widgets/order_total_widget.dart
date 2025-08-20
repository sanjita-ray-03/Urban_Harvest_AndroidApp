import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class OrderTotalWidget extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double taxes;
  final double? discountAmount;
  final double? deliverySlotFee;

  const OrderTotalWidget({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.taxes,
    this.discountAmount,
    this.deliverySlotFee,
  });

  double get totalAmount {
    double total = subtotal + deliveryFee + taxes;
    if (deliverySlotFee != null) {
      total += deliverySlotFee!;
    }
    if (discountAmount != null) {
      total -= discountAmount!;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Total',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          _buildTotalRow('Subtotal', subtotal, false),
          SizedBox(height: 2.h),
          _buildTotalRow('Delivery Fee', deliveryFee, false),
          if (deliverySlotFee != null && deliverySlotFee! > 0) ...[
            SizedBox(height: 2.h),
            _buildTotalRow('Time Slot Fee', deliverySlotFee!, false),
          ],
          SizedBox(height: 2.h),
          _buildTotalRow('Taxes & Fees', taxes, false),
          if (discountAmount != null && discountAmount! > 0) ...[
            SizedBox(height: 2.h),
            _buildTotalRow('Discount', -discountAmount!, false,
                isDiscount: true),
          ],
          SizedBox(height: 2.h),
          Divider(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
            thickness: 1,
          ),
          SizedBox(height: 2.h),
          _buildTotalRow('Total', totalAmount, true),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, bool isTotal,
      {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                )
              : AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
        ),
        Text(
          isDiscount
              ? '-\$${amount.abs().toStringAsFixed(2)}'
              : '\$${amount.toStringAsFixed(2)}',
          style: isTotal
              ? AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.lightTheme.colorScheme.primary,
                )
              : isDiscount
                  ? AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                    )
                  : AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
        ),
      ],
    );
  }
}
