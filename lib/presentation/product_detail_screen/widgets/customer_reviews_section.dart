import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class CustomerReviewsSection extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;
  final double averageRating;
  final Map<int, int> ratingBreakdown;

  const CustomerReviewsSection({
    Key? key,
    required this.reviews,
    required this.averageRating,
    required this.ratingBreakdown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRatingOverview(),
        SizedBox(height: 3.h),
        _buildRatingBreakdown(),
        SizedBox(height: 3.h),
        _buildReviewsList(),
      ],
    );
  }

  Widget _buildRatingOverview() {
    return Row(
      children: [
        Text(
          averageRating.toStringAsFixed(1),
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 3.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(5, (index) {
                return CustomIconWidget(
                  iconName:
                      index < averageRating.floor() ? 'star' : 'star_border',
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  size: 4.w,
                );
              }),
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Based on ${reviews.length} reviews',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingBreakdown() {
    return Column(
      children: List.generate(5, (index) {
        int starCount = 5 - index;
        int reviewCount = ratingBreakdown[starCount] ?? 0;
        double percentage =
            reviews.isNotEmpty ? reviewCount / reviews.length : 0;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: Row(
            children: [
              Text(
                '$starCount',
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
              SizedBox(width: 1.w),
              CustomIconWidget(
                iconName: 'star',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 3.w,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(0.5.h),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(0.5.h),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                '$reviewCount',
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildReviewsList() {
    return Column(
      children:
          reviews.take(3).map((review) => _buildReviewItem(review)).toList(),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 4.w,
                backgroundColor: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                child: Text(
                  (review["customerName"] as String)
                      .substring(0, 1)
                      .toUpperCase(),
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review["customerName"] as String,
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return CustomIconWidget(
                              iconName: index < (review["rating"] as int)
                                  ? 'star'
                                  : 'star_border',
                              color: AppTheme.lightTheme.colorScheme.secondary,
                              size: 3.w,
                            );
                          }),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          review["date"] as String,
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            review["comment"] as String,
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'thumb_up',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 4.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'Helpful (${review["helpfulCount"]})',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'thumb_down',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 4.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'Not helpful',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
