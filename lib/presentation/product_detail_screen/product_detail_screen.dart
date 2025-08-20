import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/add_to_cart_button.dart';
import './widgets/customer_reviews_section.dart';
import './widgets/expandable_section.dart';
import './widgets/frequently_bought_together.dart';
import './widgets/product_header.dart';
import './widgets/product_image_carousel.dart';
import './widgets/product_info_section.dart';
import './widgets/quantity_selector.dart';
import './widgets/related_products_carousel.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  bool _isWishlisted = false;
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();

  // Mock product data
  final Map<String, dynamic> _productData = {
    "id": 1,
    "name": "Organic Fresh Bananas",
    "brand": "Nature's Best",
    "price": "\$3.99",
    "originalPrice": "\$4.99",
    "rating": 4.5,
    "reviewCount": 127,
    "stockStatus": "In Stock",
    "images": [
      "https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/5966630/pexels-photo-5966630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/2238309/pexels-photo-2238309.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ],
    "description":
        """Fresh, organic bananas sourced directly from sustainable farms. These premium bananas are naturally ripened and packed with essential nutrients including potassium, vitamin B6, and dietary fiber. Perfect for snacking, smoothies, or baking. Each bunch contains 6-8 medium-sized bananas.""",
    "nutritionalInfo": {
      "servingSize": "1 medium banana (118g)",
      "calories": 105,
      "totalFat": "0.4g",
      "sodium": "1mg",
      "totalCarbs": "27g",
      "dietaryFiber": "3.1g",
      "sugars": "14g",
      "protein": "1.3g",
      "potassium": "422mg",
      "vitaminB6": "0.4mg",
      "vitaminC": "10.3mg"
    }
  };

  final List<Map<String, dynamic>> _customerReviews = [
    {
      "customerName": "Sarah Johnson",
      "rating": 5,
      "date": "July 15, 2025",
      "comment":
          "These bananas are absolutely perfect! They arrived at the perfect ripeness and taste incredibly sweet. Great for my morning smoothies.",
      "helpfulCount": 12
    },
    {
      "customerName": "Mike Chen",
      "rating": 4,
      "date": "July 10, 2025",
      "comment":
          "Good quality bananas, though they ripened a bit faster than expected. Still very tasty and fresh when they arrived.",
      "helpfulCount": 8
    },
    {
      "customerName": "Emma Davis",
      "rating": 5,
      "date": "July 8, 2025",
      "comment":
          "Love that these are organic! My kids enjoy them as snacks and I feel good about what I'm feeding them. Will definitely order again.",
      "helpfulCount": 15
    }
  ];

  final List<Map<String, dynamic>> _relatedProducts = [
    {
      "id": 2,
      "name": "Organic Apples",
      "brand": "Farm Fresh",
      "price": "\$5.99",
      "rating": 4.3,
      "reviewCount": 89,
      "image":
          "https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    },
    {
      "id": 3,
      "name": "Fresh Strawberries",
      "brand": "Berry Best",
      "price": "\$4.49",
      "rating": 4.7,
      "reviewCount": 156,
      "image":
          "https://images.pexels.com/photos/89778/strawberries-frisch-ripe-sweet-89778.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    },
    {
      "id": 4,
      "name": "Organic Oranges",
      "brand": "Citrus Grove",
      "price": "\$6.99",
      "rating": 4.4,
      "reviewCount": 73,
      "image":
          "https://images.pexels.com/photos/161559/background-bitter-breakfast-bright-161559.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    }
  ];

  final List<Map<String, dynamic>> _suggestedProducts = [
    {
      "id": 5,
      "name": "Greek Yogurt",
      "brand": "Creamy Delight",
      "price": "\$2.99",
      "image":
          "https://images.pexels.com/photos/1435735/pexels-photo-1435735.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    },
    {
      "id": 6,
      "name": "Granola Mix",
      "brand": "Crunchy Bites",
      "price": "\$3.49",
      "image":
          "https://images.pexels.com/photos/1092730/pexels-photo-1092730.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    }
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _toggleWishlist() {
    setState(() {
      _isWishlisted = !_isWishlisted;
    });
    HapticFeedback.lightImpact();
    Fluttertoast.showToast(
      msg: _isWishlisted ? "Added to wishlist" : "Removed from wishlist",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _shareProduct() {
    HapticFeedback.lightImpact();
    Fluttertoast.showToast(
      msg: "Product shared successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _addToCart() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Added $_quantity item(s) to cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    });
  }

  void _onRelatedProductTap(Map<String, dynamic> product) {
    Navigator.pushNamed(context, '/product-detail-screen');
  }

  void _addBundleToCart(List<Map<String, dynamic>> products) {
    Fluttertoast.showToast(
      msg: "Bundle added to cart (${products.length} items)",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  String _calculateTotalPrice() {
    double basePrice =
        double.parse(_productData["price"].toString().replaceAll('\$', ''));
    double totalPrice = basePrice * _quantity;
    return '\$${totalPrice.toStringAsFixed(2)}';
  }

  Map<int, int> _getRatingBreakdown() {
    Map<int, int> breakdown = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in _customerReviews) {
      int rating = review["rating"] as int;
      breakdown[rating] = (breakdown[rating] ?? 0) + 1;
    }
    return breakdown;
  }

  double _getAverageRating() {
    if (_customerReviews.isEmpty) return 0.0;
    double total = _customerReviews.fold(
        0.0, (sum, review) => sum + (review["rating"] as int));
    return total / _customerReviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImageCarousel(
                      images: (_productData["images"] as List).cast<String>(),
                      productName: _productData["name"] as String,
                    ),
                    ProductInfoSection(
                      productName: _productData["name"] as String,
                      brand: _productData["brand"] as String,
                      price: _productData["price"] as String,
                      originalPrice: _productData["originalPrice"] as String,
                      rating: _productData["rating"] as double,
                      reviewCount: _productData["reviewCount"] as int,
                      stockStatus: _productData["stockStatus"] as String,
                    ),
                    SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          QuantitySelector(
                            quantity: _quantity,
                            onIncrement: _incrementQuantity,
                            onDecrement: _decrementQuantity,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ExpandableSection(
                      title: 'Product Description',
                      content: Text(
                        _productData["description"] as String,
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ExpandableSection(
                      title: 'Nutritional Information',
                      content: _buildNutritionalInfo(),
                    ),
                    SizedBox(height: 2.h),
                    ExpandableSection(
                      title: 'Customer Reviews (${_customerReviews.length})',
                      content: CustomerReviewsSection(
                        reviews: _customerReviews,
                        averageRating: _getAverageRating(),
                        ratingBreakdown: _getRatingBreakdown(),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: FrequentlyBoughtTogether(
                        mainProduct: _productData,
                        suggestedProducts: _suggestedProducts,
                        onAddBundle: _addBundleToCart,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    RelatedProductsCarousel(
                      relatedProducts: _relatedProducts,
                      onProductTap: _onRelatedProductTap,
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ProductHeader(
              onBackPressed: () => Navigator.pop(context),
              onSharePressed: _shareProduct,
              onWishlistPressed: _toggleWishlist,
              isWishlisted: _isWishlisted,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AddToCartButton(
              totalPrice: _calculateTotalPrice(),
              onPressed: _addToCart,
              isLoading: _isLoading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionalInfo() {
    final nutritionalInfo =
        _productData["nutritionalInfo"] as Map<String, dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Serving Size: ${nutritionalInfo["servingSize"]}',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              _buildNutritionRow('Calories', '${nutritionalInfo["calories"]}'),
              _buildNutritionRow(
                  'Total Fat', nutritionalInfo["totalFat"] as String),
              _buildNutritionRow('Sodium', nutritionalInfo["sodium"] as String),
              _buildNutritionRow(
                  'Total Carbs', nutritionalInfo["totalCarbs"] as String),
              _buildNutritionRow(
                  'Dietary Fiber', nutritionalInfo["dietaryFiber"] as String),
              _buildNutritionRow('Sugars', nutritionalInfo["sugars"] as String),
              _buildNutritionRow(
                  'Protein', nutritionalInfo["protein"] as String),
              _buildNutritionRow(
                  'Potassium', nutritionalInfo["potassium"] as String),
              _buildNutritionRow(
                  'Vitamin B6', nutritionalInfo["vitaminB6"] as String),
              _buildNutritionRow(
                  'Vitamin C', nutritionalInfo["vitaminC"] as String),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
