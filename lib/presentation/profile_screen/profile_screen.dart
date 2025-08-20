import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/order_history_item_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/profile_list_item_widget.dart';
import './widgets/profile_section_widget.dart';
import './widgets/profile_toggle_item_widget.dart';
import './widgets/saved_item_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();

  // Settings state
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _orderUpdates = true;
  bool _promotionalOffers = true;
  bool _biometricLogin = false;
  bool _locationServices = true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // Provide haptic feedback
    HapticFeedback.lightImpact();

    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, you would fetch updated user data here
    if (mounted) {
      setState(() {});
    }
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout from your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _performLogout();
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: AppTheme.lightTheme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'This will permanently delete your account and all associated data. This action cannot be undone.'),
            SizedBox(height: 2.h),
            Text(
              'Are you sure you want to proceed?',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _performAccountDeletion();
            },
            child: Text(
              'Delete Account',
              style: TextStyle(
                color: AppTheme.lightTheme.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _performLogout() {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate logout process
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login-screen',
        (route) => false,
      );
    });
  }

  void _performAccountDeletion() {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate account deletion process
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); // Close loading dialog
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login-screen',
        (route) => false,
      );
    });
  }

  void _navigateToEditProfile() {
    // Navigate to edit profile screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit profile functionality would be implemented here'),
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      ),
    );
  }

  void _navigateToAddresses() {
    // Navigate to manage addresses screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Manage addresses functionality would be implemented here'),
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      ),
    );
  }

  void _navigateToPaymentMethods() {
    // Navigate to payment methods screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Payment methods functionality would be implemented here'),
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      ),
    );
  }

  void _navigateToOrderHistory() {
    // Navigate to full order history screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Full order history would be implemented here'),
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      ),
    );
  }

  void _navigateToHelp() {
    // Navigate to help center
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Help center functionality would be implemented here'),
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      ),
    );
  }

  void _reorderItems(String orderId) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reordering items from order #$orderId'),
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      ),
    );
  }

  void _viewOrderDetails(String orderId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing details for order #$orderId'),
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      ),
    );
  }

  void _addToCart(String itemName) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName added to cart'),
        backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      ),
    );
  }

  void _removeSavedItem(String itemName) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName removed from saved items'),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        foregroundColor: AppTheme.lightTheme.colorScheme.onSurface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _navigateToEditProfile,
            icon: CustomIconWidget(
              iconName: 'edit',
              size: 6.w,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppTheme.lightTheme.colorScheme.primary,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Profile Header
              const ProfileHeaderWidget(),

              SizedBox(height: 2.h),

              // Personal Information Section
              ProfileSectionWidget(
                title: 'Personal Information',
                children: [
                  ProfileListItemWidget(
                    iconName: 'email',
                    title: 'Email Address',
                    subtitle: 'john.smith@email.com',
                    onTap: _navigateToEditProfile,
                  ),
                  ProfileListItemWidget(
                    iconName: 'phone',
                    title: 'Phone Number',
                    subtitle: '+1 (555) 123-4567',
                    onTap: _navigateToEditProfile,
                  ),
                  ProfileListItemWidget(
                    iconName: 'location_on',
                    title: 'Delivery Addresses',
                    subtitle: '2 saved addresses',
                    onTap: _navigateToAddresses,
                    showDivider: false,
                  ),
                ],
              ),

              // Order History Section
              ProfileSectionWidget(
                title: 'Recent Orders',
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      children: [
                        OrderHistoryItemWidget(
                          orderId: '12847',
                          date: '2 days ago',
                          status: 'Delivered',
                          total: '\$67.50',
                          itemCount: 8,
                          itemImages: [
                            'https://images.unsplash.com/photo-1610832958506-aa56368176cf?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                            'https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                            'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                          ],
                          onReorder: () => _reorderItems('12847'),
                          onTap: () => _viewOrderDetails('12847'),
                        ),
                        OrderHistoryItemWidget(
                          orderId: '12834',
                          date: '1 week ago',
                          status: 'Delivered',
                          total: '\$43.25',
                          itemCount: 5,
                          itemImages: [
                            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                            'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                          ],
                          onReorder: () => _reorderItems('12834'),
                          onTap: () => _viewOrderDetails('12834'),
                        ),
                        SizedBox(height: 2.h),
                        OutlinedButton(
                          onPressed: _navigateToOrderHistory,
                          child: Text('View All Orders'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Saved Items Section
              ProfileSectionWidget(
                title: 'Saved Items',
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      children: [
                        SavedItemWidget(
                          name: 'Organic Avocados (Pack of 4)',
                          price: '\$8.99',
                          originalPrice: '\$12.99',
                          imageUrl:
                              'https://images.unsplash.com/photo-1610832958506-aa56368176cf?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                          inStock: true,
                          onAddToCart: () => _addToCart('Organic Avocados'),
                          onRemove: () => _removeSavedItem('Organic Avocados'),
                        ),
                        SavedItemWidget(
                          name: 'Fresh Salmon Fillet (1 lb)',
                          price: '\$24.99',
                          originalPrice: '',
                          imageUrl:
                              'https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80',
                          inStock: false,
                          onAddToCart: () => _addToCart('Fresh Salmon Fillet'),
                          onRemove: () =>
                              _removeSavedItem('Fresh Salmon Fillet'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Settings Section
              ProfileSectionWidget(
                title: 'Notification Settings',
                children: [
                  ProfileToggleItemWidget(
                    iconName: 'notifications',
                    title: 'Push Notifications',
                    subtitle: 'Receive order updates and offers',
                    value: _pushNotifications,
                    onChanged: (value) =>
                        setState(() => _pushNotifications = value),
                  ),
                  ProfileToggleItemWidget(
                    iconName: 'email',
                    title: 'Email Notifications',
                    subtitle: 'Receive newsletters and promotions',
                    value: _emailNotifications,
                    onChanged: (value) =>
                        setState(() => _emailNotifications = value),
                  ),
                  ProfileToggleItemWidget(
                    iconName: 'local_shipping',
                    title: 'Order Updates',
                    subtitle: 'Get notified about delivery status',
                    value: _orderUpdates,
                    onChanged: (value) => setState(() => _orderUpdates = value),
                  ),
                  ProfileToggleItemWidget(
                    iconName: 'local_offer',
                    title: 'Promotional Offers',
                    subtitle: 'Receive deals and discounts',
                    value: _promotionalOffers,
                    onChanged: (value) =>
                        setState(() => _promotionalOffers = value),
                    showDivider: false,
                  ),
                ],
              ),

              // App Settings Section
              ProfileSectionWidget(
                title: 'App Settings',
                children: [
                  ProfileListItemWidget(
                    iconName: 'payment',
                    title: 'Payment Methods',
                    subtitle: '2 cards saved',
                    onTap: _navigateToPaymentMethods,
                  ),
                  ProfileToggleItemWidget(
                    iconName: 'fingerprint',
                    title: 'Biometric Login',
                    subtitle: 'Use fingerprint or Face ID',
                    value: _biometricLogin,
                    onChanged: (value) =>
                        setState(() => _biometricLogin = value),
                  ),
                  ProfileToggleItemWidget(
                    iconName: 'location_on',
                    title: 'Location Services',
                    subtitle: 'Help find nearby stores',
                    value: _locationServices,
                    onChanged: (value) =>
                        setState(() => _locationServices = value),
                  ),
                  ProfileListItemWidget(
                    iconName: 'language',
                    title: 'Language',
                    trailing: 'English',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Language settings would be implemented here'),
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.tertiary,
                        ),
                      );
                    },
                    showDivider: false,
                  ),
                ],
              ),

              // Support Section
              ProfileSectionWidget(
                title: 'Support & Legal',
                children: [
                  ProfileListItemWidget(
                    iconName: 'help_center',
                    title: 'Help Center',
                    subtitle: 'FAQs and support',
                    onTap: _navigateToHelp,
                  ),
                  ProfileListItemWidget(
                    iconName: 'chat',
                    title: 'Contact Support',
                    subtitle: 'Chat with our team',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Contact support would be implemented here'),
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.tertiary,
                        ),
                      );
                    },
                  ),
                  ProfileListItemWidget(
                    iconName: 'privacy_tip',
                    title: 'Privacy Policy',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Privacy policy would be shown here'),
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.tertiary,
                        ),
                      );
                    },
                  ),
                  ProfileListItemWidget(
                    iconName: 'description',
                    title: 'Terms of Service',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Terms of service would be shown here'),
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.tertiary,
                        ),
                      );
                    },
                    showDivider: false,
                  ),
                ],
              ),

              // Account Management Section
              ProfileSectionWidget(
                title: 'Account Management',
                children: [
                  ProfileListItemWidget(
                    iconName: 'logout',
                    title: 'Logout',
                    onTap: _showLogoutConfirmation,
                    iconColor: AppTheme.lightTheme.colorScheme.error,
                    showArrow: false,
                  ),
                  ProfileListItemWidget(
                    iconName: 'delete_forever',
                    title: 'Delete Account',
                    subtitle: 'Permanently delete your account',
                    onTap: _showDeleteAccountConfirmation,
                    iconColor: AppTheme.lightTheme.colorScheme.error,
                    showArrow: false,
                    showDivider: false,
                  ),
                ],
              ),

              SizedBox(height: 4.h),

              // App Version
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  'Urban Harvest v1.0.0',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),

              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }
}
