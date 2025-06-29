import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/images/onboarding1.png', // صورة العامل
      'title': 'Welcome to FixIt',
      'desc': 'Discover a world of convenience and reliability. FixIt is your one stop solution for all your home service needs',
    },
    {
      'image': 'assets/images/onboarding2.png', // صورة تنظيف
      'title': 'Find Services',
      'desc': 'Browse and book a wide range of services from plumbing and electrical to appliance repair. We\'ve got it all covered',
    },
    {
      'image': 'assets/images/onboarding3.png', // صورة الصيانة
      'title': 'Find Services',
      'desc': 'Browse and book a wide range of services from plumbing and electrical to appliance repair. We\'ve got it all covered',
    },
  ];

  void _goToSignUp() {
    Navigator.pushReplacementNamed(context, '/SignupScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0056A5),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (context, i) {
                final page = _pages[i];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 48.h),
                      Container(
                        width: 220.w,
                        height: 220.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0072CE),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          page['image']!,
                          width: 150.w,
                          height: 170.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Text(
                        page['title']!,
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        page['desc']!,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),
                      SizedBox(
                        width: double.infinity,
                        height: 52.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0072CE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (_currentPage == _pages.length - 1) {
                              _goToSignUp();
                            } else {
                              _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                            }
                          },
                          child: Text(
                            _currentPage == _pages.length - 1 ? 'Start' : 'Next',
                            style: TextStyle(fontSize: 17.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_pages.length, (j) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: _currentPage == j ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == j ? Colors.white : Colors.white38,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        )),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: 24.h,
              right: 24.w,
              child: GestureDetector(
                onTap: _goToSignUp,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
