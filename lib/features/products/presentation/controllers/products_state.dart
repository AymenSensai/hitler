import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

sealed class ProductsState<T> {}

class ProductsInitial<T> extends ProductsState<T> {}

class GetProductsLoading<T> extends ProductsState<T> {}

class GetProductsSuccess<T> extends ProductsState<T> {
  final List<ProductEntity> products;
  GetProductsSuccess({required this.products});
}

class GetProductsError<T> extends ProductsState<T> {
  final String? error;
  GetProductsError({required this.error});
}

class AddProductLoading<T> extends ProductsState<T> {}

class AddProductSuccess<T> extends ProductsState<T> {}

class AddProductError<T> extends ProductsState<T> {
  final String? error;
  AddProductError({required this.error});
}
