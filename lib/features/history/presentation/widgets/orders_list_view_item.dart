import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/routing/routes.dart';
import 'package:stocks_app/core/theming/colors.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/core/utils/spacing.dart';
import 'package:stocks_app/features/history/domain/entities/history_entity.dart';
import '../../../../core/theming/styles.dart';

class OrdersListViewItem extends StatelessWidget {
  const OrdersListViewItem({super.key, required this.order});
  final HistoryEntity order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(
        Routes.updateStockDetails,
        arguments: order,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.products.firstOrNull?.name ?? 'Product',
              style: TextStyles.font14BlackMedium,
            ),
            verticalSpace(16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                horizontalSpace(8),
                Text(
                  order.formattedTransactionDate,
                  style: TextStyles.font12BlackRegular,
                ),
                Spacer(),
                order.products.firstOrNull!.pivot.quantity > -1
                    ? Icon(
                        Icons.arrow_upward_outlined,
                        color: Colors.green,
                        size: 24,
                      )
                    : Icon(
                        Icons.arrow_downward_outlined,
                        color: ColorsManager.red,
                        size: 24,
                      ),
                horizontalSpace(8),
                Text(
                  order.products.firstOrNull?.pivot.quantity.toString() ?? '0',
                  style: TextStyles.font16BlackSemiBold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
