import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PaymentMethodWidget extends StatefulWidget {
  final List<Map<String, dynamic>> savedCards;
  final String? selectedPaymentId;
  final Function(String) onPaymentSelected;
  final VoidCallback onAddNewPayment;

  const PaymentMethodWidget({
    super.key,
    required this.savedCards,
    this.selectedPaymentId,
    required this.onPaymentSelected,
    required this.onAddNewPayment,
  });

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIconWidget(
              iconName: 'payment',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 20,
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                'Payment Method',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: widget.onAddNewPayment,
              icon: CustomIconWidget(
                iconName: 'add',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 16,
              ),
              label: Text(
                'Add New',
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Column(
          children: [
            ...widget.savedCards.map((card) => _buildPaymentCard(card)),
            SizedBox(height: 2.h),
            _buildDigitalPaymentOptions(),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> card) {
    final isSelected = widget.selectedPaymentId == card['id'];

    return GestureDetector(
      onTap: () => widget.onPaymentSelected(card['id'] as String),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1)
              : AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.lightTheme.colorScheme.primary
                : AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: _getCardColor(card['type'] as String? ?? 'visa'),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  _getCardIcon(card['type'] as String? ?? 'visa'),
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '**** **** **** ${card['lastFour'] ?? '0000'}',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'Expires ${card['expiry'] ?? '00/00'}',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDigitalPaymentOptions() {
    return Column(
      children: [
        _buildDigitalPaymentOption(
          'apple_pay',
          'Apple Pay',
          'apple',
          Colors.black,
        ),
        SizedBox(height: 2.h),
        _buildDigitalPaymentOption(
          'google_pay',
          'Google Pay',
          'google',
          Colors.blue,
        ),
      ],
    );
  }

  Widget _buildDigitalPaymentOption(
      String id, String name, String iconName, Color color) {
    final isSelected = widget.selectedPaymentId == id;

    return GestureDetector(
      onTap: () => widget.onPaymentSelected(id),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1)
              : AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.lightTheme.colorScheme.primary
                : AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'payment',
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                name,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Color _getCardColor(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return Colors.blue;
      case 'mastercard':
        return Colors.red;
      case 'amex':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getCardIcon(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return 'VISA';
      case 'mastercard':
        return 'MC';
      case 'amex':
        return 'AMEX';
      default:
        return 'CARD';
    }
  }
}
