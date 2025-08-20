import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecommendedProductsWidget extends StatefulWidget {
  final String selectedCategory;

  const RecommendedProductsWidget({
    super.key,
    required this.selectedCategory,
  });

  @override
  State<RecommendedProductsWidget> createState() =>
      _RecommendedProductsWidgetState();
}

class _RecommendedProductsWidgetState extends State<RecommendedProductsWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  int _animatedProductIndex = -1;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  List<Map<String, dynamic>> _allProducts = [
    {
      "id": 1,
      "name": "Organic Tomatoes",
      "price": "\$3.99",
      "originalPrice": "\$4.49",
      "image":
          "https://images.pexels.com/photos/533280/pexels-photo-533280.jpeg?auto=compress&cs=tinysrgb&w=400",
      "rating": 4.4,
      "category": "vegetables",
      "unit": "per lb",
      "inStock": true,
    },
    {
      "id": 2,
      "name": "Fresh Carrots",
      "price": "\$2.49",
      "originalPrice": "\$2.99",
      "image":
          "https://images.pixabay.com/photo/2016/08/09/10/30/carrots-1581597_960_720.jpg?auto=compress&cs=tinysrgb&w=400",
      "rating": 4.6,
      "category": "vegetables",
      "unit": "per bunch",
      "inStock": true,
    },
    {
      "id": 3,
      "name": "Red Apples",
      "price": "\$4.99",
      "originalPrice": "\$5.49",
      "image":
          "https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&w=400&q=80",
      "rating": 4.7,
      "category": "fruits",
      "unit": "per lb",
      "inStock": true,
    },
    {
      "id": 4,
      "name": "Greek Yogurt",
      "price": "\$5.99",
      "originalPrice": "\$6.99",
      "image":
          "https://images.pexels.com/photos/1435735/pexels-photo-1435735.jpeg?auto=compress&cs=tinysrgb&w=400",
      "rating": 4.5,
      "category": "dairy",
      "unit": "32 oz",
      "inStock": true,
    },
    {
      "id": 5,
      "name": "Whole Wheat Bread",
      "price": "\$3.49",
      "originalPrice": "\$3.99",
      "image":
          "https://images.pixabay.com/photo/2017/06/23/23/57/bread-2434370_960_720.jpg?auto=compress&cs=tinysrgb&w=400",
      "rating": 4.3,
      "category": "bakery",
      "unit": "per loaf",
      "inStock": true,
    },
    {
      "id": 6,
      "name": "Orange Juice",
      "price": "\$4.49",
      "originalPrice": "\$4.99",
      "image":
          "https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?auto=format&fit=crop&w=400&q=80",
      "rating": 4.2,
      "category": "beverages",
      "unit": "64 fl oz",
      "inStock": true,
    },
    {
      "id": 7,
      "name": "Potato Chips",
      "price": "\$2.99",
      "originalPrice": "\$3.49",
      "image":
          "https://images.pexels.com/photos/209206/pexels-photo-209206.jpeg?auto=compress&cs=tinysrgb&w=400",
      "rating": 4.1,
      "category": "snacks",
      "unit": "8 oz bag",
      "inStock": true,
    },
    {
      "id": 8,
      "name": "Chicken Breast",
      "price": "\$8.99",
      "originalPrice": "\$9.99",
      "image":
          "https://images.pixabay.com/photo/2016/01/22/02/13/meat-1155132_960_720.jpg?auto=compress&cs=tinysrgb&w=400",
      "rating": 4.8,
      "category": "meat",
      "unit": "per lb",
      "inStock": true,
    },
    {
      "id": 9,
      "name": "Broccoli",
      "price": "\$2.99",
      "originalPrice": "\$3.49",
      "image":
          "https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?auto=format&fit=crop&w=400&q=80",
      "rating": 4.4,
      "category": "vegetables",
      "unit": "per head",
      "inStock": true,
    },
    {
      "id": 10,
      "name": "Blueberries",
      "price": "\$6.99",
      "originalPrice": "\$7.99",
      "image":
          "https://images.pexels.com/photos/2161643/pexels-photo-2161643.jpeg?auto=compress&cs=tinysrgb&w=400",
      "rating": 4.9,
      "category": "fruits",
      "unit": "per pint",
      "inStock": true,
    },
  ];

  List<Map<String, dynamic>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scrollController.addListener(_onScroll);
    _filterProducts();
  }

  @override
  void didUpdateWidget(RecommendedProductsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategory != widget.selectedCategory) {
      _filterProducts();
    }
  }

  void _filterProducts() {
    setState(() {
      if (widget.selectedCategory == "all") {
        _filteredProducts = List.from(_allProducts);
      } else {
        _filteredProducts = _allProducts
            .where((product) => product["category"] == widget.selectedCategory)
            .toList();
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreProducts();
    }
  }

  void _loadMoreProducts() {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate loading more products
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          // Add more products (simulated)
          final moreProducts = List.generate(4, (index) {
            final baseProduct = _allProducts[index % _allProducts.length];
            return {
              ...baseProduct,
              "id": _filteredProducts.length + index + 1,
              "name":
                  "${baseProduct["name"]} (${_filteredProducts.length + index + 1})",
            };
          });
          _filteredProducts.addAll(moreProducts);
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
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

  void _showQuickActions(BuildContext context, Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5.w)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 1.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2.w),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              product["name"] as String,
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  child: _buildQuickActionButton(
                    icon: 'favorite_border',
                    label: 'Add to Wishlist',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildQuickActionButton(
                    icon: 'visibility',
                    label: 'View Details',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/product-detail-screen');
                    },
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildQuickActionButton(
                    icon: 'share',
                    label: 'Share',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: Column(
          children: [
            CustomIconWidget(
              iconName: icon,
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 6.w,
            ),
            SizedBox(height: 1.h),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            "Recommended for You",
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        _filteredProducts.isEmpty
            ? Container(
                height: 40.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'shopping_basket',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 15.w,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "No products found",
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "Try selecting a different category",
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : GridView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 3.w,
                ),
                itemCount: _filteredProducts.length + (_isLoading ? 2 : 0),
                itemBuilder: (context, index) {
                  if (index >= _filteredProducts.length) {
                    return _buildLoadingCard();
                  }

                  final product = _filteredProducts[index];
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
                            Navigator.pushNamed(
                                context, '/product-detail-screen');
                          },
                          onLongPress: () {
                            _showQuickActions(context, product);
                          },
                          child: Container(
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
                                        height: 35.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 2.w,
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
                                                color: AppTheme.lightTheme
                                                    .colorScheme.primary
                                                    .withValues(alpha: 0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: CustomIconWidget(
                                            iconName: 'add',
                                            color: AppTheme.lightTheme
                                                .colorScheme.onPrimary,
                                            size: 4.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (!(product["inStock"] as bool))
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppTheme
                                                .lightTheme.colorScheme.surface
                                                .withValues(alpha: 0.8),
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(3.w),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Out of Stock",
                                              style: AppTheme.lightTheme
                                                  .textTheme.labelMedium
                                                  ?.copyWith(
                                                color: AppTheme.lightTheme
                                                    .colorScheme.error,
                                                fontWeight: FontWeight.w600,
                                              ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product["name"] as String,
                                          style: AppTheme
                                              .lightTheme.textTheme.titleSmall
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppTheme.lightTheme
                                                .colorScheme.onSurface,
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
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                color: AppTheme
                                                    .lightTheme
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Text(
                                              product["price"] as String,
                                              style: AppTheme.lightTheme
                                                  .textTheme.titleSmall
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.lightTheme
                                                    .colorScheme.primary,
                                              ),
                                            ),
                                            SizedBox(width: 2.w),
                                            Text(
                                              product["originalPrice"]
                                                  as String,
                                              style: AppTheme.lightTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: AppTheme
                                                    .lightTheme
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          product["unit"] as String,
                                          style: AppTheme
                                              .lightTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: AppTheme.lightTheme
                                                .colorScheme.onSurfaceVariant,
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
        if (_isLoading)
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Center(
              child: CircularProgressIndicator(
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 35.w,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(3.w),
              ),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: AppTheme.lightTheme.colorScheme.primary,
                strokeWidth: 2,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 4.w,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                  ),
                  SizedBox(height: 2.w),
                  Container(
                    height: 3.w,
                    width: 20.w,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 4.w,
                    width: 15.w,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
