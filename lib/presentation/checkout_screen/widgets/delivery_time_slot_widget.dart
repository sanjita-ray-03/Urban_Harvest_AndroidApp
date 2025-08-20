import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DeliveryTimeSlotWidget extends StatefulWidget {
  final List<Map<String, dynamic>> timeSlots;
  final String? selectedSlotId;
  final Function(String) onSlotSelected;

  const DeliveryTimeSlotWidget({
    super.key,
    required this.timeSlots,
    this.selectedSlotId,
    required this.onSlotSelected,
  });

  @override
  State<DeliveryTimeSlotWidget> createState() => _DeliveryTimeSlotWidgetState();
}

class _DeliveryTimeSlotWidgetState extends State<DeliveryTimeSlotWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIconWidget(
              iconName: 'schedule',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 20,
            ),
            SizedBox(width: 2.w),
            Text(
              'Delivery Time',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 12.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.timeSlots.length,
            separatorBuilder: (context, index) => SizedBox(width: 3.w),
            itemBuilder: (context, index) {
              final slot = widget.timeSlots[index];
              final isSelected = widget.selectedSlotId == slot['id'];

              return GestureDetector(
                onTap: () => widget.onSlotSelected(slot['id'] as String),
                child: Container(
                  width: 35.w,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.1)
                        : AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.2),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        slot['timeRange'] as String? ?? 'Unknown',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme.lightTheme.colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        slot['date'] as String? ?? 'Unknown',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (slot['extraFee'] != null &&
                          (slot['extraFee'] as double) > 0) ...[
                        SizedBox(height: 0.5.h),
                        Text(
                          '+\$${(slot['extraFee'] as double).toStringAsFixed(2)}',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
