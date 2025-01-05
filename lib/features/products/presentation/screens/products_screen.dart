import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/core/routing/routes.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/core/widgets/top_app_bar.dart';
import 'package:stocks_app/features/products/presentation/controllers/products_cubit.dart';

import '../../../../core/widgets/connectivity_wrapper.dart';
import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../widgets/products_bloc_consumer.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: 'Products',
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(Routes.addProduct),
            icon: Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: CustomRefreshIndicator(
        onRefresh: () => _refreshData(context),
        child: ConnectivityWrapper(
          child: ProductsBlocConsumer(),
        ),
      ),
    );
  }

  Future<void> _refreshData(BuildContext context) async {
    context.read<ProductsCubit>().getProducts();
  }
}
