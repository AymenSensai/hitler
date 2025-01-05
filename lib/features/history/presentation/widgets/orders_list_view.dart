import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stocks_app/core/utils/spacing.dart';

import '../../domain/entities/history_entity.dart';
import 'orders_list_view_item.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key, required this.orders});

  final List<HistoryEntity> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: orders.length,
      separatorBuilder: (context, index) => verticalSpace(16),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrdersListViewItem(order: order);
      },
    );
  }
}
