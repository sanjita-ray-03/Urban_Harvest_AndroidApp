import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PromotionalBannerWidget extends StatefulWidget {
  const PromotionalBannerWidget({super.key});

  @override
  State<PromotionalBannerWidget> createState() =>
      _PromotionalBannerWidgetState();
}

class _PromotionalBannerWidgetState extends State<PromotionalBannerWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _banners = [
    {
      "id": 1,
      "title": "Fresh Organic Vegetables",
      "subtitle": "Up to 30% off on all organic produce",
      "image":
          "https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=800",
      "backgroundColor": Color(0xFFE8F5E8),
    },
    {
      "id": 2,
      "title": "Free Delivery",
      "subtitle": "On orders above \$50",
      "image":
          "https://images.pixabay.com/photo/2017/08/06/12/06/people-2592247_960_720.jpg?auto=compress&cs=tinysrgb&w=800",
      "backgroundColor": Color(0xFFFFF3E0),
    },
    {
      "id": 3,
      "title": "Premium Dairy Products",
      "subtitle": "Farm fresh milk and cheese",
      "image":
          "https://images.unsplash.com/photo-1563636619-e9143da7973b?auto=format&fit=crop&w=800&q=80",
      "backgroundColor": Color(0xFFF3E5F5),
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final nextIndex = (_currentIndex + 1) % _banners.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _startAutoSlide();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.w,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _banners.length,
              itemBuilder: (context, index) {
                final banner = _banners[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                  decoration: BoxDecoration(
                    color: banner["backgroundColor"] as Color,
                    borderRadius: BorderRadius.circular(3.w),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.lightTheme.colorScheme.shadow
                            .withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3.w),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(4.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  banner["title"] as String,
                                  style: AppTheme
                                      .lightTheme.textTheme.titleLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme
                                        .lightTheme.colorScheme.onSurface,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  banner["subtitle"] as String,
                                  style: AppTheme
                                      .lightTheme.textTheme.bodyMedium
                                      ?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: CustomImageWidget(
                            imageUrl: banner["image"] as String,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _banners.length,
              (index) => Container(
                width: _currentIndex == index ? 6.w : 2.w,
                height: 1.h,
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.outline,
                  borderRadius: BorderRadius.circular(1.w),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
