import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/widgets/language_switcher.dart';
import '../model/on_boarding_model.dart';
import '../widgets/on_boarding_content.dart';
import '../widgets/on_boarding_gradient_overlay.dart';
import '../widgets/on_boarding_page_item.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<OnBoardingModel> get _pages => OnBoardingModel.onBoardingList;
  bool get _isFirst => _currentIndex == 0;
  bool get _isSecond => _currentIndex == 1;
  bool get _isLast => _currentIndex == _pages.length - 1;

  Future<void> _completeOnBoarding() async {
    final prefs = sl<SharedPreferences>();
    await prefs.setBool(CacheConstants.onBoardingKey, false);
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
    }
  }

  void _handleNext() {
    if (_isLast) {
      _completeOnBoarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleBack() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPageData = _pages[_currentIndex];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildBackgroundPages(),
            OnBoardingGradientOverlay(gradientColor: currentPageData.gradientColor),
            OnBoardingContent(
              model: currentPageData,
              isFirst: _isFirst,
              isLast: _isLast,
              isSecond: _isSecond,
              onNext: _handleNext,
              onBack: _handleBack,
            ),
            Positioned(
              top: 50.h,
              right: 20.w,
              child: const LanguageSwitcher(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundPages() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _pages.length,
      onPageChanged: (index) => setState(() => _currentIndex = index),
      itemBuilder: (context, index) => OnBoardingPageItem(model: _pages[index]),
    );
  }
}
