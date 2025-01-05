import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/error_snackbar.dart';
import '../../../../core/widgets/animated_loading.dart';
import '../../domain/entities/history_entity.dart';
import '../controllers/history_cubit.dart';
import '../controllers/history_state.dart';
import 'empty_orders.dart';
import 'orders_list_view.dart';

class HistoryBlocConsumer extends StatelessWidget {
  const HistoryBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      buildWhen: (previous, current) =>
          current is GetOrdersLoading ||
          current is GetOrdersSuccess ||
          current is GetOrdersError,
      builder: (context, state) {
        switch (state) {
          case GetOrdersLoading():
            return const AnimatedLoading();
          case GetOrdersSuccess():
            return _setupSuccess(state.orders);
          default:
            return const SizedBox.shrink();
        }
      },
      listenWhen: (previous, current) => current is GetOrdersError,
      listener: (context, state) {
        switch (state) {
          case GetOrdersError():
            _setupError(context, state.error);
          default:
        }
      },
    );
  }

  Widget _setupSuccess(List<HistoryEntity> orders) {
    return orders.isNotEmpty
        ? OrdersListView(orders: orders)
        : const EmptyOrders();
  }

  void _setupError(BuildContext context, String? error) {
    errorSnackbar(context, error);
  }
}
