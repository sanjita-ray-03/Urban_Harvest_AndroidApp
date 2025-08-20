import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.w,
      height: 6.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (quantity > 1) {
                  HapticFeedback.lightImpact();
                  onDecrement();
                }
              },
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: quantity > 1
                      ? AppTheme.lightTheme.colorScheme.surface
                      : AppTheme.lightTheme.colorScheme.surface
                          .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2.w),
                    bottomLeft: Radius.circular(2.w),
                  ),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'remove',
                    color: quantity > 1
                        ? AppTheme.lightTheme.colorScheme.onSurface
                        : AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.5),
                    size: 5.w,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: AppTheme.lightTheme.colorScheme.outline,
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              child: Center(
                child: Text(
                  quantity.toString(),
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: AppTheme.lightTheme.colorScheme.outline,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                onIncrement();
              },
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(2.w),
                    bottomRight: Radius.circular(2.w),
                  ),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'add',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 5.w,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
