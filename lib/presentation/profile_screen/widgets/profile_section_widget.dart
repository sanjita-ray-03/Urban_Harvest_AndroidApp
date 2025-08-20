import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ProfileSectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsets? padding;
  final bool showDivider;

  const ProfileSectionWidget({
    super.key,
    required this.title,
    required this.children,
    this.padding,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(3.w),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.colorScheme.shadow.withAlpha(26),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
        if (showDivider) SizedBox(height: 3.h),
      ],
    );
  }
}
