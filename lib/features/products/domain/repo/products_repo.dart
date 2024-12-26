import 'package:stocks_app/features/products/domain/entities/product_entity.dart';

import '../../../../core/networking/api_result.dart';

abstract class ProductsRepo {
  Future<ApiResult<List<ProductEntity>>> getProducts();
  Future<ApiResult<void>> addProduct(ProductEntity productRequest);
}
