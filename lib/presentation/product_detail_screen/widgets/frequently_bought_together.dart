import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class FrequentlyBoughtTogether extends StatefulWidget {
  final Map<String, dynamic> mainProduct;
  final List<Map<String, dynamic>> suggestedProducts;
  final Function(List<Map<String, dynamic>>) onAddBundle;

  const FrequentlyBoughtTogether({
    Key? key,
    required this.mainProduct,
    required this.suggestedProducts,
    required this.onAddBundle,
  }) : super(key: key);

  @override
  State<FrequentlyBoughtTogether> createState() =>
      _FrequentlyBoughtTogetherState();
}

class _FrequentlyBoughtTogetherState extends State<FrequentlyBoughtTogether> {
  List<bool> selectedProducts = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    selectedProducts =
        List.generate(widget.suggestedProducts.length, (index) => true);
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    totalPrice = double.parse(
        widget.mainProduct["price"].toString().replaceAll('\$', ''));
    for (int i = 0; i < widget.suggestedProducts.length; i++) {
      if (selectedProducts[i]) {
        totalPrice += double.parse(widget.suggestedProducts[i]["price"]
            .toString()
            .replaceAll('\$', ''));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frequently Bought Together',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        _buildProductsList(),
        SizedBox(height: 3.h),
        _buildBundlePrice(),
        SizedBox(height: 2.h),
        _buildAddBundleButton(),
      ],
    );
  }

  Widget _buildProductsList() {
    return Column(
      children: [
        _buildProductItem(widget.mainProduct, -1, true),
        ...List.generate(widget.suggestedProducts.length, (index) {
          return _buildProductItem(
              widget.suggestedProducts[index], index, selectedProducts[index]);
        }),
      ],
    );
  }

  Widget _buildProductItem(
      Map<String, dynamic> product, int index, bool isSelected) {
    bool isMainProduct = index == -1;

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: isSelected
              ? AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3)
              : AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          if (!isMainProduct)
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  selectedProducts[index] = value ?? false;
                  _calculateTotalPrice();
                });
              },
            ),
          if (!isMainProduct) SizedBox(width: 2.w),
          Container(
            width: 15.w,
            height: 15.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.w),
              child: CustomImageWidget(
                imageUrl: product["image"] as String,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product["name"] as String,
                  style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  product["brand"] as String,
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
                SizedBox(height: 1.h),
                Text(
                  product["price"] as String,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          if (isMainProduct)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(1.w),
              ),
              child: Text(
                'This item',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBundlePrice() {
    int selectedCount =
        selectedProducts.where((selected) => selected).length + 1;
    double originalTotal = double.parse(
        widget.mainProduct["price"].toString().replaceAll('\$', ''));
    for (var product in widget.suggestedProducts) {
      originalTotal +=
          double.parse(product["price"].toString().replaceAll('\$', ''));
    }
    double savings = originalTotal - totalPrice;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total for $selectedCount items:',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (savings > 0) ...[
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'You save:',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                  ),
                ),
                Text(
                  '\$${savings.toStringAsFixed(2)}',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddBundleButton() {
    List<Map<String, dynamic>> selectedItems = [widget.mainProduct];
    for (int i = 0; i < widget.suggestedProducts.length; i++) {
      if (selectedProducts[i]) {
        selectedItems.add(widget.suggestedProducts[i]);
      }
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => widget.onAddBundle(selectedItems),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.lightTheme.colorScheme.primary,
          foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.w),
          ),
        ),
        child: Text(
          'Add Bundle to Cart - \$${totalPrice.toStringAsFixed(2)}',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
