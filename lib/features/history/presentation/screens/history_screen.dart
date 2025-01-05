import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';
import 'package:stocks_app/features/history/presentation/widgets/history_bloc_consumer.dart';

import '../../../../core/widgets/connectivity_wrapper.dart';
import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../controllers/history_cubit.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(title: 'Stock History'),
      body: SafeArea(
        child: CustomRefreshIndicator(
          onRefresh: () => _refreshData(context),
          child: ConnectivityWrapper(
            child: HistoryBlocConsumer(),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshData(BuildContext context) async {
    context.read<HistoryCubit>().getOrders();
  }
}
