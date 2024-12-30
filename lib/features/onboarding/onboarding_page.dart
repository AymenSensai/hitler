import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theming/styles.dart';
import '../../core/utils/spacing.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            height: 300.w,
            width: 300.w,
          ),
          verticalSpace(40),
          Text(
            title,
            style: TextStyles.font24BlackBold,
          ),
          verticalSpace(24),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyles.font16BlackMedium,
          ),
        ],
      ),
    );
  }
}
