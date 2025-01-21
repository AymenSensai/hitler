import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/theming/colors.dart';
import 'package:stocks_app/core/theming/styles.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/core/widgets/animated_loading.dart';
import 'package:stocks_app/features/home/domain/entities/dashboard_entity.dart';
import 'package:stocks_app/features/home/presentation/controllers/home_cubit.dart';
import 'package:stocks_app/features/home/presentation/widgets/sales_purchase_chart.dart';

import '../../../../core/utils/error_snackbar.dart';
import '../controllers/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listenWhen: (previous, current) => current is GetDashboardDataError,
          listener: (context, state) {
            switch (state) {
              case GetDashboardDataError():
                _setupError(context, state.error);
              default:
            }
          },
          buildWhen: (previous, current) =>
              current is GetDashboardDataLoading ||
              current is GetDashboardDataSuccess ||
              current is GetDashboardDataError,
          builder: (context, state) {
            switch (state) {
              case GetDashboardDataLoading():
                return const AnimatedLoading();
              case GetDashboardDataSuccess():
                return _setupSuccess(state.dashboard);
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _setupSuccess(DashboardEntity dashboard) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: 50.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  style: TextStyles.font18WhiteMedium,
                ),
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sold Quantities',
                          style: TextStyles.font14WhiteRegular,
                        ),
                        verticalSpace(4),
                        Text(
                          dashboard.soldQuantities.toString(),
                          style: TextStyles.font16WhiteMedium,
                        ),
                        verticalSpace(8),
                        Text(
                          'Earning (DZD)',
                          style: TextStyles.font14WhiteRegular,
                        ),
                        verticalSpace(4),
                        Text(
                          double.parse(dashboard.earnings).abs().toString(),
                          style: TextStyles.font16WhiteMedium,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Purchased Quantities',
                          style: TextStyles.font14WhiteRegular,
                        ),
                        verticalSpace(4),
                        Text(
                          dashboard.purchasedQuantities.toString(),
                          style: TextStyles.font16WhiteMedium,
                        ),
                        verticalSpace(8),
                        Text(
                          'Spendings (DZD)',
                          style: TextStyles.font14WhiteRegular,
                        ),
                        verticalSpace(4),
                        Text(
                          dashboard.spendings.toString(),
                          style: TextStyles.font16WhiteMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          verticalSpace(16),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorsManager.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 8.w,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsManager.blue.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.shopping_basket_outlined,
                            color: ColorsManager.blue,
                            size: 30,
                          ),
                        ),
                        horizontalSpace(8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Products',
                              style: TextStyles.font14BlackRegular,
                            ),
                            Text(
                              dashboard.productCount.toString(),
                              style: TextStyles.font16BlackSemiBold,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              horizontalSpace(16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorsManager.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 8.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.orange,
                            size: 30,
                          ),
                        ),
                        horizontalSpace(8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Contacts',
                              style: TextStyles.font14BlackRegular,
                            ),
                            Text(
                              dashboard.contactCount.toString(),
                              style: TextStyles.font16BlackSemiBold,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(16),
          Text(
            'Analytics',
            style: TextStyles.font16BlackSemiBold,
          ),
          verticalSpace(16),
          SalesPurchaseChart(
            salesData: dashboard.salesData,
            purchaseData: dashboard.purchaseData,
          ),
        ],
      ),
    );
  }

  void _setupError(BuildContext context, String? error) {
    errorSnackbar(context, error);
  }
}
