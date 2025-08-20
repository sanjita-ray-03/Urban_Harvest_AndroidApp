import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ProductImageCarousel extends StatefulWidget {
  final List<String> images;
  final String productName;

  const ProductImageCarousel({
    Key? key,
    required this.images,
    required this.productName,
  }) : super(key: key);

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  TransformationController _transformationController =
      TransformationController();

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 50.h,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                transformationController: _transformationController,
                minScale: 1.0,
                maxScale: 3.0,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CustomImageWidget(
                    imageUrl: widget.images[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 2.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                  width: _currentIndex == index ? 3.w : 2.w,
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(1.w),
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
