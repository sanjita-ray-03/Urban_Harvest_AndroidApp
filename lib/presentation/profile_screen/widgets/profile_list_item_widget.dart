import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileListItemWidget extends StatelessWidget {
  final String iconName;
  final String title;
  final String? subtitle;
  final String? trailing;
  final VoidCallback? onTap;
  final bool showArrow;
  final bool showDivider;
  final Color? iconColor;
  final Widget? trailingWidget;

  const ProfileListItemWidget({
    super.key,
    required this.iconName,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showArrow = true,
    this.showDivider = true,
    this.iconColor,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap != null
              ? () {
                  HapticFeedback.lightImpact();
                  onTap!();
                }
              : null,
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
          trailing: trailingWidget ??
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (trailing != null)
                    Text(
                      trailing!,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  if (showArrow) ...[
                    if (trailing != null) SizedBox(width: 2.w),
                    CustomIconWidget(
                      iconName: 'chevron_right',
                      size: 5.w,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ],
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
