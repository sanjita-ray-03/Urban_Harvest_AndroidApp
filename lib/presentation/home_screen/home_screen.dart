import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/category_chips_widget.dart';
import './widgets/featured_products_widget.dart';
import './widgets/promotional_banner_widget.dart';
import './widgets/recent_orders_widget.dart';
import './widgets/recommended_products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  int _currentTabIndex = 0;
  int _cartItemCount = 3;
  String _selectedLocation = "123 Main St, New York";
  String _selectedCategory = "all";
  bool _isRefreshing = false;

  final List<Map<String, String>> _bottomNavItems = [
    {"icon": "home", "label": "Home"},
    {"icon": "search", "label": "Search"},
    {"icon": "favorite", "label": "Wishlist"},
    {"icon": "person", "label": "Profile"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _bottomNavItems.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Provide haptic feedback
    HapticFeedback.lightImpact();

    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
  }

  void _showLocationSelector() {
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
              "Select Delivery Location",
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'location_on',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 6.w,
              ),
              title: Text("Use Current Location"),
              subtitle: Text("We'll detect your location automatically"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedLocation = "Current Location";
                });
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'home',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 6.w,
              ),
              title: Text("123 Main St, New York"),
              subtitle: Text("Home"),
              trailing: _selectedLocation == "123 Main St, New York"
                  ? CustomIconWidget(
                      iconName: 'check_circle',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 6.w,
                    )
                  : null,
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedLocation = "123 Main St, New York";
                });
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'work',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 6.w,
              ),
              title: Text("456 Business Ave, NY"),
              subtitle: Text("Work"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedLocation = "456 Business Ave, NY";
                });
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyHeader() {
    return Container(
      color: AppTheme.lightTheme.colorScheme.surface,
      padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Location and Cart Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _showLocationSelector,
                    child: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'location_on',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 6.w,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Deliver to",
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                _selectedLocation,
                                style: AppTheme.lightTheme.textTheme.titleSmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      AppTheme.lightTheme.colorScheme.onSurface,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        CustomIconWidget(
                          iconName: 'keyboard_arrow_down',
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          size: 5.w,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/shopping-cart-screen');
                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color:
                              AppTheme.lightTheme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(3.w),
                        ),
                        child: CustomIconWidget(
                          iconName: 'shopping_cart',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 6.w,
                        ),
                      ),
                      if (_cartItemCount > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.error,
                              shape: BoxShape.circle,
                            ),
                            constraints: BoxConstraints(
                              minWidth: 5.w,
                              minHeight: 5.w,
                            ),
                            child: Text(
                              _cartItemCount.toString(),
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: AppTheme.lightTheme.colorScheme.onError,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            // Search Bar
            GestureDetector(
              onTap: () {
                // Navigate to search screen
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(3.w),
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.outline,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'search',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 5.w,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        "Search for groceries...",
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Implement barcode scanning
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color:
                              AppTheme.lightTheme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: CustomIconWidget(
                          iconName: 'qr_code_scanner',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 5.w,
                        ),
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

  Widget _buildHomeContent() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppTheme.lightTheme.colorScheme.primary,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                // Promotional Banner
                const PromotionalBannerWidget(),
                SizedBox(height: 4.h),
                // Category Chips
                CategoryChipsWidget(
                  onCategorySelected: _onCategorySelected,
                ),
                SizedBox(height: 4.h),
                // Featured Products
                const FeaturedProductsWidget(),
                SizedBox(height: 4.h),
                // Recent Orders
                const RecentOrdersWidget(),
                SizedBox(height: 4.h),
                // Recommended Products
                RecommendedProductsWidget(
                  selectedCategory: _selectedCategory,
                ),
                SizedBox(height: 10.h), // Bottom padding for FAB
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_currentTabIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return _buildSearchTab();
      case 2:
        return _buildWishlistTab();
      case 3:
        return _buildProfileTab();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildSearchTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'search',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 15.w,
          ),
          SizedBox(height: 2.h),
          Text(
            "Search Tab",
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "Search functionality will be implemented here",
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'favorite',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 15.w,
          ),
          SizedBox(height: 2.h),
          Text(
            "Wishlist Tab",
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "Your favorite products will appear here",
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'person',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 15.w,
          ),
          SizedBox(height: 2.h),
          Text(
            "Profile Tab",
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "User profile and settings will be here",
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Column(
        children: [
          if (_currentTabIndex == 0) _buildStickyHeader(),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color:
                  AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentTabIndex,
          onTap: (index) {
            setState(() {
              _currentTabIndex = index;
            });
            _tabController.animateTo(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          selectedItemColor: AppTheme.lightTheme.colorScheme.primary,
          unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          selectedLabelStyle:
              AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppTheme.lightTheme.textTheme.labelSmall,
          items: _bottomNavItems.map((item) {
            return BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: item["icon"]!,
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              activeIcon: CustomIconWidget(
                iconName: item["icon"]!,
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 6.w,
              ),
              label: item["label"]!,
            );
          }).toList(),
        ),
      ),
      floatingActionButton: _currentTabIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                // Navigate to grocery list creation
              },
              backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
              foregroundColor: AppTheme.lightTheme.colorScheme.onSecondary,
              icon: CustomIconWidget(
                iconName: 'add_shopping_cart',
                color: AppTheme.lightTheme.colorScheme.onSecondary,
                size: 5.w,
              ),
              label: Text(
                "Create List",
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }
}
