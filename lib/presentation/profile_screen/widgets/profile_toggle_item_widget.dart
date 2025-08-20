import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileToggleItemWidget extends StatelessWidget {
  final String iconName;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;
  final Color? iconColor;

  const ProfileToggleItemWidget({
    super.key,
    required this.iconName,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.showDivider = true,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          leading: Container(
            padding: EdgeInsets.all(2.5.w),
            decoration: BoxDecoration(
              color: (iconColor ?? AppTheme.lightTheme.colorScheme.primary)
                  .withAlpha(26),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: CustomIconWidget(
              iconName: iconName,
              size: 5.w,
              color: iconColor ?? AppTheme.lightTheme.colorScheme.primary,
            ),
          ),
          title: Text(
            title,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
          trailing: Switch(
            value: value,
            onChanged: (newValue) {
              HapticFeedback.lightImpact();
              onChanged(newValue);
            },
            activeColor: AppTheme.lightTheme.colorScheme.primary,
            inactiveThumbColor:
                AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            inactiveTrackColor:
                AppTheme.lightTheme.colorScheme.outline.withAlpha(128),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            indent: 4.w,
            endIndent: 4.w,
            color: AppTheme.lightTheme.colorScheme.outline.withAlpha(51),
          ),
      ],
    );
  }
}
