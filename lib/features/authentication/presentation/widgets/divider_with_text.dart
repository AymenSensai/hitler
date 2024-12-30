import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(thickness: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(text, style: TextStyles.font12LightBlackRegular),
        ),
        const Expanded(
          child: Divider(thickness: 1),
        ),
      ],
    );
  }
}
