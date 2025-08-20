import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/delivery_address_widget.dart';
import './widgets/delivery_time_slot_widget.dart';
import './widgets/order_summary_widget.dart';
import './widgets/order_total_widget.dart';
import './widgets/payment_method_widget.dart';
import './widgets/promo_code_widget.dart';
import './widgets/security_badges_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isOrderSummaryExpanded = false;
  bool _isPlacingOrder = false;
  String? _selectedTimeSlotId;
  String? _selectedPaymentId;
  String? _appliedPromoCode;
  double? _discountAmount;

  // Mock data
  final Map<String, dynamic> _selectedAddress = {
    "id": "addr_1",
    "name": "John Smith",
    "address":
        "123 Oak Street, Apartment 4B, Downtown District, New York, NY 10001",
    "phone": "+1 (555) 123-4567",
    "isDefault": true,
  };

  final List<Map<String, dynamic>> _timeSlots = [
    {
      "id": "slot_1",
      "timeRange": "9:00 AM - 11:00 AM",
      "date": "Today",
      "extraFee": 0.0,
      "available": true,
    },
    {
      "id": "slot_2",
      "timeRange": "11:00 AM - 1:00 PM",
      "date": "Today",
      "extraFee": 2.99,
      "available": true,
    },
    {
      "id": "slot_3",
      "timeRange": "2:00 PM - 4:00 PM",
      "date": "Today",
      "extraFee": 0.0,
      "available": true,
    },
    {
      "id": "slot_4",
      "timeRange": "6:00 PM - 8:00 PM",
      "date": "Tomorrow",
      "extraFee": 4.99,
      "available": true,
    },
  ];

  final List<Map<String, dynamic>> _cartItems = [
    {
      "id": "prod_1",
      "name": "Fresh Organic Bananas",
      "image":
          "https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "price": 3.99,
      "quantity": 2,
      "unit": "bunch",
    },
    {
      "id": "prod_2",
      "name": "Whole Grain Bread",
      "image":
          "https://images.pexels.com/photos/1775043/pexels-photo-1775043.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "price": 4.49,
      "quantity": 1,
      "unit": "loaf",
    },
    {
      "id": "prod_3",
      "name": "Greek Yogurt",
      "image":
          "https://images.pexels.com/photos/1435735/pexels-photo-1435735.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "price": 5.99,
      "quantity": 3,
      "unit": "container",
    },
    {
      "id": "prod_4",
      "name": "Fresh Spinach",
      "image":
          "https://images.pexels.com/photos/2325843/pexels-photo-2325843.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "price": 2.99,
      "quantity": 1,
      "unit": "bag",
    },
  ];

  final List<Map<String, dynamic>> _savedCards = [
    {
      "id": "card_1",
      "type": "visa",
      "lastFour": "4532",
      "expiry": "12/26",
      "isDefault": true,
    },
    {
      "id": "card_2",
      "type": "mastercard",
      "lastFour": "8901",
      "expiry": "08/25",
      "isDefault": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedTimeSlotId = _timeSlots.first['id'] as String;
    _selectedPaymentId = (_savedCards.firstWhere(
      (card) => card['isDefault'] == true,
      orElse: () => _savedCards.first,
    ))['id'] as String;
  }

  double get _subtotal {
    return _cartItems.fold(0.0, (sum, item) {
      final price = item['price'] as double? ?? 0.0;
      final quantity = item['quantity'] as int? ?? 0;
      return sum + (price * quantity);
    });
  }

  double get _deliveryFee => 4.99;
  double get _taxes => _subtotal * 0.08;

  double? get _deliverySlotFee {
    if (_selectedTimeSlotId == null) return null;
    final slot = _timeSlots.firstWhere(
      (slot) => slot['id'] == _selectedTimeSlotId,
      orElse: () => <String, dynamic>{},
    );
    return slot['extraFee'] as double?;
  }

  void _onChangeAddress() {
    // Show address selection modal
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Text(
                'Select Delivery Address',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Address selection functionality would be implemented here',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTimeSlotSelected(String slotId) {
    setState(() {
      _selectedTimeSlotId = slotId;
    });
  }

  void _onPaymentSelected(String paymentId) {
    setState(() {
      _selectedPaymentId = paymentId;
    });
  }

  void _onAddNewPayment() {
    // Show add payment modal
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Text(
                'Add New Payment Method',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Payment method addition functionality would be implemented here',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPromoCodeApplied(String promoCode) {
    // Mock promo code validation
    final validPromoCodes = {
      'SAVE10': 10.0,
      'WELCOME5': 5.0,
      'FIRST20': 20.0,
    };

    setState(() {
      if (validPromoCodes.containsKey(promoCode.toUpperCase())) {
        _appliedPromoCode = promoCode.toUpperCase();
        _discountAmount = validPromoCodes[promoCode.toUpperCase()];
      } else {
        _appliedPromoCode = null;
        _discountAmount = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Invalid promo code. Try SAVE10, WELCOME5, or FIRST20'),
            backgroundColor: AppTheme.lightTheme.colorScheme.error,
          ),
        );
      }
    });
  }

  void _onPromoCodeRemoved() {
    setState(() {
      _appliedPromoCode = null;
      _discountAmount = null;
    });
  }

  Future<void> _placeOrder() async {
    if (_selectedPaymentId == null || _selectedTimeSlotId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select payment method and delivery time'),
          backgroundColor: AppTheme.lightTheme.colorScheme.error,
        ),
      );
      return;
    }

    setState(() {
      _isPlacingOrder = true;
    });

    // Haptic feedback
    HapticFeedback.mediumImpact();

    try {
      // Simulate order processing
      await Future.delayed(const Duration(seconds: 3));

      // Success haptic feedback
      HapticFeedback.heavyImpact();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Order placed successfully!'),
            backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
          ),
        );

        // Navigate to order confirmation (would be implemented)
        Navigator.pushReplacementNamed(context, '/home-screen');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to place order. Please try again.'),
            backgroundColor: AppTheme.lightTheme.colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPlacingOrder = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 4.w),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: 'check_circle',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 16,
                ),
                SizedBox(width: 1.w),
                Text(
                  'Step 3 of 3',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Delivery Address Section
                  DeliveryAddressWidget(
                    selectedAddress: _selectedAddress,
                    onChangeAddress: _onChangeAddress,
                  ),
                  SizedBox(height: 4.h),

                  // Delivery Time Slot Section
                  DeliveryTimeSlotWidget(
                    timeSlots: _timeSlots,
                    selectedSlotId: _selectedTimeSlotId,
                    onSlotSelected: _onTimeSlotSelected,
                  ),
                  SizedBox(height: 4.h),

                  // Order Summary Section
                  OrderSummaryWidget(
                    cartItems: _cartItems,
                    isExpanded: _isOrderSummaryExpanded,
                    onToggleExpanded: () {
                      setState(() {
                        _isOrderSummaryExpanded = !_isOrderSummaryExpanded;
                      });
                    },
                  ),
                  SizedBox(height: 4.h),

                  // Payment Method Section
                  PaymentMethodWidget(
                    savedCards: _savedCards,
                    selectedPaymentId: _selectedPaymentId,
                    onPaymentSelected: _onPaymentSelected,
                    onAddNewPayment: _onAddNewPayment,
                  ),
                  SizedBox(height: 4.h),

                  // Promo Code Section
                  PromoCodeWidget(
                    appliedPromoCode: _appliedPromoCode,
                    discountAmount: _discountAmount,
                    onPromoCodeApplied: _onPromoCodeApplied,
                    onPromoCodeRemoved: _onPromoCodeRemoved,
                  ),
                  SizedBox(height: 4.h),

                  // Order Total Section
                  OrderTotalWidget(
                    subtotal: _subtotal,
                    deliveryFee: _deliveryFee,
                    taxes: _taxes,
                    discountAmount: _discountAmount,
                    deliverySlotFee: _deliverySlotFee,
                  ),
                  SizedBox(height: 4.h),

                  // Security Badges
                  const SecurityBadgesWidget(),
                  SizedBox(height: 10.h), // Extra space for bottom button
                ],
              ),
            ),
          ),

          // Bottom Place Order Button
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lightTheme.colorScheme.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: _isPlacingOrder ? null : _placeOrder,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 4.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isPlacingOrder
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 5.w,
                            height: 5.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.lightTheme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            'Processing Order...',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Place Order - \$${(_subtotal + _deliveryFee + _taxes + (_deliverySlotFee ?? 0.0) - (_discountAmount ?? 0.0)).toStringAsFixed(2)}',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
