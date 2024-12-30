import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/features/products/presentation/controllers/products_state.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repo/products_repo.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepo) : super(ProductsInitial());

  final ProductsRepo _productsRepo;
  final List<String> categories = [];

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

  Future<void> addCategory(String categoryRequest) async {
    final response = await _productsRepo.addCategory(categoryRequest);
    response.when(
      success: (response) {
        categories.add(categoryRequest);
      },
      failure: (error) {},
    );
  }

  Future<void> getCategories() async {
    final response = await _productsRepo.getCategories();
    response.when(
      success: (response) {
        categories.clear();
        categories.addAll(response.map((category) => category.name));
      },
      failure: (error) {},
    );
  }

  Future<List<String>> getCategoriesNames(String query) async {
    return query.isNotEmpty
        ? categories
            .where((category) =>
                category.toLowerCase().contains(query.toLowerCase()))
            .toList()
        : [];
  }
}
