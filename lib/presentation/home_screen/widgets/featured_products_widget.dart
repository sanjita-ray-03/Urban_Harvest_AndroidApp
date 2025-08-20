import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FeaturedProductsWidget extends StatefulWidget {
  const FeaturedProductsWidget({super.key});

  @override
  State<FeaturedProductsWidget> createState() => _FeaturedProductsWidgetState();
}

class _FeaturedProductsWidgetState extends State<FeaturedProductsWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  int _animatedProductIndex = -1;

  final List<Map<String, dynamic>> _featuredProducts = [
    {
      "id": 1,
      "name": "Organic Bananas",
      "price": "\$2.99",
      "originalPrice": "\$3.49",
      "image":
          "https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=400",
      "rating": 4.5,
      "discount": "15% OFF",
      "unit": "per lb",
    },
    {
      "id": 2,
      "name": "Fresh Strawberries",
      "price": "\$4.99",
      "originalPrice": "\$5.99",
      "image":
          "https://images.pixabay.com/photo/2016/04/15/08/04/strawberries-1330459_960_720.jpg?auto=compress&cs=tinysrgb&w=400",
      "rating": 4.8,
      "discount": "17% OFF",
      "unit": "per pack",
    },
    {
      "id": 3,
      "name": "Avocados",
      "price": "\$1.99",
      "originalPrice": "\$2.49",
      "image":
          "https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?auto=format&fit=crop&w=400&q=80",
      "rating": 4.3,
      "discount": "20% OFF",
      "unit": "each",
    },
    {
      "id": 4,
      "name": "Bell Peppers",
      "price": "\$3.49",
      "originalPrice": "\$3.99",
      "image":
          "https://images.pexels.com/photos/1268101/pexels-photo-1268101.jpeg?auto=compress&cs=tinysrgb&w=400",
      "rating": 4.2,
      "discount": "12% OFF",
      "unit": "per lb",
    },
    {
      "id": 5,
      "name": "Organic Spinach",
      "price": "\$2.49",
      "originalPrice": "\$2.99",
      "image":
          "https://images.pixabay.com/photo/2016/03/05/19/02/vegetables-1238252_960_720.jpg?auto=compress&cs=tinysrgb&w=400",
      "rating": 4.6,
      "discount": "17% OFF",
      "unit": "per bunch",
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onAddToCart(int index) {
    setState(() {
      _animatedProductIndex = index;
    });
    _animationController.forward().then((_) {
      _animationController.reverse();
      setState(() {
        _animatedProductIndex = -1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Featured Products",
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
          height: 55.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: _featuredProducts.length,
            itemBuilder: (context, index) {
              final product = _featuredProducts[index];
              final isAnimated = _animatedProductIndex == index;

              return AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final scale = isAnimated
                      ? 1.0 + (_animationController.value * 0.1)
                      : 1.0;

                  return Transform.scale(
                    scale: scale,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/product-detail-screen');
                      },
                      child: Container(
                        width: 40.w,
                        margin: EdgeInsets.only(right: 3.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(3.w),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.lightTheme.colorScheme.shadow
                                  .withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(3.w),
                                  ),
                                  child: CustomImageWidget(
                                    imageUrl: product["image"] as String,
                                    width: double.infinity,
                                    height: 25.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 2.w,
                                  left: 2.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.w,
                                      vertical: 1.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme
                                          .lightTheme.colorScheme.secondary,
                                      borderRadius: BorderRadius.circular(2.w),
                                    ),
                                    child: Text(
                                      product["discount"] as String,
                                      style: AppTheme
                                          .lightTheme.textTheme.labelSmall
                                          ?.copyWith(
                                        color: AppTheme
                                            .lightTheme.colorScheme.onSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 2.w,
                                  right: 2.w,
                                  child: GestureDetector(
                                    onTap: () => _onAddToCart(index),
                                    child: Container(
                                      padding: EdgeInsets.all(2.w),
                                      decoration: BoxDecoration(
                                        color: AppTheme
                                            .lightTheme.colorScheme.primary,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppTheme
                                                .lightTheme.colorScheme.primary
                                                .withValues(alpha: 0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: CustomIconWidget(
                                        iconName: 'add',
                                        color: AppTheme
                                            .lightTheme.colorScheme.onPrimary,
                                        size: 4.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(3.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product["name"] as String,
                                      style: AppTheme
                                          .lightTheme.textTheme.titleMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme
                                            .lightTheme.colorScheme.onSurface,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      children: [
                                        CustomIconWidget(
                                          iconName: 'star',
                                          color: Colors.amber,
                                          size: 3.w,
                                        ),
                                        SizedBox(width: 1.w),
                                        Text(
                                          product["rating"].toString(),
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: AppTheme.lightTheme
                                                .colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          product["price"] as String,
                                          style: AppTheme
                                              .lightTheme.textTheme.titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme
                                                .lightTheme.colorScheme.primary,
                                          ),
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          product["originalPrice"] as String,
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: AppTheme.lightTheme
                                                .colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      product["unit"] as String,
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall
                                          ?.copyWith(
                                        color: AppTheme.lightTheme.colorScheme
                                            .onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
