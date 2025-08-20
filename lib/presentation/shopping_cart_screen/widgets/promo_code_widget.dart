import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class PromoCodeWidget extends StatefulWidget {
  final Function(String) onPromoApplied;

  const PromoCodeWidget({
    Key? key,
    required this.onPromoApplied,
  }) : super(key: key);

  @override
  State<PromoCodeWidget> createState() => _PromoCodeWidgetState();
}

class _PromoCodeWidgetState extends State<PromoCodeWidget> {
  bool _isExpanded = false;
  final TextEditingController _promoController = TextEditingController();
  String? _appliedPromo;
  String? _validationMessage;

  final List<Map<String, dynamic>> _availablePromoCodes = [
    {
      'code': 'SAVE10',
      'description': '10% off on orders above \$30',
      'discount': 0.10,
      'minOrder': 30.0,
    },
    {
      'code': 'FIRST20',
      'description': '20% off for first-time users',
      'discount': 0.20,
      'minOrder': 0.0,
    },
    {
      'code': 'FRESH15',
      'description': '15% off on fresh produce',
      'discount': 0.15,
      'minOrder': 25.0,
    },
  ];

  void _applyPromoCode() {
    final code = _promoController.text.trim().toUpperCase();

    if (code.isEmpty) {
      setState(() {
        _validationMessage = 'Please enter a promo code';
      });
      return;
    }

    final promo = _availablePromoCodes.firstWhere(
      (p) => (p['code'] as String).toUpperCase() == code,
      orElse: () => {},
    );

    if (promo.isEmpty) {
      setState(() {
        _validationMessage = 'Invalid promo code';
      });
    } else {
      setState(() {
        _appliedPromo = code;
        _validationMessage = 'Promo code applied successfully!';
        _isExpanded = false;
      });
      widget.onPromoApplied(code);
    }
  }

  void _removePromoCode() {
    setState(() {
      _appliedPromo = null;
      _promoController.clear();
      _validationMessage = null;
    });
    widget.onPromoApplied('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline,
        ),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'local_offer',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 6.w,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _appliedPromo != null
                              ? 'Promo Code Applied: $_appliedPromo'
                              : 'Apply Promo Code',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: _appliedPromo != null
                                ? AppTheme.lightTheme.colorScheme.tertiary
                                : AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (_appliedPromo == null)
                          Text(
                            'Get discounts on your order',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (_appliedPromo != null)
                    IconButton(
                      onPressed: _removePromoCode,
                      icon: CustomIconWidget(
                        iconName: 'close',
                        color: AppTheme.lightTheme.colorScheme.error,
                        size: 5.w,
                      ),
                    ),
                  CustomIconWidget(
                    iconName: _isExpanded
                        ? 'keyboard_arrow_up'
                        : 'keyboard_arrow_down',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 6.w,
                  ),
                ],
              ),
            ),
          ),

          // Expanded Content
          if (_isExpanded && _appliedPromo == null) ...[
            Divider(
              color: AppTheme.lightTheme.colorScheme.outline,
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Promo Code Input
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _promoController,
                          decoration: InputDecoration(
                            hintText: 'Enter promo code',
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(3.w),
                              child: CustomIconWidget(
                                iconName: 'confirmation_number',
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                                size: 5.w,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.5.h,
                            ),
                          ),
                          textCapitalization: TextCapitalization.characters,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      ElevatedButton(
                        onPressed: _applyPromoCode,
                        child: Text('Apply'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.5.h,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Validation Message
                  if (_validationMessage != null) ...[
                    SizedBox(height: 1.h),
                    Text(
                      _validationMessage!,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: _validationMessage!.contains('successfully')
                            ? AppTheme.lightTheme.colorScheme.tertiary
                            : AppTheme.lightTheme.colorScheme.error,
                      ),
                    ),
                  ],

                  SizedBox(height: 2.h),

                  // Available Promo Codes
                  Text(
                    'Available Offers:',
                    style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 1.h),

                  ..._availablePromoCodes
                      .map((promo) => Container(
                            margin: EdgeInsets.only(bottom: 1.h),
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: AppTheme
                                  .lightTheme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        promo['code'] as String,
                                        style: AppTheme
                                            .lightTheme.textTheme.labelLarge
                                            ?.copyWith(
                                          color: AppTheme
                                              .lightTheme.colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        promo['description'] as String,
                                        style: AppTheme
                                            .lightTheme.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _promoController.text =
                                        promo['code'] as String;
                                    _applyPromoCode();
                                  },
                                  child: Text('Use Code'),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }
}
