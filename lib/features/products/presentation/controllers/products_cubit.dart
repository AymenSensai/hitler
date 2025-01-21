import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stocks_app/features/products/domain/entities/category_entity.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';
import 'package:stocks_app/features/products/presentation/controllers/products_state.dart';

import '../../data/remote/models/order_request_body.dart';
import '../../data/remote/models/product_request_body.dart';
import '../../domain/repo/products_repo.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepo) : super(ProductsInitial());

  final ProductsRepo _productsRepo;
  final List<String> categories = [];
  final List<CategoryEntity> categoriesEntities = [];
  final List<ProductEntity> products = [];

  Future<void> getProducts() async {
    emit(GetProductsLoading());
    final response = await _productsRepo.getProducts();
    response.when(
      success: (response) {
        products.clear();
        products.addAll(response);
        emit(GetProductsSuccess(products: response));
      },
      failure: (error) {
        emit(GetProductsError(error: error));
      },
    );
  }

  Future<void> addProduct(ProductRequestBody productRequest) async {
    emit(AddProductLoading());
    final response = await _productsRepo.addProduct(productRequest);
    response.when(
      success: (response) {
        getProducts();
        emit(AddProductSuccess());
      },
      failure: (error) {
        emit(AddProductError(error: error));
      },
    );
  }

  Future<void> updateProduct(ProductRequestBody productRequest) async {
    emit(UpdateProductLoading());
    final response = await _productsRepo.updateProduct(productRequest);
    response.when(
      success: (response) {
        getProducts();
        emit(UpdateProductSuccess());
      },
      failure: (error) {
        emit(UpdateProductError(error: error));
      },
    );
  }

  Future<void> addCategory(String categoryRequest) async {
    final response = await _productsRepo.addCategory(categoryRequest);
    response.when(
      success: (response) {
        categories.add(categoryRequest);
        emit(GetCategoriesSuccess());
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
        categoriesEntities.clear();
        categoriesEntities.addAll(response);
        emit(GetCategoriesSuccess());
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

  Future<void> deleteProduct(int id) async {
    emit(DeleteProductLoading());
    final response = await _productsRepo.deleteProduct(id);
    response.when(
      success: (response) {
        emit(DeleteProductSuccess());
        getProducts();
      },
      failure: (error) {
        emit(DeleteProductError(error: error));
      },
    );
  }

  Future<void> searchProducts(String query) async {
    emit(GetProductsLoading());
    final searchedProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.sku.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(GetProductsSuccess(products: searchedProducts));
  }

  Future<void> placeOrder(OrderRequestBody order) async {
    emit(PlaceOrderLoading());
    final response = await _productsRepo.placeOrder(order);
    response.when(
      success: (response) {
        getProducts();
        emit(PlaceOrderSuccess());
      },
      failure: (error) {
        emit(PlaceOrderError(error: error));
      },
    );
  }
}
