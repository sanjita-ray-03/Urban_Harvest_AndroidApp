import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PromoCodeWidget extends StatefulWidget {
  final String? appliedPromoCode;
  final double? discountAmount;
  final Function(String) onPromoCodeApplied;
  final VoidCallback? onPromoCodeRemoved;

  const PromoCodeWidget({
    super.key,
    this.appliedPromoCode,
    this.discountAmount,
    required this.onPromoCodeApplied,
    this.onPromoCodeRemoved,
  });

  @override
  State<PromoCodeWidget> createState() => _PromoCodeWidgetState();
}

class _PromoCodeWidgetState extends State<PromoCodeWidget> {
  final TextEditingController _promoController = TextEditingController();
  bool _isApplying = false;

  @override
  void initState() {
    super.initState();
    if (widget.appliedPromoCode != null) {
      _promoController.text = widget.appliedPromoCode!;
    }
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  Future<void> _applyPromoCode() async {
    if (_promoController.text.trim().isEmpty) return;

    setState(() {
      _isApplying = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    widget.onPromoCodeApplied(_promoController.text.trim());

    setState(() {
      _isApplying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'local_offer',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Promo Code',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          if (widget.appliedPromoCode != null &&
              widget.discountAmount != null) ...[
            _buildAppliedPromoCode(),
          ] else ...[
            _buildPromoCodeInput(),
          ],
        ],
      ),
    );
  }

  Widget _buildAppliedPromoCode() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'check_circle',
            color: AppTheme.lightTheme.colorScheme.secondary,
            size: 20,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.appliedPromoCode!,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.secondary,
                  ),
                ),
                Text(
                  'Discount: -\$${widget.discountAmount!.toStringAsFixed(2)}',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          if (widget.onPromoCodeRemoved != null)
            IconButton(
              onPressed: widget.onPromoCodeRemoved,
              icon: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 18,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _promoController,
            decoration: InputDecoration(
              hintText: 'Enter promo code',
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'local_offer',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  width: 2,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w),
            ),
            textCapitalization: TextCapitalization.characters,
          ),
        ),
        SizedBox(width: 3.w),
        ElevatedButton(
          onPressed: _isApplying ? null : _applyPromoCode,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.w),
          ),
          child: _isApplying
              ? SizedBox(
                  width: 4.w,
                  height: 4.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.lightTheme.colorScheme.onPrimary,
                    ),
                  ),
                )
              : Text('Apply'),
        ),
      ],
    );
  }
}
