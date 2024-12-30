import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';
import 'package:stocks_app/features/stock/presentation/controllers/stock_cubit.dart';
import 'package:stocks_app/features/stock/presentation/widgets/select_products_list_view.dart';

class SelectedProductsScreen extends StatelessWidget {
  const SelectedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: 'Selects Products',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SelectProductsListView(
          products: context.read<StockCubit>().products,
        ),
      ),
    );
  }
}
