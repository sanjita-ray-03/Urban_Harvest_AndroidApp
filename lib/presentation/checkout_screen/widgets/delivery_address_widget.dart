import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DeliveryAddressWidget extends StatelessWidget {
  final Map<String, dynamic> selectedAddress;
  final VoidCallback onChangeAddress;

  const DeliveryAddressWidget({
    super.key,
    required this.selectedAddress,
    required this.onChangeAddress,
  });

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
          Row(
            children: [
              CustomIconWidget(
                iconName: 'location_on',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  'Delivery Address',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: onChangeAddress,
                child: Text(
                  'Change',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            selectedAddress['name'] as String? ?? 'Unknown',
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            selectedAddress['address'] as String? ?? 'No address provided',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 1.h),
          Text(
            selectedAddress['phone'] as String? ?? 'No phone number',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
