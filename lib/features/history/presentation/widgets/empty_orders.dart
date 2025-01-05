import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: ColorsManager.blue.withValues(alpha: 0.2),
                radius: 50.w,
                child: SvgPicture.asset(
                  Assets.historySolid,
                  width: 70.h,
                  height: 70.h,
                ),
              ),
              verticalSpace(24),
              Text(
                'No Orders available!',
                style: TextStyles.font18BlackSemiBold,
                textAlign: TextAlign.center,
              ),
              verticalSpace(16),
              Text(
                'Please place an order to see it here.',
                style: TextStyles.font14BlackRegular.copyWith(height: 2),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
