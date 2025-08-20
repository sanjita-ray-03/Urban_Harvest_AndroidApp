import 'package:flutter/material.dart';

import '../presentation/checkout_screen/checkout_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/product_detail_screen/product_detail_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';
import '../presentation/shopping_cart_screen/shopping_cart_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String loginScreen = '/login-screen';
  static const String checkoutScreen = '/checkout-screen';
  static const String productDetailScreen = '/product-detail-screen';
  static const String homeScreen = '/home-screen';
  static const String shoppingCartScreen = '/shopping-cart-screen';
  static const String profileScreen = '/profile-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => SplashScreen(),
    splashScreen: (context) => SplashScreen(),
    loginScreen: (context) => LoginScreen(),
    checkoutScreen: (context) => CheckoutScreen(),
    productDetailScreen: (context) => ProductDetailScreen(),
    homeScreen: (context) => HomeScreen(),
    shoppingCartScreen: (context) => ShoppingCartScreen(),
    profileScreen: (context) => ProfileScreen(),
    // TODO: Add your other routes here
  };
}
