import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OrderHistoryItemWidget extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final String total;
  final int itemCount;
  final List<String> itemImages;
  final VoidCallback? onReorder;
  final VoidCallback? onTap;

  const OrderHistoryItemWidget({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.total,
    required this.itemCount,
    required this.itemImages,
    this.onReorder,
    this.onTap,
  });

  Color get _statusColor {
    switch (status.toLowerCase()) {
      case 'delivered':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'in progress':
        return AppTheme.lightTheme.colorScheme.secondary;
      case 'cancelled':
        return AppTheme.lightTheme.colorScheme.error;
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }

  String get _statusIcon {
    switch (status.toLowerCase()) {
      case 'delivered':
        return 'check_circle';
      case 'in progress':
        return 'local_shipping';
      case 'cancelled':
        return 'cancel';
      default:
        return 'schedule';
    }
  }

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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap != null
              ? () {
                  HapticFeedback.lightImpact();
                  onTap!();
                }
              : null,
          borderRadius: BorderRadius.circular(3.w),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order #$orderId',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: _statusColor.withAlpha(26),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: _statusIcon,
                            size: 3.w,
                            color: _statusColor,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            status,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: _statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 1.h),

                // Date and Item Count
                Text(
                  '$date • $itemCount items',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),

                SizedBox(height: 2.h),

                // Item Images Preview
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 12.w,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              itemImages.length > 3 ? 3 : itemImages.length,
                          itemBuilder: (context, index) {
                            if (index == 2 && itemImages.length > 3) {
                              // Show "+X more" indicator
                              return Container(
                                width: 12.w,
                                height: 12.w,
                                margin: EdgeInsets.only(right: 2.w),
                                decoration: BoxDecoration(
                                  color: AppTheme
                                      .lightTheme.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(2.w),
                                ),
                                child: Center(
                                  child: Text(
                                    '+${itemImages.length - 2}',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppTheme
                                          .lightTheme.colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }

                            return Container(
                              width: 12.w,
                              height: 12.w,
                              margin: EdgeInsets.only(right: 2.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.w),
                                color: AppTheme.lightTheme.colorScheme.outline
                                    .withAlpha(51),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2.w),
                                child: Image.network(
                                  itemImages[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    color: AppTheme
                                        .lightTheme.colorScheme.outline
                                        .withAlpha(51),
                                    child: CustomIconWidget(
                                      iconName: 'image',
                                      size: 6.w,
                                      color: AppTheme.lightTheme.colorScheme
                                          .onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Total Price
                    Text(
                      total,
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onTap != null
                            ? () {
                                HapticFeedback.lightImpact();
                                onTap!();
                              }
                            : null,
                        child: Text('View Details'),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onReorder != null
                            ? () {
                                HapticFeedback.lightImpact();
                                onReorder!();
                              }
                            : null,
                        child: Text('Reorder'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
