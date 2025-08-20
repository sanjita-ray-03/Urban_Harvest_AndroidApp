import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecentOrdersWidget extends StatelessWidget {
  const RecentOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _recentOrders = [
      {
        "id": 1,
        "orderNumber": "#ORD-2024-001",
        "date": "July 18, 2025",
        "items": ["Organic Bananas", "Fresh Strawberries", "Avocados"],
        "totalItems": 5,
        "totalAmount": "\$24.99",
        "status": "Delivered",
        "image":
            "https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=200",
      },
      {
        "id": 2,
        "orderNumber": "#ORD-2024-002",
        "date": "July 15, 2025",
        "items": ["Bell Peppers", "Organic Spinach", "Tomatoes"],
        "totalItems": 3,
        "totalAmount": "\$18.47",
        "status": "Delivered",
        "image":
            "https://images.pexels.com/photos/1268101/pexels-photo-1268101.jpeg?auto=compress&cs=tinysrgb&w=200",
      },
      {
        "id": 3,
        "orderNumber": "#ORD-2024-003",
        "date": "July 12, 2025",
        "items": ["Milk", "Bread", "Eggs", "Cheese"],
        "totalItems": 6,
        "totalAmount": "\$31.25",
        "status": "Delivered",
        "image":
            "https://images.unsplash.com/photo-1563636619-e9143da7973b?auto=format&fit=crop&w=200&q=80",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Orders",
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "View All",
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 35.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: _recentOrders.length,
            itemBuilder: (context, index) {
              final order = _recentOrders[index];

              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 75.w,
                  margin: EdgeInsets.only(right: 3.w),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(3.w),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.lightTheme.colorScheme.shadow
                            .withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2.w),
                        child: CustomImageWidget(
                          imageUrl: order["image"] as String,
                          width: 20.w,
                          height: 20.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order["orderNumber"] as String,
                                  style: AppTheme
                                      .lightTheme.textTheme.titleSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme
                                        .lightTheme.colorScheme.onSurface,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 0.5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme
                                        .lightTheme.colorScheme.tertiary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(2.w),
                                  ),
                                  child: Text(
                                    order["status"] as String,
                                    style: AppTheme
                                        .lightTheme.textTheme.labelSmall
                                        ?.copyWith(
                                      color: AppTheme
                                          .lightTheme.colorScheme.tertiary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              order["date"] as String,
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              "${order["totalItems"]} items • ${order["totalAmount"]}",
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    (order["items"] as List)
                                            .take(2)
                                            .join(", ") +
                                        ((order["items"] as List).length > 2
                                            ? "..."
                                            : ""),
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppTheme
                                          .lightTheme.colorScheme.onSurface,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.w,
                                      vertical: 1.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme
                                          .lightTheme.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(2.w),
                                    ),
                                    child: Text(
                                      "Reorder",
                                      style: AppTheme
                                          .lightTheme.textTheme.labelSmall
                                          ?.copyWith(
                                        color: AppTheme
                                            .lightTheme.colorScheme.onPrimary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
