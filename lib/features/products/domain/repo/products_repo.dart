import 'package:stocks_app/features/products/data/remote/models/order_request_body.dart';
import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/networking/api_result.dart';
import '../../data/remote/models/product_request_body.dart';
import '../entities/category_entity.dart';

abstract class ProductsRepo {
  Future<ApiResult<List<ProductEntity>>> getProducts();
  Future<ApiResult<void>> addProduct(ProductRequestBody productRequest);
  Future<ApiResult<void>> updateProduct(ProductRequestBody productRequest);
  Future<ApiResult<void>> addCategory(String categoryRequest);
  Future<ApiResult<List<CategoryEntity>>> getCategories();
  Future<ApiResult<void>> deleteProduct(int id);
  Future<ApiResult<void>> placeOrder(OrderRequestBody order);
}
