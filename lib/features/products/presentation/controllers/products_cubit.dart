import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/features/products/presentation/controllers/products_state.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repo/products_repo.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepo) : super(ProductsInitial());

  final ProductsRepo _productsRepo;

  Future<void> getProducts() async {
    emit(GetProductsLoading());
    final response = await _productsRepo.getProducts();
    response.when(
      success: (response) {
        emit(GetProductsSuccess(products: response));
      },
      failure: (error) {
        emit(GetProductsError(error: error));
      },
    );
  }

  Future<void> addProduct(ProductEntity productRequest) async {
    emit(AddProductLoading());
    final response = await _productsRepo.addProduct(productRequest);
    response.when(
      success: (response) {
        emit(AddProductSuccess());
      },
      failure: (error) {
        emit(AddProductError(error: error));
      },
    );
  }
}
