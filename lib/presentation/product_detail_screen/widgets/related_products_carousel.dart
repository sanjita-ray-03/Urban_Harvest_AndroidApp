import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class RelatedProductsCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> relatedProducts;
  final Function(Map<String, dynamic>) onProductTap;

  const RelatedProductsCarousel({
    Key? key,
    required this.relatedProducts,
    required this.onProductTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Related Products',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 35.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: relatedProducts.length,
            itemBuilder: (context, index) {
              final product = relatedProducts[index];
              return _buildProductCard(product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () => onProductTap(product),
      child: Container(
        width: 40.w,
        margin: EdgeInsets.only(right: 3.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(3.w),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20.h,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(3.w)),
                child: CustomImageWidget(
                  imageUrl: product["image"] as String,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product["name"] as String,
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      product["brand"] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return CustomIconWidget(
                              iconName:
                                  index < (product["rating"] as double).floor()
                                      ? 'star'
                                      : 'star_border',
                              color: AppTheme.lightTheme.colorScheme.secondary,
                              size: 3.w,
                            );
                          }),
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '(${product["reviewCount"]})',
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      product["price"] as String,
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
