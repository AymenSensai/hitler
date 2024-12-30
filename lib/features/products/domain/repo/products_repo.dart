import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/networking/api_result.dart';
import '../entities/category_entity.dart';

abstract class ProductsRepo {
  Future<ApiResult<List<ProductEntity>>> getProducts();
  Future<ApiResult<void>> addProduct(ProductEntity productRequest);
  Future<ApiResult<void>> addCategory(String categoryRequest);
  Future<ApiResult<List<CategoryEntity>>> getCategories();
}
