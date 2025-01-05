import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/core/utils/extensions.dart';
import 'package:stocks_app/features/products/presentation/controllers/products_cubit.dart';

import '../../../../core/utils/error_snackbar.dart';
import '../../../../core/widgets/animated_loading.dart';
import '../controllers/products_state.dart';

class AddProductBlocListener extends StatelessWidget {
  const AddProductBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listenWhen: (previous, current) =>
          current is AddProductLoading ||
          current is AddProductSuccess ||
          current is AddProductError,
      listener: (context, state) {
        switch (state) {
          case AddProductLoading():
          case UpdateProductLoading():
            showAnimatedLoading(context);
          case AddProductSuccess():
          case UpdateProductSuccess():
            _setupSuccess(context);
          case AddProductError():
            _setupError(context, state.error);
          case UpdateProductError():
            _setupError(context, state.error);
          default:
            const SizedBox.shrink();
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _setupSuccess(BuildContext context) {
    context.pop();
    context.pop();
  }

  void _setupError(BuildContext context, String? error) {
    context.pop();
    errorSnackbar(context, error);
  }
}

class ProductBlocListener extends StatelessWidget {
  const ProductBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listenWhen: (previous, current) =>
          current is DeleteProductLoading ||
          current is DeleteProductSuccess ||
          current is DeleteProductError ||
          current is PlaceOrderLoading ||
          current is PlaceOrderSuccess ||
          current is PlaceOrderError,
      listener: (context, state) {
        switch (state) {
          case DeleteProductLoading():
          case PlaceOrderLoading():
            showAnimatedLoading(context);
          case DeleteProductSuccess():
            _setupSuccess(context);
          case PlaceOrderSuccess():
            context.pop();
            _setupSuccess(context);
          case DeleteProductError():
            _setupError(context, state.error);
          case PlaceOrderError():
            _setupError(context, state.error);
          default:
            const SizedBox.shrink();
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _setupSuccess(BuildContext context) {
    context.pop();
    context.pop();
  }

  void _setupError(BuildContext context, String? error) {
    context.pop();
    errorSnackbar(context, error);
  }
}
