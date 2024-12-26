import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/utils/error_snackbar.dart';
import '../../../../core/widgets/animated_loading.dart';
import '../controllers/products_cubit.dart';
import '../controllers/products_state.dart';
import 'empty_products.dart';
import 'products_list_view.dart';

class ProductsBlocConsumer extends StatelessWidget {
  const ProductsBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) =>
          current is GetProductsLoading ||
          current is GetProductsSuccess ||
          current is GetProductsError,
      builder: (context, state) {
        switch (state) {
          case GetProductsLoading():
            return const AnimatedLoading();
          case GetProductsSuccess():
            return _setupSuccess(state.products);
          default:
            return const SizedBox.shrink();
        }
      },
      listenWhen: (previous, current) => current is GetProductsError,
      listener: (context, state) {
        switch (state) {
          case GetProductsError():
            _setupError(context, state.error);
          default:
        }
      },
    );
  }

  Widget _setupSuccess(List<ProductEntity> products) {
    return products.isNotEmpty
        ? ProductsListView(products: products)
        : const EmptyProducts();
  }

  void _setupError(BuildContext context, String? error) {
    errorSnackbar(context, error);
  }
}
