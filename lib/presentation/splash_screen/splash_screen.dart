import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isLoading = true;
  bool _hasError = false;
  int _retryCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeApp();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      // Simulate app initialization tasks
      await Future.wait([
        _checkAuthenticationStatus(),
        _loadUserPreferences(),
        _fetchProductCategories(),
        _prepareCachedData(),
      ]);

      // Minimum splash display time
      await Future.delayed(const Duration(milliseconds: 3000));

      if (mounted) {
        _navigateToNextScreen();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _checkAuthenticationStatus() async {
    // Simulate authentication check
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<void> _loadUserPreferences() async {
    // Simulate loading user preferences
    await Future.delayed(const Duration(milliseconds: 600));
  }

  Future<void> _fetchProductCategories() async {
    // Simulate fetching product categories
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  Future<void> _prepareCachedData() async {
    // Simulate preparing cached grocery data
    await Future.delayed(const Duration(milliseconds: 700));
  }

  void _navigateToNextScreen() {
    // Navigation logic based on user status
    final bool isAuthenticated = _checkUserAuthentication();
    final bool isFirstTime = _checkFirstTimeUser();

    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/home-screen');
    } else if (isFirstTime) {
      // For now, navigate to login as onboarding is not implemented
      Navigator.pushReplacementNamed(context, '/login-screen');
    } else {
      Navigator.pushReplacementNamed(context, '/login-screen');
    }
  }

  bool _checkUserAuthentication() {
    // Mock authentication check - in real app, check stored tokens
    return false;
  }

  bool _checkFirstTimeUser() {
    // Mock first time user check - in real app, check shared preferences
    return true;
  }

  Future<void> _retryInitialization() async {
    if (_retryCount < 3) {
      _retryCount++;
      await _initializeApp();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppTheme.primaryLight,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryLight,
                AppTheme.primaryVariantLight,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildLogo(),
                                SizedBox(height: 4.h),
                                _buildAppName(),
                                SizedBox(height: 2.h),
                                _buildTagline(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                _buildBottomSection(),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 25.w,
      height: 25.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: CustomIconWidget(
          iconName: 'shopping_cart',
          color: AppTheme.primaryLight,
          size: 12.w,
        ),
      ),
    );
  }

  Widget _buildAppName() {
    return Text(
      'Urban Harvest',
      style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildTagline() {
    return Text(
      'Fresh groceries delivered to your door',
      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
        color: Colors.white.withValues(alpha: 0.9),
        fontSize: 14.sp,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBottomSection() {
    if (_hasError) {
      return _buildErrorSection();
    } else if (_isLoading) {
      return _buildLoadingSection();
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildLoadingSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 6.w,
          height: 6.w,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          'Loading fresh groceries...',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIconWidget(
          iconName: 'error_outline',
          color: Colors.white.withValues(alpha: 0.8),
          size: 6.w,
        ),
        SizedBox(height: 1.h),
        Text(
          'Connection timeout',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 2.h),
        ElevatedButton(
          onPressed: _retryInitialization,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.primaryLight,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.w),
            ),
          ),
          child: Text(
            'Retry',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
