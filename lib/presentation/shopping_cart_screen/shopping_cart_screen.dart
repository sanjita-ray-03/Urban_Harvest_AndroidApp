import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/cart_header_widget.dart';
import './widgets/cart_item_card.dart';
import './widgets/empty_cart_widget.dart';
import './widgets/order_summary_widget.dart';
import './widgets/promo_code_widget.dart';
import './widgets/recently_viewed_widget.dart';
import './widgets/saved_for_later_widget.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Map<String, dynamic>> _cartItems = [];
  List<Map<String, dynamic>> _savedForLaterItems = [];
  List<Map<String, dynamic>> _recentlyViewedItems = [];
  String _appliedPromoCode = '';
  bool _isLoading = false;

  // Mock cart data
  final List<Map<String, dynamic>> _mockCartItems = [
    {
      'id': 1,
      'name': 'Organic Bananas',
      'brand': 'Fresh Farm',
      'price': 2.99,
      'quantity': 3,
      'size': '1 lb',
      'image':
          'https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'inStock': true,
    },
    {
      'id': 2,
      'name': 'Whole Milk',
      'brand': 'Dairy Best',
      'price': 4.49,
      'quantity': 2,
      'size': '1 gallon',
      'image':
          'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'inStock': true,
    },
    {
      'id': 3,
      'name': 'Sourdough Bread',
      'brand': 'Artisan Bakery',
      'price': 5.99,
      'quantity': 1,
      'size': '24 oz',
      'image':
          'https://images.pexels.com/photos/1775043/pexels-photo-1775043.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'inStock': true,
    },
    {
      'id': 4,
      'name': 'Free Range Eggs',
      'brand': 'Happy Hens',
      'price': 6.99,
      'quantity': 1,
      'size': '12 count',
      'image':
          'https://images.pexels.com/photos/162712/egg-white-food-protein-162712.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'inStock': true,
    },
  ];

  final List<Map<String, dynamic>> _mockSavedItems = [
    {
      'id': 5,
      'name': 'Greek Yogurt',
      'brand': 'Creamy Delight',
      'price': 3.99,
      'image':
          'https://images.pexels.com/photos/1435735/pexels-photo-1435735.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
    {
      'id': 6,
      'name': 'Avocados',
      'brand': 'Green Gold',
      'price': 1.99,
      'image':
          'https://images.pexels.com/photos/557659/pexels-photo-557659.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
  ];

  final List<Map<String, dynamic>> _mockRecentlyViewed = [
    {
      'id': 7,
      'name': 'Organic Spinach',
      'brand': 'Leafy Greens',
      'price': 2.49,
      'rating': 4.5,
      'image':
          'https://images.pexels.com/photos/2325843/pexels-photo-2325843.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
    {
      'id': 8,
      'name': 'Cherry Tomatoes',
      'brand': 'Vine Fresh',
      'price': 3.99,
      'rating': 4.8,
      'image':
          'https://images.pexels.com/photos/533280/pexels-photo-533280.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
    {
      'id': 9,
      'name': 'Organic Carrots',
      'brand': 'Root Harvest',
      'price': 1.79,
      'rating': 4.3,
      'image':
          'https://images.pexels.com/photos/143133/pexels-photo-143133.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
    {
      'id': 10,
      'name': 'Bell Peppers',
      'brand': 'Colorful Harvest',
      'price': 4.99,
      'rating': 4.6,
      'image':
          'https://images.pexels.com/photos/594137/pexels-photo-594137.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadCartData();
  }

  void _loadCartData() {
    setState(() {
      _cartItems = List.from(_mockCartItems);
      _savedForLaterItems = List.from(_mockSavedItems);
      _recentlyViewedItems = List.from(_mockRecentlyViewed);
    });
  }

  void _removeFromCart(Map<String, dynamic> item) {
    setState(() {
      _cartItems.removeWhere((cartItem) => cartItem['id'] == item['id']);
    });

    Fluttertoast.showToast(
      msg: '${item['name']} removed from cart',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _saveForLater(Map<String, dynamic> item) {
    setState(() {
      _cartItems.removeWhere((cartItem) => cartItem['id'] == item['id']);

      // Remove quantity for saved items
      final savedItem = Map<String, dynamic>.from(item);
      savedItem.remove('quantity');

      if (!_savedForLaterItems.any((saved) => saved['id'] == item['id'])) {
        _savedForLaterItems.add(savedItem);
      }
    });

    Fluttertoast.showToast(
      msg: '${item['name']} saved for later',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _updateQuantity(Map<String, dynamic> item, int newQuantity) {
    setState(() {
      final index =
          _cartItems.indexWhere((cartItem) => cartItem['id'] == item['id']);
      if (index != -1) {
        _cartItems[index]['quantity'] = newQuantity;
      }
    });
  }

  void _moveToCart(Map<String, dynamic> item) {
    setState(() {
      _savedForLaterItems.removeWhere((saved) => saved['id'] == item['id']);

      // Add quantity for cart items
      final cartItem = Map<String, dynamic>.from(item);
      cartItem['quantity'] = 1;

      if (!_cartItems.any((cart) => cart['id'] == item['id'])) {
        _cartItems.add(cartItem);
      }
    });

    Fluttertoast.showToast(
      msg: '${item['name']} moved to cart',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _removeFromSaved(Map<String, dynamic> item) {
    setState(() {
      _savedForLaterItems.removeWhere((saved) => saved['id'] == item['id']);
    });

    Fluttertoast.showToast(
      msg: '${item['name']} removed from saved items',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _addToCartFromRecent(Map<String, dynamic> item) {
    final cartItem = Map<String, dynamic>.from(item);
    cartItem['quantity'] = 1;
    cartItem['brand'] = cartItem['brand'] ?? 'Generic Brand';
    cartItem['size'] = '1 unit';
    cartItem['inStock'] = true;

    setState(() {
      final existingIndex =
          _cartItems.indexWhere((cart) => cart['id'] == item['id']);
      if (existingIndex != -1) {
        _cartItems[existingIndex]['quantity'] += 1;
      } else {
        _cartItems.add(cartItem);
      }
    });

    Fluttertoast.showToast(
      msg: '${item['name']} added to cart',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _onProductTap(Map<String, dynamic> item) {
    Navigator.pushNamed(context, '/product-detail-screen');
  }

  void _onPromoApplied(String promoCode) {
    setState(() {
      _appliedPromoCode = promoCode;
    });
  }

  void _startShopping() {
    Navigator.pushNamed(context, '/home-screen');
  }

  void _proceedToCheckout() {
    if (_cartItems.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Your cart is empty',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    Navigator.pushNamed(context, '/checkout-screen');
  }

  void _refreshCart() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network call
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    Fluttertoast.showToast(
      msg: 'Cart updated',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  double get _subtotal {
    return _cartItems.fold(0.0, (sum, item) {
      final price = item['price'] as double? ?? 0.0;
      final quantity = item['quantity'] as int? ?? 1;
      return sum + (price * quantity);
    });
  }

  double get _deliveryFee {
    return _subtotal >= 50.0 ? 0.0 : 5.99;
  }

  double get _tax {
    return _subtotal * 0.08; // 8% tax
  }

  double get _discount {
    if (_appliedPromoCode.isEmpty) return 0.0;

    switch (_appliedPromoCode.toUpperCase()) {
      case 'SAVE10':
        return _subtotal >= 30.0 ? _subtotal * 0.10 : 0.0;
      case 'FIRST20':
        return _subtotal * 0.20;
      case 'FRESH15':
        return _subtotal >= 25.0 ? _subtotal * 0.15 : 0.0;
      default:
        return 0.0;
    }
  }

  double get _total {
    return _subtotal + _deliveryFee + _tax - _discount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        elevation: 2,
        actions: [
          if (_cartItems.isNotEmpty)
            IconButton(
              onPressed: _refreshCart,
              icon: _isLoading
                  ? SizedBox(
                      width: 5.w,
                      height: 5.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    )
                  : CustomIconWidget(
                      iconName: 'refresh',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 6.w,
                    ),
            ),
        ],
      ),
      body: _cartItems.isEmpty
          ? EmptyCartWidget(onStartShopping: _startShopping)
          : Column(
              children: [
                // Sticky Header
                CartHeaderWidget(
                  itemCount: _cartItems.length,
                  estimatedDeliveryTime: '30-45 min',
                ),

                // Scrollable Content
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => _refreshCart(),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: 1.h),

                          // Cart Items
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _cartItems.length,
                            itemBuilder: (context, index) {
                              final item = _cartItems[index];
                              return CartItemCard(
                                item: item,
                                onRemove: () => _removeFromCart(item),
                                onSaveForLater: () => _saveForLater(item),
                                onQuantityChanged: (newQuantity) =>
                                    _updateQuantity(item, newQuantity),
                              );
                            },
                          ),

                          SizedBox(height: 2.h),

                          // Promo Code Section
                          PromoCodeWidget(
                            onPromoApplied: _onPromoApplied,
                          ),

                          SizedBox(height: 2.h),

                          // Order Summary
                          OrderSummaryWidget(
                            subtotal: _subtotal,
                            deliveryFee: _deliveryFee,
                            tax: _tax,
                            discount: _discount,
                            total: _total,
                            appliedPromoCode: _appliedPromoCode.isNotEmpty
                                ? _appliedPromoCode
                                : null,
                          ),

                          SizedBox(height: 2.h),

                          // Saved for Later
                          SavedForLaterWidget(
                            savedItems: _savedForLaterItems,
                            onMoveToCart: _moveToCart,
                            onRemoveFromSaved: _removeFromSaved,
                          ),

                          SizedBox(height: 2.h),

                          // Recently Viewed
                          RecentlyViewedWidget(
                            recentlyViewedItems: _recentlyViewedItems,
                            onAddToCart: _addToCartFromRecent,
                            onProductTap: _onProductTap,
                          ),

                          SizedBox(height: 10.h), // Space for bottom button
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

      // Sticky Bottom Checkout Button
      bottomNavigationBar: _cartItems.isNotEmpty
          ? Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.lightTheme.colorScheme.shadow,
                    blurRadius: 8,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Quick Total Display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total (${_cartItems.length} items)',
                          style: AppTheme.lightTheme.textTheme.titleMedium,
                        ),
                        Text(
                          '\$${_total.toStringAsFixed(2)}',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    // Checkout Button
                    SizedBox(
                      width: double.infinity,
                      height: 6.h,
                      child: ElevatedButton.icon(
                        onPressed: _proceedToCheckout,
                        icon: CustomIconWidget(
                          iconName: 'shopping_cart_checkout',
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          size: 6.w,
                        ),
                        label: Text(
                          'Proceed to Checkout',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
