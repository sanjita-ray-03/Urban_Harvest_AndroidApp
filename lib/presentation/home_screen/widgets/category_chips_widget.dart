import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CategoryChipsWidget extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategoryChipsWidget({
    super.key,
    required this.onCategorySelected,
  });

  @override
  State<CategoryChipsWidget> createState() => _CategoryChipsWidgetState();
}

class _CategoryChipsWidgetState extends State<CategoryChipsWidget> {
  String _selectedCategory = "All";

  final List<Map<String, dynamic>> _categories = [
    {"id": "all", "name": "All", "icon": "apps"},
    {"id": "vegetables", "name": "Vegetables", "icon": "eco"},
    {"id": "fruits", "name": "Fruits", "icon": "apple"},
    {"id": "dairy", "name": "Dairy", "icon": "local_drink"},
    {"id": "meat", "name": "Meat", "icon": "restaurant"},
    {"id": "bakery", "name": "Bakery", "icon": "cake"},
    {"id": "snacks", "name": "Snacks", "icon": "cookie"},
    {"id": "beverages", "name": "Beverages", "icon": "local_cafe"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category["name"];

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category["name"] as String;
              });
              widget.onCategorySelected(category["id"] as String);
            },
            child: Container(
              margin: EdgeInsets.only(right: 3.w),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(6.w),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.outline,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: category["icon"] as String,
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.onPrimary
                        : AppTheme.lightTheme.colorScheme.onSurface,
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    category["name"] as String,
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.onPrimary
                          : AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
