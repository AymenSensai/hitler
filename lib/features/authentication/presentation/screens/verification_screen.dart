import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/top_app_bar.dart';
import '../widgets/otp_input_field.dart';
import '../widgets/otp_timer_display.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(title: ''),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(
                //   Assets.emailSent,
                //   width: 120.w,
                //   height: 120.w,
                //   fit: BoxFit.contain,
                // ),
                verticalSpace(16),
                Text(
                  'أدخل رمز التحقق',
                  style: TextStyles.font24BlackBold,
                ),
                verticalSpace(4),
                Text(
                  'يرجى إدخال رمز التحقق المرسل للبريد الألكتروني',
                  style: TextStyles.font16LightBlackRegular,
                ),
                verticalSpace(8),
                Container(
                  decoration: BoxDecoration(
                    color: ColorsManager.grey,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.pen,
                        width: 24.h,
                        height: 24.h,
                      ),
                      horizontalSpace(4),
                      Text(
                        email,
                        style: TextStyles.font16LightBlackRegular,
                      ),
                    ],
                  ),
                ),
                verticalSpace(24),
                OtpInputField(),
                verticalSpace(16),
                OtpTimerDisplay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
