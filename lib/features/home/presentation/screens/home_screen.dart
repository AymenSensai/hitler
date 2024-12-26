import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/theming/colors.dart';
import 'package:stocks_app/core/theming/styles.dart';
import 'package:stocks_app/core/utils/spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Dark JO',
                style: TextStyles.font16BlackSemiBold,
              ),
              verticalSpace(24),
              Container(
                decoration: BoxDecoration(
                  color: ColorsManager.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary',
                      style: TextStyles.font14WhiteMedium,
                    ),
                    verticalSpace(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sold Quantities'),
                            Text('80'),
                            Text('Earning (DZD)'),
                            Text('4000'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Purchased Quantities'),
                            Text('120'),
                            Text('Spendings (DZD)'),
                            Text('9600'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text('All Items'),
                              Text('1'),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text('All Contacts'),
                              Text('1'),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Text('Analytics')
            ],
          ),
        ),
      ),
    );
  }
}
