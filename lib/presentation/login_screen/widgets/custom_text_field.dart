import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String iconName;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.iconName,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.validator,
    this.enabled = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: 6.h,
          ),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _isFocused = hasFocus;
              });
            },
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.isPassword ? _obscureText : false,
              enabled: widget.enabled,
              validator: widget.validator,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: widget.enabled
                    ? AppTheme.lightTheme.colorScheme.onSurface
                    : AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
              ),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: widget.iconName,
                    size: 20,
                    color: _isFocused
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                  ),
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: CustomIconWidget(
                          iconName:
                              _obscureText ? 'visibility' : 'visibility_off',
                          size: 20,
                          color: AppTheme.lightTheme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                      )
                    : null,
                filled: true,
                fillColor: widget.enabled
                    ? AppTheme.lightTheme.colorScheme.surface
                    : AppTheme.lightTheme.colorScheme.surface
                        .withValues(alpha: 0.5),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.error,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.error,
                    width: 2,
                  ),
                ),
                errorStyle: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.error,
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
