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

class UpdateProductLoading<T> extends ProductsState<T> {}

class UpdateProductSuccess<T> extends ProductsState<T> {}

class UpdateProductError<T> extends ProductsState<T> {
  final String? error;
  UpdateProductError({required this.error});
}

class DeleteProductLoading<T> extends ProductsState<T> {}

class DeleteProductSuccess<T> extends ProductsState<T> {}

class DeleteProductError<T> extends ProductsState<T> {
  final String? error;
  DeleteProductError({required this.error});
}

class PlaceOrderLoading<T> extends ProductsState<T> {}

class PlaceOrderSuccess<T> extends ProductsState<T> {}

class PlaceOrderError<T> extends ProductsState<T> {
  final String? error;
  PlaceOrderError({required this.error});
}

class GetCategoriesSuccess<T> extends ProductsState<T> {}
