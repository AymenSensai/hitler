import 'package:stocks_app/features/products/data/remote/models/category_model.dart';
import 'package:stocks_app/features/products/data/remote/products_api_service.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repo/products_repo.dart';
import '../remote/models/product_model.dart';

class ProductsRepoImpl extends ProductsRepo {
  final ProductsApiService _apiService;

  ProductsRepoImpl(this._apiService);

  @override
  Future<ApiResult<List<ProductEntity>>> getProducts() async {
    try {
      final response = await _apiService.getProducts();
      final entities = response.data.map((model) => model.toEntity()).toList();
      return ApiResult.success(entities);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }

  @override
  Future<ApiResult<void>> addProduct(ProductEntity productRequest) async {
    try {
      await _apiService.addProduct(ProductModel.fromEntity(productRequest));
      return ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }

  @override
  Future<ApiResult<void>> addCategory(String categoryRequest) async {
    try {
      await _apiService.addCategory(CategoryModel(name: categoryRequest));
      return ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }

  @override
  Future<ApiResult<List<CategoryEntity>>> getCategories() async {
    try {
      final response = await _apiService.getCategories();
      final categories = response.data;
      final entities = categories.map((model) => model.toEntity()).toList();
      return ApiResult.success(entities);
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error).apiErrorModel.message,
      );
    }
  }
}
