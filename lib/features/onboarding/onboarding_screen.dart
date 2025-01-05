import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stocks_app/core/theming/styles.dart';
import 'package:stocks_app/core/utils/shared_pref_helper.dart';
import 'package:stocks_app/core/utils/spacing.dart';

import '../../core/routing/routes.dart';
import '../../core/theming/colors.dart';
import '../../core/utils/assets.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/extensions.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updatePageIndex);
  }

  @override
  void dispose() {
    _controller.removeListener(_updatePageIndex);
    _controller.dispose();
    super.dispose();
  }

  void _updatePageIndex() {
    final newIndex = _controller.page!.round();
    if (_pageIndex != newIndex) {
      setState(() {
        _pageIndex = newIndex;
      });
    }
  }

  Future<void> _completeOnboarding(BuildContext context) async {
    await SharedPrefHelper.setData(SharedPrefKeys.onBoardingSeen, true);
    if (!context.mounted) return;
    context.pushReplacementNamed(Routes.signIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _controller,
            children: const [
              OnboardingPage(
                title: "Track Your Inventory",
                description:
                    "Keep an eye on stock levels with ease, all in one place.",
                image: Assets.trackInventory,
              ),
              OnboardingPage(
                title: "Real-Time Updates",
                description:
                    "Get instant notifications about low stock or new arrivals.",
                image: Assets.realTimeUpdates,
              ),
              OnboardingPage(
                title: "Detailed Insights",
                description:
                    "Analyze your stock trends and sales to optimize inventory.",
                image: Assets.insights,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_pageIndex != 2)
                  TextButton(
                    onPressed: () => _completeOnboarding(context),
                    child: Text(
                      'Skip',
                      style: TextStyles.font14BlackMedium,
                    ),
                  )
                else
                  horizontalSpace(60.w),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(
                    activeDotColor: ColorsManager.blue,
                    dotColor: ColorsManager.grey,
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_pageIndex == 2) {
                      await _completeOnboarding(context);
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: _pageIndex == 2
                      ? Text(
                          'Done',
                          style: TextStyles.font14BlackMedium,
                        )
                      : Icon(
                          Icons.arrow_forward,
                          color: ColorsManager.black,
                          size: 18.w,
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
